import 'package:flutter/material.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ShipantherTextFormField(
              labelText: ShipantherLocalizations.of(context)!.email,
              autocorrect: false,
              controller: _userEmail,
              enableSuggestions: false,
              keyboardType: TextInputType.emailAddress,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return ShipantherLocalizations.of(context)!.paramRequired(
                      ShipantherLocalizations.of(context)!.email);
                }
                return null;
              },
            ),
            Text(ShipantherLocalizations.of(context)!.resetPasswordMessage),
            ShipantherButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context
                      .read<AuthBloc>()
                      .add(ForgotPassword(email: _userEmail.text));
                  Navigator.pop(context);
                }
              },
              labelText: ShipantherLocalizations.of(context)!.resetPassword,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userEmail.dispose();
    super.dispose();
  }
}
