import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ShipantherLocalizations.of(context)!.resetPassword),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: ShipantherLocalizations.of(context)!.email),
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
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                alignment: Alignment.center,
                child: SignInButtonBuilder(
                  icon: Icons.email,
                  backgroundColor: Colors.green,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<AuthBloc>()
                          .add(ForgotPassword(_userEmail.text));
                      Navigator.pop(context);
                    }
                  },
                  text: ShipantherLocalizations.of(context)!.resetPassword,
                ),
              ),
            ],
          ),
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
