import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/extensions/user_extension.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/screens/reset_password.dart';
import 'package:shipanther/screens/signin_or_register_form.dart';
import 'package:shipanther/screens/verify_email.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';

class SignInOrRegistrationPage extends StatefulWidget {
  const SignInOrRegistrationPage({super.key});
  @override
  SignInOrRegistrationPageState createState() =>
      SignInOrRegistrationPageState();
}

class SignInOrRegistrationPageState extends State<SignInOrRegistrationPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(
          const AuthCheck(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return ShipantherScaffold(
      null,
      title: ShipantherLocalizations.of(context).welcome,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }
          if (state is AuthEmailResent) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  ShipantherLocalizations.of(context).emailSent(state.email),
                ),
              ),
            );
          }
          if (state is AuthFinished) {
            AutoRouter.of(context).replace(state.user.homePage);
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
      return SignInOrRegistrationForm(
        authTypeSelector: state.authType,
        email: state.email,
        password: state.password,
        name: state.name,
      );
    }
    if (state is AuthVerification) {
      return VerifyEmail(state.email);
    }
    if (state is ForgotPasswordRequested) {
      return ResetPassword(email: state.email);
    }
    return const CenteredLoading();
  }
}
