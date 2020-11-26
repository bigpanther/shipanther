import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/container/home.dart';
import 'package:shipanther/screens/none_home.dart';
import 'package:shipanther/screens/super_admin_home.dart';
import 'package:shipanther/screens/terminal/home.dart';
// import 'package:shipanther/screens/terminal/terminalScreen.dart';
import 'package:shipanther/screens/varify_email.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:trober_sdk/api.dart' as api;

class SignInOrRegistrationPage extends StatefulWidget {
  @override
  _SignInOrRegistrationPageState createState() =>
      _SignInOrRegistrationPageState();
}

class _SignInOrRegistrationPageState extends State<SignInOrRegistrationPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthCheck());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ShipantherLocalizations.of(context).welcome),
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
    print(state);
    if (state is AuthRequested ||
        state is AuthInitial ||
        state is AuthFailure) {
      return SignInOrRegistrationForm(state.authType);
    }
    if (state is AuthFinished) {
      return const ApiLogin();
    }
    if (state is AuthVerification) {
      return VerifyEmail(state.user);
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
    var deviceToken = context.read<AuthRepository>().deviceToken();
    context.read<UserBloc>().add(UserLogin(deviceToken));
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
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(builder: (_) {
              if (state.user.role == api.UserRole.superAdmin) {
                return SuperAdminHome(state.user);
              }
              if (state.user.role == api.UserRole.backOffice) {
                return TerminalScreen(state.user);
              }
              if (state.user.role == api.UserRole.driver) {
                return ContainerScreen(state.user);
              }
              if (state.user.role == api.UserRole.none) {
                return NoneHome(state.user);
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
                    child: Text(ShipantherLocalizations.of(context).logout)),
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

  String _userName;
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
                widget.authTypeSelector == AuthTypeSelector.register
                    ? TextFormField(
                        decoration: InputDecoration(
                            labelText:
                                ShipantherLocalizations.of(context).name),
                        autocorrect: false,
                        enableSuggestions: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return ShipantherLocalizations.of(context)
                                .paramRequired(
                                    ShipantherLocalizations.of(context).name);
                          }
                          return null;
                        },
                        onSaved: (val) => setState(() => _userName = val),
                      )
                    : Container(
                        width: 0,
                        height: 0,
                      ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: ShipantherLocalizations.of(context).email),
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return ShipantherLocalizations.of(context).paramRequired(
                          ShipantherLocalizations.of(context).email);
                    }
                    return null;
                  },
                  onSaved: (val) => setState(() => _userEmail = val),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: ShipantherLocalizations.of(context).password),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return ShipantherLocalizations.of(context).paramRequired(
                          ShipantherLocalizations.of(context).password);
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
                          context.read<AuthBloc>().add(
                              AuthRegister(_userName, _userEmail, _password));
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
