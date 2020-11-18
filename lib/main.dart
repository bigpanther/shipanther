import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/bloc/tenant/tenant_bloc.dart';
import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/api/remote_api_repository.dart';
import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/data/auth/firebase_auth_repository.dart';
import 'package:shipanther/data/tenant/remote_tenant_repository.dart';
import 'package:shipanther/data/tenant/tenant_repository.dart';
import 'package:shipanther/data/user/remote_user_repository.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/signin_or_register_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> task) async {
      print('onMessage: $task');
    },
    onLaunch: (Map<String, dynamic> task) async {
      print('onLaunch: $task');
    },
    onResume: (Map<String, dynamic> task) async {
      print('onResume: $task');
    },
    onBackgroundMessage: Platform.isIOS ? null : backGroundMessageHandler,
  );
  _firebaseMessaging.requestNotificationPermissions(
    const IosNotificationSettings(sound: true, badge: true, alert: true),
  );
  runApp(ShipantherApp());
}

/// The entry point of the application.
///
/// Returns a [MaterialApp].
class ShipantherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>(
      create: (context) => FireBaseAuthRepository(),
      child: RepositoryProvider<ApiRepository>(
        create: (context) => RemoteApiRepository(context.read<AuthRepository>(),
            "https://trober-test.herokuapp.com"),
        child: RepositoryProvider<UserRepository>(
          create: (context) =>
              RemoteUserRepository(context.read<ApiRepository>()),
          child: RepositoryProvider<TenantRepository>(
            create: (context) =>
                RemoteTenantRepository(context.read<ApiRepository>()),
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) =>
                        AuthBloc(context.read<AuthRepository>())),
                BlocProvider(
                    create: (context) =>
                        TenantBloc(context.read<TenantRepository>())),
                BlocProvider(
                    create: (context) =>
                        UserBloc(context.read<UserRepository>())),
              ],
              child: MaterialApp(
                title: 'Shipanther',
                debugShowCheckedModeBanner: false,
                theme: ThemeData.dark(),
                home: SignInOrRegistrationPage(),
                // routes: {
                //   '/login': (context) => BlocProvider.value(
                //         value: context.read<AuthRepository>(),
                //         child: SignInOrRegistrationPage(),
                //       ),
                // },
                localizationsDelegates: [
                  ShipantherLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: ShipantherLocalizations.supportedLocales
                    .map((e) => Locale(e)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<dynamic> backGroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print(data);
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print(notification);
  }
}
