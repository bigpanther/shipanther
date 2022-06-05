import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';

class SignInOrRegistrationForm extends StatefulWidget {
  const SignInOrRegistrationForm(
      {required this.authTypeSelector,
      this.email = '',
      this.name = '',
      this.password = '',
      super.key});
  final AuthTypeSelector authTypeSelector;
  final String name;
  final String email;
  final String password;

  @override
  State<StatefulWidget> createState() => SignInOrRegistrationFormState();
}

class SignInOrRegistrationFormState extends State<SignInOrRegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FormGroup signInFormGroup;
  late FormGroup registerFormGroup;
  @override
  void initState() {
    super.initState();
    signInFormGroup = FormGroup({
      'email': FormControl<String>(
        value: widget.email,
        validators: [Validators.required, Validators.email],
      ),
      'password': FormControl<String>(
        validators: [Validators.required],
      ),
    });
    // Add email control
    registerFormGroup = FormGroup({
      'email': FormControl<String>(
        value: widget.email,
        validators: [Validators.required, Validators.email],
      ),
      'password': FormControl<String>(
        validators: [Validators.required],
      ),
      'name': FormControl<String>(
        validators: [Validators.required],
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = ShipantherLocalizations.of(context);
    final theme = Theme.of(context);
    return ReactiveForm(
      formGroup: (widget.authTypeSelector == AuthTypeSelector.register)
          ? registerFormGroup
          : signInFormGroup,
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
                  color: theme.colorScheme.secondary,
                ),
                Text(
                  l10n.homePageText,
                  style: theme.textTheme.bodyText1!.copyWith(
                    color: theme.hintColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          if (widget.authTypeSelector == AuthTypeSelector.register)
            ShipantherTextFormField<String>(
              formControlName: 'name',
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.name,
              validationMessages: {
                ValidationMessage.required: l10n.paramEmpty(l10n.name),
              },
              labelText: l10n.name,
            )
          else
            const SizedBox(
              height: 0,
              width: 0,
            ),
          ShipantherTextFormField<String>(
            formControlName: 'email',
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
            validationMessages: {
              ValidationMessage.required: l10n.paramEmpty(l10n.email),
            },
            labelText: l10n.email,
          ),
          ShipantherPasswordFormField(
              formControlName: 'password',
              labelText: l10n.password,
              validationMessages: {
                ValidationMessage.required: l10n.paramRequired(l10n.password),
              }),
          if (widget.authTypeSelector == AuthTypeSelector.signIn)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: TextButton(
                  onPressed: () =>
                      context.read<AuthBloc>().add(const ForgotPassword()),
                  child: Text(
                    l10n.forgotPassword,
                    style: theme.textTheme.caption,
                  ),
                ),
              ),
            )
          else
            const SizedBox(
              height: 0,
              width: 0,
            ),
          ShipantherButton(
              onPressed: () {
                if (widget.authTypeSelector == AuthTypeSelector.register) {
                  if (registerFormGroup.valid) {
                    context.read<AuthBloc>().add(
                          AuthRegister(
                            registerFormGroup.control('name').value,
                            registerFormGroup.control('email').value,
                            registerFormGroup.control('password').value,
                          ),
                        );
                  } else {
                    registerFormGroup.markAllAsTouched();
                  }
                } else if (signInFormGroup.valid) {
                  context.read<AuthBloc>().add(
                        AuthSignIn(signInFormGroup.control('email').value,
                            signInFormGroup.control('password').value),
                      );
                } else {
                  signInFormGroup.markAllAsTouched();
                }
              },
              labelText: (widget.authTypeSelector == AuthTypeSelector.signIn)
                  ? l10n.signIn
                  : l10n.register),
          ShipantherButton(
            onPressed: () => context.read<AuthBloc>().add(
                  AuthTypeOtherRequest(widget.authTypeSelector),
                ),
            labelText: (widget.authTypeSelector == AuthTypeSelector.signIn)
                ? l10n.register
                : l10n.signIn,
            secondary: true,
          ),
        ],
      ),
    );
  }
}
