// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pa locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pa';

  static m0(howMany) => "${Intl.plural(howMany, zero: 'ਕੈਰੀਅਰ', one: 'ਕੈਰੀਅਰ', other: 'ਕੈਰੀਅਰ')}";

  static m1(howMany) => "${Intl.plural(howMany, zero: 'ਗਾਹਕ', one: 'ਗਾਹਕ', other: 'ਗਾਹਕ')}";

  static m2(emailId) => "${emailId} ਨੂੰ ਈਮੇਲ ਭੇਜੀ ਗਈ ਹੈ. ਕਿਰਪਾ ਕਰਕੇ ਆਪਣੇ ਇਨਬਾਕਸ ਦੀ ਜਾਂਚ ਕਰੋ।";

  static m3(howMany) => "${Intl.plural(howMany, zero: 'ਆਰਡਰਸ', one: 'ਆਰਡਰਸ', other: 'ਆਰਡਰਸ')}";

  static m4(param) => "${param} ਦੀ ਲੋੜ ਹੈ";

  static m5(howMany) => "${Intl.plural(howMany, zero: 'ਕੰਟੇਨਰ', one: 'ਕੰਟੇਨਰ', other: 'ਕੰਟੇਨਰ')}";

  static m6(howMany) => "${Intl.plural(howMany, zero: 'ਕਿਰਾਏਦਾਰ', one: 'ਕਿਰਾਏਦਾਰ', other: 'ਕਿਰਾਏਦਾਰ')}";

  static m7(howMany) => "${Intl.plural(howMany, zero: 'ਟਰਮੀਨਲ', one: 'ਟਰਮੀਨਲ', other: 'ਟਰਮੀਨਲ')}";

  static m8(howMany) => "${Intl.plural(howMany, zero: 'ਉਪਭੋਗਤਾ', one: 'ਉਪਭੋਗਤਾ', other: 'ਉਪਭੋਗਤਾ')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "carriersTitle" : m0,
    "changePassword" : MessageLookupByLibrary.simpleMessage("ਪਾਸਵਰਡ ਬਦਲੋ"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("ਪਾਸਵਰਡ ਪੱਕਾ ਕਰੋ"),
    "create" : MessageLookupByLibrary.simpleMessage("ਬਣਾਓ"),
    "customersTitle" : m1,
    "edit" : MessageLookupByLibrary.simpleMessage("ਸੰਪਾਦਿਤ ਕਰੋ"),
    "email" : MessageLookupByLibrary.simpleMessage("ਈ-ਮੇਲ"),
    "emailNotVerified" : MessageLookupByLibrary.simpleMessage("ਇਹ ਈਮੇਲ ਆਈਡੀ ਅਜੇ ਪ੍ਰਮਾਣਿਤ ਨਹੀਂ ਹੈ. ਮੁੜ ਕੋਸ਼ਿਸ ਕਰੋ ਜੀ."),
    "emailSent" : m2,
    "forgotPassword" : MessageLookupByLibrary.simpleMessage("ਪਾਸਵਰਡ ਭੁੱਲ ਗਏ?"),
    "home" : MessageLookupByLibrary.simpleMessage("ਮੁੱਖ ਪੰਨਾ"),
    "logout" : MessageLookupByLibrary.simpleMessage("ਲਾੱਗ ਆਊਟ"),
    "name" : MessageLookupByLibrary.simpleMessage("ਨਾਮ"),
    "newPassword" : MessageLookupByLibrary.simpleMessage("ਨਵਾਂ ਪਾਸਵਰਡ"),
    "noDateChosen" : MessageLookupByLibrary.simpleMessage("ਕੋਈ ਤਾਰੀਖ ਨਹੀਂ ਚੁਣੀ ਗਈ"),
    "oldPassword" : MessageLookupByLibrary.simpleMessage("ਪੁਰਾਣਾ ਪਾਸਵਰਡ"),
    "ordersTitle" : m3,
    "paramRequired" : m4,
    "passowrdDoesntMatch" : MessageLookupByLibrary.simpleMessage("ਪਾਸਵਰਡ ਮੇਲ ਨਹੀਂ ਖਾਂਦਾ"),
    "password" : MessageLookupByLibrary.simpleMessage("ਪਾਸਵਰਡ"),
    "profile" : MessageLookupByLibrary.simpleMessage("ਪ੍ਰੋਫਾਈਲ"),
    "register" : MessageLookupByLibrary.simpleMessage("ਪੰਜੀਕਰਨ"),
    "resetPassword" : MessageLookupByLibrary.simpleMessage("ਪਾਸਵਰਡ ਰੀਸੈਟ ਕਰੋ"),
    "resetPasswordMessage" : MessageLookupByLibrary.simpleMessage("ਰੀਸੈਟ ਲਿੰਕ ਵਾਲੀ ਇੱਕ ਈਮੇਲ ਤੁਹਾਨੂੰ ਭੇਜੀ ਜਾਏਗੀ."),
    "save" : MessageLookupByLibrary.simpleMessage("ਰੱਖਣਾ"),
    "settings" : MessageLookupByLibrary.simpleMessage("ਸੈਟਿੰਗਜ਼"),
    "shipmentsTitle" : m5,
    "signIn" : MessageLookupByLibrary.simpleMessage("ਲਾੱਗ ਇਨ"),
    "tenantLessUserMessage" : MessageLookupByLibrary.simpleMessage("ਰਜਿਸਟ੍ਰੇਸ਼ਨ ਕਰਨ ਵਾਸਤੇ ਤੁਹਾਡਾ ਬਹੁਤ ਧੰਨਵਾਦ। ਏਹ ਸੌਫਟਵੇਅਰ ਹਾਲੀ ਤਜਰਬੇ ਵਾਲੀ ਸਥਿਤੀ ਵਿੱਚ ਹੈ । ਅਸੀਂ ਤੁਹਾਨੰ ਛੇਤੀ ਹੀ ਵਾਪਿਸ ਜੁਵਾਬ ਦੇਵਾਂਗੇ। ਧੰਨਵਾਦ।"),
    "tenantsTitle" : m6,
    "terminalsTitle" : m7,
    "username" : MessageLookupByLibrary.simpleMessage("ਉਪਯੋਗਕਰਤਾ ਨਾਮ"),
    "usersTitle" : m8,
    "welcome" : MessageLookupByLibrary.simpleMessage("ਸ਼ਿੱਪਐਨਥਰ ਤੁਹਾਡਾ ਸਵਾਗਤ ਕਰਦਾ ਹੈ")
  };
}
