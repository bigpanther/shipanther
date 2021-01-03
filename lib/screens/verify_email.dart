import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail(this.emailId, {Key? key}) : super(key: key);
  final String emailId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ShipantherLocalizations.of(context)!.welcome),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthLogout(),
                    );
              })
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              ShipantherLocalizations.of(context)!.emailSent(emailId),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: SignInButtonBuilder(
                icon: Icons.verified_user,
                backgroundColor: Colors.green,
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const CheckVerified(),
                      );
                },
                text: ShipantherLocalizations.of(context)!.iVerified,
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
                        const ResendEmail(),
                      );
                },
                text: ShipantherLocalizations.of(context)!.resendEmail,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
