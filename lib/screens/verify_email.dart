import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';

import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/centered_loading.dart';

class VerifyEmail extends StatefulWidget {
  final User user;

  const VerifyEmail(this.user, {Key key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
        if (state is AuthEmailResent) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(ShipantherLocalizations.of(context).verifyEmail1 +
                  widget.user.email)));
        }
      },
      builder: (context, state) {
        if (state is AuthVerification) {
          return Scaffold(
            body: Column(
              children: [
                Text(ShipantherLocalizations.of(context).verifyEmail1 +
                    widget.user.email +
                    ShipantherLocalizations.of(context).verifyEmail2),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                    icon: Icons.verified_user,
                    backgroundColor: Colors.green,
                    onPressed: () {
                      context.read<AuthBloc>().add(CheckVerified(state.user));
                    },
                    text: 'I Verified',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                    icon: Icons.email,
                    backgroundColor: Colors.amber,
                    onPressed: () {
                      context.read<AuthBloc>().add(ResendEmail(state.user));
                    },
                    text: 'Resend Email',
                  ),
                ),
              ],
            ),
          );
        }
        return const CenteredLoading();
      },
    );
  }
}
