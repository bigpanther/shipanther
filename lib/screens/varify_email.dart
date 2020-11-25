import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/signin_or_register_page.dart';

class VerifyEmail extends StatefulWidget {
  final User user;

  const VerifyEmail(this.user, {Key key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
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
                print(widget.user.emailVerified);
                widget.user.emailVerified
                    ? Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ApiLogin()),
                      )
                    : Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(ShipantherLocalizations.of(context)
                            .notVerifiedError)));
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
              onPressed: () async {
                try {
                  await widget.user.sendEmailVerification();
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          ShipantherLocalizations.of(context).verifyEmail1 +
                              widget.user.email)));
                } catch (e) {
                  print(
                      "An error occured while trying to send email verification");
                  print(e.message);
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Failed to send Email.Please try again later.')));
                }
              },
              text: 'Resend Email',
            ),
          ),
        ],
      ),
    );
  }
}
