import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/bloc/carrier/carrier_bloc.dart';
import 'package:shipanther/bloc/customer/customer_bloc.dart';
import 'package:shipanther/bloc/order/order_bloc.dart';
import 'package:shipanther/bloc/shipment/shipment_bloc.dart';
import 'package:shipanther/bloc/tenant/tenant_bloc.dart';
import 'package:shipanther/bloc/terminal/terminal_bloc.dart';
import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/data/auth/remote_auth_repository.dart';
import 'package:shipanther/data/carrier/carrier_repository.dart';
import 'package:shipanther/data/carrier/remote_carrier_repository.dart';
import 'package:shipanther/data/customer/customer_repository.dart';
import 'package:shipanther/data/customer/remote_customer_repository.dart';
import 'package:shipanther/data/order/order_repository.dart';
import 'package:shipanther/data/order/remote_order_repository.dart';
import 'package:shipanther/data/shipment/remote_shipment_repository.dart';
import 'package:shipanther/data/shipment/shipment_repository.dart';
import 'package:shipanther/data/tenant/remote_tenant_repository.dart';
import 'package:shipanther/data/tenant/tenant_repository.dart';
import 'package:shipanther/data/terminal/remote_terminal_repository.dart';
import 'package:shipanther/data/terminal/terminal_repository.dart';
import 'package:shipanther/data/user/remote_user_repository.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/router/router.gr.dart';
//import 'package:shipanther/screens/signin_or_register_page.dart';
import 'package:shipanther/widgets/theme.dart';

Future<void> commonMain(String apiURL) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (!kIsWeb) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //print('Got a message whilst in the foreground!');
    //print('Message data: ${message.data}');

    if (message.notification != null) {
      //    print('Message also contained a notification: ${message.notification}');
    }
  });
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  runZonedGuarded<Future<void>>(() async {
    if (!kIsWeb) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    }
    runApp(ShipantherApp(apiURL, AppRouter()));
  }, (error, stackTrace) {
    if (!kIsWeb) {
      // print('runZonedGuarded: Caught error in my root zone.');
      FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
    }
  });
}

/// The entry point of the application.
///
/// Returns a [MaterialApp].
class ShipantherApp extends StatelessWidget {
  const ShipantherApp(this.apiURL, this.appRouter, {super.key});
  final String apiURL;
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>(
      create: (context) => RemoteAuthRepository(
          FirebaseAuth.instance, FirebaseMessaging.instance, apiURL),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(
              create: (context) =>
                  RemoteUserRepository(context.read<AuthRepository>())),
          RepositoryProvider<TenantRepository>(
              create: (context) =>
                  RemoteTenantRepository(context.read<AuthRepository>())),
          RepositoryProvider<TerminalRepository>(
              create: (context) =>
                  RemoteTerminalRepository(context.read<AuthRepository>())),
          RepositoryProvider<CustomerRepository>(
              create: (context) =>
                  RemoteCustomerRepository(context.read<AuthRepository>())),
          RepositoryProvider<ShipmentRepository>(
              create: (context) =>
                  RemoteShipmentRepository(context.read<AuthRepository>())),
          RepositoryProvider<CarrierRepository>(
              create: (context) =>
                  RemoteCarrierRepository(context.read<AuthRepository>())),
          RepositoryProvider<OrderRepository>(
              create: (context) =>
                  RemoteOrderRepository(context.read<AuthRepository>())),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => AuthBloc(context.read<AuthRepository>())),
            BlocProvider(
                create: (context) =>
                    TenantBloc(context.read<TenantRepository>())),
            BlocProvider(
                create: (context) => UserBloc(context.read<UserRepository>())),
            BlocProvider(
                create: (context) =>
                    TerminalBloc(context.read<TerminalRepository>())),
            BlocProvider(
                create: (context) =>
                    CustomerBloc(context.read<CustomerRepository>())),
            BlocProvider(
                create: (context) =>
                    ShipmentBloc(context.read<ShipmentRepository>())),
            BlocProvider(
                create: (context) =>
                    CarrierBloc(context.read<CarrierRepository>())),
            BlocProvider(
                create: (context) =>
                    OrderBloc(context.read<OrderRepository>())),
          ],
          child: MaterialApp.router(
            onGenerateTitle: (context) =>
                ShipantherLocalizations.of(context).shipantherTitle,
            debugShowCheckedModeBanner: false,
            darkTheme: ShipantherTheme.darkTheme,
            theme: ShipantherTheme.lightTheme,
            themeMode: ThemeMode.system,
            //home: const SignInOrRegistrationPage(),
            //navigatorObservers: <NavigatorObserver>[observer],
            routerDelegate: appRouter.delegate(),
            routeInformationParser: appRouter.defaultRouteParser(),
            localizationsDelegates: const [
              ShipantherLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: ShipantherLocalizations.delegate.supportedLocales,
          ),
        ),
      ),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  //print('Handling a background message: ${message.messageId}');
}
