// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static m0(howMany) => "${Intl.plural(howMany, zero: 'Carrier', one: 'Carrier', other: 'Carriers')}";

  static m1(howMany) => "${Intl.plural(howMany, zero: 'Customer', one: 'Customer', other: 'Customers')}";

  static m2(emailId) => "An Email has been sent to ${emailId}. Please check your inbox.";

  static m3(howMany) => "${Intl.plural(howMany, zero: 'Order', one: 'Order', other: 'Orders')}";

  static m4(param) => "${param} is required";

  static m5(howMany) => "${Intl.plural(howMany, zero: 'Shipment', one: 'Shipment', other: 'Shipments')}";

  static m6(howMany) => "${Intl.plural(howMany, zero: 'Tenant', one: 'Tenant', other: 'Tenants')}";

  static m7(howMany) => "${Intl.plural(howMany, zero: 'Terminal', one: 'Terminal', other: 'Terminals')}";

  static m8(howMany) => "${Intl.plural(howMany, zero: 'User', one: 'User', other: 'Users')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "carriersTitle" : m0,
    "changePassword" : MessageLookupByLibrary.simpleMessage("Change password"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("Confirm password"),
    "create" : MessageLookupByLibrary.simpleMessage("Create"),
    "customersTitle" : m1,
    "edit" : MessageLookupByLibrary.simpleMessage("Edit"),
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "emailNotVerified" : MessageLookupByLibrary.simpleMessage("This Email Id is not yet verified. Please try again."),
    "emailSent" : m2,
    "forgotPassword" : MessageLookupByLibrary.simpleMessage("Forgot Password?"),
    "home" : MessageLookupByLibrary.simpleMessage("Home"),
    "logout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "newPassword" : MessageLookupByLibrary.simpleMessage("New password"),
    "noDateChosen" : MessageLookupByLibrary.simpleMessage("No date chosen"),
    "oldPassword" : MessageLookupByLibrary.simpleMessage("Old password"),
    "ordersTitle" : m3,
    "paramRequired" : m4,
    "passowrdDoesntMatch" : MessageLookupByLibrary.simpleMessage("Passwords do not match"),
    "password" : MessageLookupByLibrary.simpleMessage("Password"),
    "profile" : MessageLookupByLibrary.simpleMessage("Profile"),
    "register" : MessageLookupByLibrary.simpleMessage("Register"),
    "resetPassword" : MessageLookupByLibrary.simpleMessage("Reset Password"),
    "resetPasswordMessage" : MessageLookupByLibrary.simpleMessage("An email with the reset link would be sent to you."),
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "shipmentsTitle" : m5,
    "signIn" : MessageLookupByLibrary.simpleMessage("Sign In"),
    "tenantLessUserMessage" : MessageLookupByLibrary.simpleMessage("Thanks for signing up. We will review your registration. We are in a limited beta at the moment. Please check back later."),
    "tenantsTitle" : m6,
    "terminalsTitle" : m7,
    "username" : MessageLookupByLibrary.simpleMessage("Username"),
    "usersTitle" : m8,
    "welcome" : MessageLookupByLibrary.simpleMessage("Welcome to Shipanther")
  };
}
