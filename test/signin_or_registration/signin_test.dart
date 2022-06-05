import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/router/router.gr.dart';
import 'package:shipanther/screens/signin_or_register_page.dart';
import 'package:shipanther/widgets/shipanther_text_form_field.dart';
import 'signin_test.mocks.dart';

@GenerateMocks([AuthRepository])
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
      final AppRouter appRouter = AppRouter();
      await tester.pumpWidget(BlocProvider.value(
        value: AuthBloc(authRepository),
        child: MaterialApp.router(
          localizationsDelegates: const [
            ShipantherLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: ShipantherLocalizations.delegate.supportedLocales,
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
        ),
      ));
      await tester.pumpAndSettle();
      expect(
        find.byType(SignInOrRegistrationPage),
        findsOneWidget,
      );
      expect(
        find.byType(ShipantherButton),
        findsNWidgets(2),
      );
      expect(
        find.byType(ShipantherTextFormField<String>),
        findsNWidgets(2),
      );
      expect(
        find.byType(ShipantherPasswordFormField),
        findsNWidgets(1),
      );
    });
  });
}
