import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/bloc/carrier/carrier_bloc.dart';
import 'package:shipanther/bloc/customer/customer_bloc.dart';
import 'package:shipanther/bloc/container/container_bloc.dart';
import 'package:shipanther/bloc/order/order_bloc.dart';
import 'package:shipanther/bloc/tenant/tenant_bloc.dart';
import 'package:shipanther/bloc/terminal/terminal_bloc.dart';
import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/api/remote_api_repository.dart';
import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/data/auth/firebase_auth_repository.dart';
import 'package:shipanther/data/carrier/carrier_repository.dart';
import 'package:shipanther/data/carrier/remote_carrier_repository.dart';
import 'package:shipanther/data/customer/customer_repository.dart';
import 'package:shipanther/data/customer/remote_customer_repository.dart';
import 'package:shipanther/data/container/container_repository.dart';
import 'package:shipanther/data/container/remote_container_repository.dart';
import 'package:shipanther/data/order/order_repository.dart';
import 'package:shipanther/data/order/remote_order_repository.dart';
import 'package:shipanther/data/tenant/remote_tenant_repository.dart';
import 'package:shipanther/data/tenant/tenant_repository.dart';
import 'package:shipanther/data/terminal/remote_terminal_repository.dart';
import 'package:shipanther/data/terminal/terminal_repository.dart';
import 'package:shipanther/data/user/remote_user_repository.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/signin_or_register_page.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

FirebaseMessaging _firebaseMessaging;

Future<void> commonMain(String apiURL) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  Function originalOnError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails errorDetails) async {
    await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    // Forward to original handler.
    originalOnError(errorDetails);
  };
  _firebaseMessaging = FirebaseMessaging();
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
    onBackgroundMessage: Platform.isIOS ? null : backgroundHandle,
  );
  _firebaseMessaging.requestNotificationPermissions(
    const IosNotificationSettings(sound: true, badge: true, alert: true),
  );
  runZonedGuarded(() {
    runApp(ShipantherApp(apiURL));
  }, (error, stackTrace) {
    print('runZonedGuarded: Caught error in my root zone.');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

/// The entry point of the application.
///
/// Returns a [MaterialApp].
class ShipantherApp extends StatelessWidget {
  final String apiURL;

  const ShipantherApp(this.apiURL);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>(
      create: (context) => FireBaseAuthRepository(_firebaseMessaging),
      child: RepositoryProvider<ApiRepository>(
        create: (context) =>
            RemoteApiRepository(context.read<AuthRepository>(), apiURL),
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<UserRepository>(
                create: (context) =>
                    RemoteUserRepository(context.read<ApiRepository>())),
            RepositoryProvider<TenantRepository>(
                create: (context) =>
                    RemoteTenantRepository(context.read<ApiRepository>())),
            RepositoryProvider<TerminalRepository>(
                create: (context) =>
                    RemoteTerminalRepository(context.read<ApiRepository>())),
            RepositoryProvider<CustomerRepository>(
                create: (context) =>
                    RemoteCustomerRepository(context.read<ApiRepository>())),
            RepositoryProvider<ContainerRepository>(
                create: (context) =>
                    RemoteContainerRepository(context.read<ApiRepository>())),
            RepositoryProvider<CarrierRepository>(
                create: (context) =>
                    RemoteCarrierRepository(context.read<ApiRepository>())),
            RepositoryProvider<OrderRepository>(
                create: (context) =>
                    RemoteOrderRepository(context.read<ApiRepository>())),
          ],
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
              BlocProvider(
                  create: (context) =>
                      TerminalBloc(context.read<TerminalRepository>())),
              BlocProvider(
                  create: (context) =>
                      CustomerBloc(context.read<CustomerRepository>())),
              BlocProvider(
                  create: (context) =>
                      ContainerBloc(context.read<ContainerRepository>())),
              BlocProvider(
                  create: (context) =>
                      CarrierBloc(context.read<CarrierRepository>())),
              BlocProvider(
                  create: (context) =>
                      OrderBloc(context.read<OrderRepository>())),
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
    );
  }
}

Future<dynamic> backgroundHandle(Map<String, dynamic> message) async {
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
