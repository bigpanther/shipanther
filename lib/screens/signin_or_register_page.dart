import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:openapi_dart_common/openapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipanther/blocs/tasks_interactor.dart';
import 'package:shipanther/tasks_repository_local_storage/key_value_storage.dart';
import 'package:shipanther/tasks_repository_local_storage/reactive_repository.dart';
import 'package:shipanther/tasks_repository_local_storage/repository.dart';
import 'package:shipanther/screens/driver_home_page.dart';
import 'package:trober_sdk/api.dart' as api;

final FirebaseAuth _auth = FirebaseAuth.instance;

enum AuthTypeSelector {
  signIn,
  register,
}

class SignInOrRegistrationPage extends StatelessWidget {
  final AuthTypeSelector authTypeSelector;
  final String title;
  SignInOrRegistrationPage(this.authTypeSelector)
      : this.title = (authTypeSelector == AuthTypeSelector.register)
            ? 'Register'
            : 'Sign In';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SignInOrRegistrationForm(authTypeSelector),
    );
  }
}

class SignInOrRegistrationForm extends StatefulWidget {
  final AuthTypeSelector authTypeSelector;
  SignInOrRegistrationForm(this.authTypeSelector);

  @override
  State<StatefulWidget> createState() => _SignInOrRegistrationFormState();
}

class _SignInOrRegistrationFormState extends State<SignInOrRegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _userEmail;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onSaved: (val) => setState(() => _userEmail = val),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  obscureText: true,
                  onSaved: (val) => setState(() => _password = val),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                    icon: (widget.authTypeSelector == AuthTypeSelector.register)
                        ? Icons.person_add
                        : Icons.verified_user,
                    backgroundColor:
                        (widget.authTypeSelector == AuthTypeSelector.register)
                            ? Colors.blueGrey
                            : Colors.orange,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        if (widget.authTypeSelector ==
                            AuthTypeSelector.register) {
                          var success = await _register(_userEmail, _password);
                          if (success) {
                            _signInWithEmailAndPassword(_userEmail, _password);
                          }
                        } else {
                          _signInWithEmailAndPassword(_userEmail, _password);
                        }
                      }
                    },
                    text: (widget.authTypeSelector == AuthTypeSelector.register)
                        ? 'Register'
                        : "Sign In",
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextButton(
                    child: Text(
                      (widget.authTypeSelector == AuthTypeSelector.register)
                          ? "Already registered? Sign In"
                          : 'Not registered? Register now',
                    ),
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                          builder: (_) => SignInOrRegistrationPage(
                              widget.authTypeSelector ==
                                      AuthTypeSelector.register
                                  ? AuthTypeSelector.signIn
                                  : AuthTypeSelector.register)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _register(String username, String password) async {
    try {
      final User user = (await _auth.createUserWithEmailAndPassword(
        email: username,
        password: password,
      ))
          .user;
      if (user != null) {
        return true;
      }
    } catch (e) {
      print(e);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Registration failed"),
      ));
    }
    return false;
  }

  void _signInWithEmailAndPassword(String username, String password) async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: username,
        password: password,
      ))
          .user;
      var token = await user.getIdToken(/* forceRefresh */ true);

      print(token);
      api.DefaultApi d = api.DefaultApi(
          ApiClient(basePath: "https://trober-test.herokuapp.com"));
      d.apiDelegate.apiClient.setDefaultHeader("X-TOKEN", token);
      var auth = ApiKeyAuth("header", "X-TOKEN");
      auth.apiKey = token;
      d.apiDelegate.apiClient.setAuthentication('ApiKeyAuth', auth);
      print(await d.tenantsGet());
      var prefs = await SharedPreferences.getInstance();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
            builder: (_) => DriverHomeScreen(
                  tasksInteractor: TasksInteractor(
                    ReactiveLocalStorageRepository(
                      repository: LocalStorageRepository(
                        localStorage: KeyValueStorage(
                          'trober_tasks',
                          FlutterKeyValueStore(prefs),
                        ),
                      ),
                    ),
                  ),
                )),
      );
    } catch (e) {
      print(e);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in with Email & Password"),
      ));
    }
  }
}
