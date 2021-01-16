import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/reset_password.dart';
import 'package:shipanther/extensions/auth_type_selector_extension.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';

class SignInOrRegistrationForm extends StatefulWidget {
  const SignInOrRegistrationForm(this.authTypeSelector);
  final AuthTypeSelector authTypeSelector;

  @override
  State<StatefulWidget> createState() => _SignInOrRegistrationFormState();
}

class _SignInOrRegistrationFormState extends State<SignInOrRegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _userEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ShipantherLocalizations.of(context)!.welcome),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (widget.authTypeSelector == AuthTypeSelector.register)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: shipantherTextFormField(
                      controller: _username,
                      labelText: ShipantherLocalizations.of(context)!.name,
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ShipantherLocalizations.of(context)!
                              .paramRequired(
                                  ShipantherLocalizations.of(context)!.name);
                        }
                        return null;
                      },
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      child: Center(
                        child: Text(
                          'Manage your shipping business with ease. Shipanther helps you track your deliveries, update customers and manage orders.',
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: shipantherTextFormField(
                    labelText: ShipantherLocalizations.of(context)!.email,
                    autocorrect: false,
                    controller: _userEmail,
                    enableSuggestions: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return ShipantherLocalizations.of(context)!
                            .paramRequired(
                                ShipantherLocalizations.of(context)!.email);
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ShipantherPasswordFormField(
                    labelText: ShipantherLocalizations.of(context)!.password,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return ShipantherLocalizations.of(context)!
                            .paramRequired(
                                ShipantherLocalizations.of(context)!.password);
                      }
                      return null;
                    },
                    controller: _password,
                  ),
                ),
                if (widget.authTypeSelector == AuthTypeSelector.signIn)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: TextButton(
                          child: Text(
                              ShipantherLocalizations.of(context)!
                                  .forgotPassword,
                              style: Theme.of(context).textTheme.caption),
                          onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute<Widget>(
                                  builder: (context) => ResetPassword(),
                                ),
                              )),
                    ),
                  )
                else
                  Container(
                    height: 0,
                    width: 0,
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: RaisedButton(
                            padding: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (widget.authTypeSelector ==
                                    AuthTypeSelector.register) {
                                  context.read<AuthBloc>().add(
                                        AuthRegister(_username.text,
                                            _userEmail.text, _password.text),
                                      );
                                } else {
                                  context.read<AuthBloc>().add(AuthSignIn(
                                      _userEmail.text, _password.text));
                                }
                              }
                            },
                            child: Text(widget.authTypeSelector.text),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (widget.authTypeSelector == AuthTypeSelector.signIn)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          TextButton(
                            child: Text(
                                ShipantherLocalizations.of(context)!.register),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute<Widget>(
                                settings:
                                    const RouteSettings(name: 'RegisterPage'),
                                builder: (context) =>
                                    const SignInOrRegistrationForm(
                                        AuthTypeSelector.register),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Container(
                    height: 0,
                    width: 0,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _username.dispose();
    _userEmail.dispose();
    _password.dispose();
    super.dispose();
  }
}
