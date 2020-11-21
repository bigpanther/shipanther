import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shipanther/l10n/locales/messages_all.dart';

class ShipantherLocalizations {
  final Locale locale;

  const ShipantherLocalizations(this.locale);

  static ShipantherLocalizations of(BuildContext context) {
    return Localizations.of<ShipantherLocalizations>(
        context, ShipantherLocalizations);
  }

  static Future<ShipantherLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString()).then((_) {
      return ShipantherLocalizations(locale);
    });
  }

  static List<String> supportedLocales = ['en', 'pa'];
  String get tenantsTitle => Intl.message(
        'Tenants',
        name: 'tenantsTitle',
        desc: 'Title for the Tenants page',
        locale: locale.toString(),
      );

  String get terminalsTitle => Intl.message(
        'Terminals',
        name: 'terminalsTitle',
        desc: 'Title for the Terminals page',
        locale: locale.toString(),
      );
  String get tenantLessUserMessage => Intl.message(
        'Thanks for signing up. We will review your registration. We are in a limited beta at the moment. Please check back later.',
        name: 'tenantLessUserMessage',
        desc: 'Message to display when a new user signs up',
        locale: locale.toString(),
      );
  String get home => Intl.message(
        'Home',
        name: 'home',
        desc: 'Home',
        locale: locale.toString(),
      );
  String get logout => Intl.message(
        'Logout',
        name: 'logout',
        desc: 'Logout',
        locale: locale.toString(),
      );
  String get signIn => Intl.message(
        'Sign In',
        name: 'signIn',
        desc: 'Sign In',
        locale: locale.toString(),
      );
  String get register => Intl.message(
        'Register',
        name: 'register',
        desc: 'Register',
        locale: locale.toString(),
      );
  String get settings => Intl.message(
        'Settings',
        name: 'settings',
        desc: 'Settings',
        locale: locale.toString(),
      );

  String get ordersTitle => Intl.message(
        'Orders',
        name: 'ordersTitle',
        desc: 'Orders',
        locale: locale.toString(),
      );

  String get usersTitle => Intl.message(
        'Users',
        name: 'usersTitle',
        desc: 'Users',
        locale: locale.toString(),
      );

  String get carriersTitle => Intl.message(
        'Carriers',
        name: 'carriersTitle',
        desc: 'Carriers',
        locale: locale.toString(),
      );

  String get containersTitle => Intl.message(
        'Containers',
        name: 'containersTitle',
        desc: 'Containers',
        locale: locale.toString(),
      );
  String get customersTitle => Intl.message(
        'Customers',
        name: 'customersTitle',
        desc: 'Customers',
        locale: locale.toString(),
      );
}

class ShipantherLocalizationsDelegate
    extends LocalizationsDelegate<ShipantherLocalizations> {
  const ShipantherLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    print(locale);
    return ShipantherLocalizations.supportedLocales
        .contains(locale.languageCode.toLowerCase());
  }

  @override
  Future<ShipantherLocalizations> load(Locale locale) {
    return ShipantherLocalizations.load(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) {
    return false;
  }
}
