import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shipanther/screens/signin_or_register_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ShipantherApp());
}

/// The entry point of the application.
///
/// Returns a [MaterialApp].
class ShipantherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shipanther',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SignInOrRegistrationPage(AuthTypeSelector.signIn),
    );
  }
}
