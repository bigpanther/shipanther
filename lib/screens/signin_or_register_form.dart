import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
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
    final localization = ShipantherLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Icon(
                  MdiIcons.truckDelivery,
                  size: 100,
                  color: theme.accentColor,
                ),
                Text(
                  localization.homePageText,
                  style: theme.textTheme.bodyText1!.copyWith(
                    color: theme.hintColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          if (widget.authTypeSelector == AuthTypeSelector.register)
            ShipantherTextFormField(
              controller: _username,
              labelText: localization.name,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return localization.paramRequired(localization.name);
                }
                return null;
              },
            )
          else
            Container(
              height: 0,
              width: 0,
            ),
          ShipantherTextFormField(
            labelText: localization.email,
            autocorrect: false,
            controller: _userEmail,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return localization.paramRequired(localization.email);
              }
              return null;
            },
          ),
          ShipantherPasswordFormField(
            labelText: localization.password,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return localization.paramRequired(localization.password);
              }
              return null;
            },
            controller: _password,
          ),
          if (widget.authTypeSelector == AuthTypeSelector.signIn)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: TextButton(
                  child: Text(
                    localization.forgotPassword,
                    style: theme.textTheme.caption,
                  ),
                  onPressed: () => context.read<AuthBloc>().add(
                        const ForgotPassword(),
                      ),
                ),
              ),
            )
          else
            Container(
              height: 0,
              width: 0,
            ),
          ShipantherButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (widget.authTypeSelector == AuthTypeSelector.register) {
                  context.read<AuthBloc>().add(
                        AuthRegister(
                            _username.text, _userEmail.text, _password.text),
                      );
                } else {
                  context
                      .read<AuthBloc>()
                      .add(AuthSignIn(_userEmail.text, _password.text));
                }
              }
            },
            labelText: widget.authTypeSelector.text,
          ),
          ShipantherButton(
            onPressed: () => context.read<AuthBloc>().add(
                  AuthTypeOtherRequest(widget.authTypeSelector),
                ),
            labelText: (widget.authTypeSelector == AuthTypeSelector.signIn)
                ? localization.register
                : localization.signIn,
            secondary: true,
          ),
        ],
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
