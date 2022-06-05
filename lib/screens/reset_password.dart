import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({this.email = '', super.key});
  final String email;
  @override
  ResetPasswordState createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FormGroup formGroup;
  @override
  void initState() {
    super.initState();
    formGroup = FormGroup({
      'email': FormControl<String>(
        value: widget.email,
        validators: [Validators.required, Validators.email],
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: formGroup,
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ShipantherTextFormField<String>(
              labelText: ShipantherLocalizations.of(context).email,
              autocorrect: false,
              formControlName: 'email',
              enableSuggestions: false,
              keyboardType: TextInputType.emailAddress,
              validationMessages: {
                ValidationMessage.required: ShipantherLocalizations.of(context)
                    .paramRequired(ShipantherLocalizations.of(context).email),
              },
            ),
            Text(ShipantherLocalizations.of(context).resetPasswordMessage),
            ShipantherButton(
              onPressed: () {
                if (formGroup.valid) {
                  context.read<AuthBloc>().add(
                      ForgotPassword(email: formGroup.control('email').value));
                  AutoRouter.of(context).pop();
                }
              },
              labelText: ShipantherLocalizations.of(context).resetPassword,
            ),
          ],
        ),
      ),
    );
  }
}
