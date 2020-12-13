import 'dart:io';
import 'dart:convert';

import 'package:test/test.dart';

void main() async {
  Map<String, dynamic> englishData;
  Map<String, dynamic> punjabiData;
  setUpAll(() async {
    var f = await File('i18n/intl_messages_en.arb');
    var contents = await f.readAsString();
    englishData = json.decode(contents) as Map<String, dynamic>;
    f = await File('i18n/intl_messages_pa.arb');
    contents = await f.readAsString();
    punjabiData = json.decode(contents) as Map<String, dynamic>;
  });
  test('All keys should be translatable', () {
    expect(punjabiData.keys, englishData.keys);
  });
  group('Verify translated keys', () {
    test('All keys should be translated', () {
      var notTranslated = <String>[];
      for (var key in englishData.keys) {
        if (englishData[key] == punjabiData[key]) {
          notTranslated.add(key);
        }
      }
      expect(notTranslated, <String>[], reason: 'some keys are not translated');
    });
  });
}
