import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail(this.user, {Key key}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ShipantherLocalizations.of(context).welcome),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                context.read<AuthBloc>().add(
                      const AuthLogout(),
                    );
              })
        ],
      ),
      body: Column(
        children: [
          Text(
            ShipantherLocalizations.of(context).emailSent(user.email),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: SignInButtonBuilder(
              icon: Icons.verified_user,
              backgroundColor: Colors.green,
              onPressed: () {
                context.read<AuthBloc>().add(
                      CheckVerified(user),
                    );
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
                context.read<AuthBloc>().add(
                      ResendEmail(user),
                    );
              },
              text: 'Resend Email',
            ),
          ),
        ],
      ),
    );
  }
}
