// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/signin_or_register_page.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('SignIn Page', () {
    late AuthRepository authRepository;

    setUp(() {
      authRepository = MockAuthRepository();
    });

    testWidgets('renders the login page when not logged in', (tester) async {
      when(authRepository.logIn()).thenThrow(
        UnAuthenticatedException(),
      );
      await tester.pumpWidget(BlocProvider.value(
        value: AuthBloc(authRepository),
        child: MaterialApp(
          localizationsDelegates: const [
            ShipantherLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales:
              ShipantherLocalizations.supportedLocales.map((e) => Locale(e)),
          home: SignInOrRegistrationPage(),
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.byType(SignInOrRegistrationPage), findsOneWidget);
      expect(find.byType(ShipantherButton), findsOneWidget);
      expect(find.byType(ShipantherTextFormField), findsNWidgets(2));
    });
  });
}
