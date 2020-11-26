import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                // widget.user.emailVerified
                //     ? Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(builder: (context) => ApiLogin()),
                //       )
                //     : Scaffold.of(context).showSnackBar(SnackBar(
                //         content: Text(ShipantherLocalizations.of(context)
                //             .notVerifiedError)));
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

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shipanther/bloc/auth/auth_bloc.dart';
// import 'package:shipanther/l10n/shipanther_localization.dart';
// import 'package:shipanther/widgets/centered_loading.dart';

// class VerifyEmail extends StatefulWidget {
//   final User user;
//   VerifyEmail(this.user);

//   @override
//   _VerifyEmailState createState() => _VerifyEmailState();
// }

// class _VerifyEmailState extends State<VerifyEmail> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) async {
//         if (state is AuthFailure) {
//           Scaffold.of(context).showSnackBar(SnackBar(
//             content: Text(state.message),
//           ));
//         }
//         // if (state is AuthFinished) {
//         //   Navigator.of(context).pushReplacement(
//         //     MaterialPageRoute<void>(builder: (_) {
//         //       if (state.user.role == api.UserRole.superAdmin) {
//         //         return SuperAdminHome(state.user);
//         //       }
//         //       if (state.user.role == api.UserRole.backOffice) {
//         //         return TerminalScreen(state.user);
//         //       }
//         //       if (state.user.role == api.UserRole.driver) {
//         //         return ContainerScreen(state.user);
//         //       }
//         //       if (state.user.role == api.UserRole.none) {
//         //         return NoneHome(state.user);
//         //       }
//         //     }),
//         // );
//         // }
//       },
//       builder: (context, state) {
//         if (state is AuthFailure) {
//           return Container(
//             child: Center(
//                 child: Column(
//               children: [
//                 Text("An error occured during log-in. Please retry."),
//                 FlatButton(
//                     onPressed: () => context.read<AuthBloc>().add(AuthLogout()),
//                     child: Text(ShipantherLocalizations.of(context).logout)),
//               ],
//             )),
//           );
//         }
//         return const CenteredLoading();
//       },
//     );
//     ;
//   }
// }
