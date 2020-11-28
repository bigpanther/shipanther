import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/reset_password.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(ShipantherLocalizations.of(context).welcome),
      ),
      body: Form(
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
                        return ShipantherLocalizations.of(context)
                            .paramRequired(
                                ShipantherLocalizations.of(context).email);
                      }
                      return null;
                    },
                    onSaved: (val) => setState(() => _userEmail = val),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText:
                            ShipantherLocalizations.of(context).password),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return ShipantherLocalizations.of(context)
                            .paramRequired(
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
                      icon:
                          (widget.authTypeSelector == AuthTypeSelector.register)
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
                    child: Column(
                      children: [
                        TextButton(
                            child: Text(widget.authTypeSelector.otherText),
                            onPressed: () => context.read<AuthBloc>().add(
                                AuthTypeOtherRequest(widget.authTypeSelector))),
                        widget.authTypeSelector == AuthTypeSelector.signIn
                            ? TextButton(
                                child: Text(ShipantherLocalizations.of(context)
                                    .forgotPassword),
                                onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ResetPassword()),
                                    ))
                            : Container(
                                height: 0,
                                width: 0,
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
