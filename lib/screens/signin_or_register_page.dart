import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/api_login.dart';
import 'package:shipanther/screens/signin_or_register_form.dart';
import 'package:shipanther/screens/verify_email.dart';
import 'package:shipanther/widgets/centered_loading.dart';

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
          if (state is AuthEmailResent) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  ShipantherLocalizations.of(context)
                      .emailSent(state.user.email),
                ),
              ),
            );
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
