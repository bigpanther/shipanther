import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/blocs/tasks_interactor.dart';
import 'package:shipanther/screens/driver_home_page.dart';
import 'package:shipanther/screens/home.dart';
import 'package:shipanther/tasks_repository_local_storage/key_value_storage.dart';
import 'package:shipanther/tasks_repository_local_storage/reactive_repository.dart';
import 'package:shipanther/tasks_repository_local_storage/repository.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:trober_sdk/api.dart' as api;

class SignInOrRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Shipanther"),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthFailure) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }
        },
        builder: (context, state) {
          return _body(context, state);
        },
      ),
    );
  }

  Widget _body(BuildContext context, AuthState state) {
    if (state is AuthRequested ||
        state is AuthInitial ||
        state is AuthFailure) {
      return SignInOrRegistrationForm(state.authType);
    }
    if (state is AuthFinished) {
      return const ApiLogin();
    }
    if (state is AuthLoading) {
      return const CenteredLoading();
    }
  }
}

class ApiLogin extends StatefulWidget {
  const ApiLogin({Key key}) : super(key: key);

  @override
  _ApiLoginState createState() => _ApiLoginState();
}

class _ApiLoginState extends State<ApiLogin> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserLogin());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) async {
        if (state is UserFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
        if (state is UserLoggedIn) {
          var prefs = await SharedPreferences.getInstance();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(builder: (_) {
              if (state.user.role == api.UserRole.superAdmin) {
                return Home();
              } else {
                return DriverHomeScreen(
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
                );
              }
            }),
          );
        }
      },
      builder: (context, state) {
        if (state is UserFailure) {
          return Container(
            child: Center(
                child: Column(
              children: [
                Text("An error occured during log-in. Please retry."),
                FlatButton(
                    onPressed: () => context.read<AuthBloc>().add(AuthLogout()),
                    child: const Text("Logout"))
              ],
            )),
          );
        }
        return const CenteredLoading();
      },
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
                          context
                              .read<AuthBloc>()
                              .add(AuthRegister(_userEmail, _password));
                        } else {
                          context
                              .read<AuthBloc>()
                              .add(AuthSignIn(_userEmail, _password));
                        }
                      }
                    },
                    text: widget.authTypeSelector.text,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextButton(
                      child: Text(widget.authTypeSelector.otherText),
                      onPressed: () => context
                          .read<AuthBloc>()
                          .add(AuthTypeOtherRequest(widget.authTypeSelector))),
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
}
