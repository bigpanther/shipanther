import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/reset_password.dart';
import 'package:shipanther/extensions/auth_type_selector_extension.dart';

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
        title: Text(ShipantherLocalizations.of(context).welcome),
      ),
      body: Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (widget.authTypeSelector == AuthTypeSelector.register)
                  TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                        labelText: ShipantherLocalizations.of(context).name),
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ShipantherLocalizations.of(context)
                            .paramRequired(
                                ShipantherLocalizations.of(context).name);
                      }
                      return null;
                    },
                  )
                else
                  Container(
                    width: 0,
                    height: 0,
                  ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: ShipantherLocalizations.of(context).email),
                  autocorrect: false,
                  controller: _userEmail,
                  enableSuggestions: false,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return ShipantherLocalizations.of(context).paramRequired(
                          ShipantherLocalizations.of(context).email);
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: ShipantherLocalizations.of(context).password),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return ShipantherLocalizations.of(context).paramRequired(
                          ShipantherLocalizations.of(context).password);
                    }
                    return null;
                  },
                  controller: _password,
                  obscureText: true,
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
                      if (_formKey.currentState!.validate()) {
                        if (widget.authTypeSelector ==
                            AuthTypeSelector.register) {
                          context.read<AuthBloc>().add(
                                AuthRegister(_username.text, _userEmail.text,
                                    _password.text),
                              );
                        } else {
                          context
                              .read<AuthBloc>()
                              .add(AuthSignIn(_userEmail.text, _password.text));
                        }
                      }
                    },
                    text: widget.authTypeSelector.text,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      TextButton(
                        child: Text(widget.authTypeSelector.otherText),
                        onPressed: () => context.read<AuthBloc>().add(
                              AuthTypeOtherRequest(widget.authTypeSelector),
                            ),
                      ),
                      if (widget.authTypeSelector == AuthTypeSelector.signIn)
                        TextButton(
                            child: Text(ShipantherLocalizations.of(context)
                                .forgotPassword),
                            onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute<Widget>(
                                    builder: (context) => ResetPassword(),
                                  ),
                                ))
                      else
                        Container(
                          height: 0,
                          width: 0,
                        )
                    ],
                  ),
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
