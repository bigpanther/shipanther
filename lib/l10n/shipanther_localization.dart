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
  String get tenantsTitle {
    return Intl.message(
      'Tenants',
      name: 'tenantsTitle',
      desc: 'Title for the Tenants page',
      locale: locale.toString(),
    );
  }
}

class ShipantherLocalizationsDelegate extends LocalizationsDelegate {
  const ShipantherLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
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
