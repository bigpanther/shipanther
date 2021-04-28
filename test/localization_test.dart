import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

Future<void> main() async {
  // See https://github.com/flutter/flutter/issues/20907
  if (Directory.current.path.endsWith('/test')) {
    Directory.current = Directory.current.parent;
  }
  Map<String, dynamic>? englishData;
  Map<String, dynamic>? punjabiData;
  const notTranslatedYet = ['whatsNew', 'homePageText'];
  setUpAll(() async {
    var f = File('i18n/intl_en.arb');
    var contents = await f.readAsString();
    englishData = json.decode(contents) as Map<String, dynamic>;
    f = File('i18n/intl_pa.arb');
    contents = await f.readAsString();
    punjabiData = json.decode(contents) as Map<String, dynamic>;
  });
  test('All keys should be translatable', () {
    expect(
        punjabiData!.keys,
        englishData!.keys
            .takeWhile((value) => !notTranslatedYet.contains(value)));
  });
  group('Verify translated keys', () {
    test('All keys should be translated', () {
      final notTranslated = <String>[];
      for (final key in englishData!.keys) {
        if (!notTranslatedYet.contains(key) &&
            englishData![key] == punjabiData![key]) {
          notTranslated.add(key);
        }
      }
      expect(notTranslated, <String>[], reason: 'some keys are not translated');
    });
  });
}
