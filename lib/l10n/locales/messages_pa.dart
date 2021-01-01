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

  static m0(param) => "Add new ${param}";

  static m1(howMany) =>
      "${Intl.plural(howMany, zero: 'ਕੈਰੀਅਰ', one: 'ਕੈਰੀਅਰ', other: 'ਕੈਰੀਅਰ')}";

  static m2(howMany) =>
      "${Intl.plural(howMany, zero: 'ਗਾਹਕ', one: 'ਗਾਹਕ', other: 'ਗਾਹਕ')}";

  static m3(param) => "Edit ${param}";

  static m4(emailId) =>
      "${emailId} ਨੂੰ ਈਮੇਲ ਭੇਜੀ ਗਈ ਹੈ. ਕਿਰਪਾ ਕਰਕੇ ਆਪਣੇ ਇਨਬਾਕਸ ਦੀ ਜਾਂਚ ਕਰੋ।";

  static m5(param) => "Hello ${param}";

  static m6(howMany) =>
      "${Intl.plural(howMany, zero: 'ਆਰਡਰਸ', one: 'ਆਰਡਰਸ', other: 'ਆਰਡਰਸ')}";

  static m7(param) => "${param} should not be empty";

  static m8(paramFrom, paramTo) => "${paramFrom} to ${paramTo}";

  static m9(param) => "${param} ਦੀ ਲੋੜ ਹੈ";

  static m10(param) => "Select ${param}";

  static m11(howMany) =>
      "${Intl.plural(howMany, zero: 'ਕੰਟੇਨਰ', one: 'ਕੰਟੇਨਰ', other: 'ਕੰਟੇਨਰ')}";

  static m12(howMany) =>
      "${Intl.plural(howMany, zero: 'ਕਿਰਾਏਦਾਰ', one: 'ਕਿਰਾਏਦਾਰ', other: 'ਕਿਰਾਏਦਾਰ')}";

  static m13(howMany) =>
      "${Intl.plural(howMany, zero: 'ਟਰਮੀਨਲ', one: 'ਟਰਮੀਨਲ', other: 'ਟਰਮੀਨਲ')}";

  static m14(howMany) =>
      "${Intl.plural(howMany, zero: 'ਉਪਭੋਗਤਾ', one: 'ਉਪਭੋਗਤਾ', other: 'ਉਪਭੋਗਤਾ')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "madeWithLove":
            MessageLookupByLibrary.simpleMessage("Built with ♥️ in Canada"),
        "reachUsAt": MessageLookupByLibrary.simpleMessage("Reach us at"),
        "aboutUs": MessageLookupByLibrary.simpleMessage("About Us"),
        "addCarrier": MessageLookupByLibrary.simpleMessage("Add carrier"),
        "addCustomer": MessageLookupByLibrary.simpleMessage("Add customer"),
        "addNewParam": m0,
        "applicationLegalese": MessageLookupByLibrary.simpleMessage(
            "©2020 Big Panther Technologies Inc."),
        "carrierName": MessageLookupByLibrary.simpleMessage("Carrier name"),
        "carrierType": MessageLookupByLibrary.simpleMessage("Carrier type"),
        "carriersETA": MessageLookupByLibrary.simpleMessage("ETA"),
        "carriersTitle": m1,
        "changePassword": MessageLookupByLibrary.simpleMessage("ਪਾਸਵਰਡ ਬਦਲੋ"),
        "clear": MessageLookupByLibrary.simpleMessage("Clear"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("ਪਾਸਵਰਡ ਪੱਕਾ ਕਰੋ"),
        "create": MessageLookupByLibrary.simpleMessage("ਬਣਾਓ"),
        "createdAt": MessageLookupByLibrary.simpleMessage("Created at"),
        "customerName": MessageLookupByLibrary.simpleMessage("Customer name"),
        "customersTitle": m2,
        "driver": MessageLookupByLibrary.simpleMessage("driver"),
        "edit": MessageLookupByLibrary.simpleMessage("ਸੰਪਾਦਿਤ ਕਰੋ"),
        "editParam": m3,
        "email": MessageLookupByLibrary.simpleMessage("ਈ-ਮੇਲ"),
        "emailNotVerified": MessageLookupByLibrary.simpleMessage(
            "ਇਹ ਈਮੇਲ ਆਈਡੀ ਅਜੇ ਪ੍ਰਮਾਣਿਤ ਨਹੀਂ ਹੈ. ਮੁੜ ਕੋਸ਼ਿਸ ਕਰੋ ਜੀ."),
        "emailSent": m4,
        "eta": MessageLookupByLibrary.simpleMessage("ETA"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("ਪਾਸਵਰਡ ਭੁੱਲ ਗਏ?"),
        "helloParam": m5,
        "home": MessageLookupByLibrary.simpleMessage("ਮੁੱਖ ਪੰਨਾ"),
        "iVerified": MessageLookupByLibrary.simpleMessage("I verified"),
        "lastUpdate": MessageLookupByLibrary.simpleMessage("Last update"),
        "lfd": MessageLookupByLibrary.simpleMessage("LFD"),
        "loginError": MessageLookupByLibrary.simpleMessage(
            "An error occured during log-in. Please retry."),
        "logout": MessageLookupByLibrary.simpleMessage("ਲਾੱਗ ਆਊਟ"),
        "name": MessageLookupByLibrary.simpleMessage("ਨਾਮ"),
        "newPassword": MessageLookupByLibrary.simpleMessage("ਨਵਾਂ ਪਾਸਵਰਡ"),
        "noDateChosen":
            MessageLookupByLibrary.simpleMessage("ਕੋਈ ਤਾਰੀਖ ਨਹੀਂ ਚੁਣੀ ਗਈ"),
        "oldPassword": MessageLookupByLibrary.simpleMessage("ਪੁਰਾਣਾ ਪਾਸਵਰਡ"),
        "orderAdd": MessageLookupByLibrary.simpleMessage("Add order"),
        "orderNumber": MessageLookupByLibrary.simpleMessage("Order number"),
        "orderStatus": MessageLookupByLibrary.simpleMessage("Order status"),
        "orderStatusFilter":
            MessageLookupByLibrary.simpleMessage("Filter order status"),
        "ordersTitle": m6,
        "paramEmpty": m7,
        "paramFromTo": m8,
        "paramRequired": m9,
        "password": MessageLookupByLibrary.simpleMessage("ਪਾਸਵਰਡ"),
        "passwordDoesntMatch":
            MessageLookupByLibrary.simpleMessage("ਪਾਸਵਰਡ ਮੇਲ ਨਹੀਂ ਖਾਂਦਾ"),
        "profile": MessageLookupByLibrary.simpleMessage("ਪ੍ਰੋਫਾਈਲ"),
        "register": MessageLookupByLibrary.simpleMessage("ਪੰਜੀਕਰਨ"),
        "resendEmail": MessageLookupByLibrary.simpleMessage("Resend email"),
        "reservationTime":
            MessageLookupByLibrary.simpleMessage("Reservation time"),
        "resetPassword":
            MessageLookupByLibrary.simpleMessage("ਪਾਸਵਰਡ ਰੀਸੈਟ ਕਰੋ"),
        "resetPasswordMessage": MessageLookupByLibrary.simpleMessage(
            "ਰੀਸੈਟ ਲਿੰਕ ਵਾਲੀ ਇੱਕ ਈਮੇਲ ਤੁਹਾਨੂੰ ਭੇਜੀ ਜਾਏਗੀ."),
        "role": MessageLookupByLibrary.simpleMessage("Role"),
        "save": MessageLookupByLibrary.simpleMessage("ਰੱਖਣਾ"),
        "selectParam": m10,
        "settings": MessageLookupByLibrary.simpleMessage("ਸੈਟਿੰਗਜ਼"),
        "shipantherTitle": MessageLookupByLibrary.simpleMessage("Shipanther"),
        "shipmentAccept": MessageLookupByLibrary.simpleMessage("Accept"),
        "shipmentAdd": MessageLookupByLibrary.simpleMessage("Add shipment"),
        "shipmentCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "shipmentCompleted": MessageLookupByLibrary.simpleMessage("Completed"),
        "shipmentDelivered": MessageLookupByLibrary.simpleMessage("Delivered"),
        "shipmentDestination":
            MessageLookupByLibrary.simpleMessage("Destination"),
        "shipmentLFD": MessageLookupByLibrary.simpleMessage("LFD"),
        "shipmentNoItem": MessageLookupByLibrary.simpleMessage("No items here"),
        "shipmentOrigin": MessageLookupByLibrary.simpleMessage("Origin"),
        "shipmentPending": MessageLookupByLibrary.simpleMessage("Pending"),
        "shipmentReject": MessageLookupByLibrary.simpleMessage("Reject"),
        "shipmentRejectConfirmation": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to reject this delivery?"),
        "shipmentReservationTime":
            MessageLookupByLibrary.simpleMessage("Reservation time"),
        "shipmentSerialNumber":
            MessageLookupByLibrary.simpleMessage("Serial number"),
        "shipmentSize": MessageLookupByLibrary.simpleMessage("Shipment size"),
        "shipmentStatus":
            MessageLookupByLibrary.simpleMessage("Shipment status"),
        "shipmentStatusFilter":
            MessageLookupByLibrary.simpleMessage("Filter shipment status"),
        "shipmentType": MessageLookupByLibrary.simpleMessage("Shipment type"),
        "shipmentsTitle": m11,
        "signIn": MessageLookupByLibrary.simpleMessage("ਲਾੱਗ ਇਨ"),
        "size": MessageLookupByLibrary.simpleMessage("Size"),
        "status": MessageLookupByLibrary.simpleMessage("Status"),
        "tenantAdd": MessageLookupByLibrary.simpleMessage("Add tenant"),
        "tenantDelete": MessageLookupByLibrary.simpleMessage("Tenant delete"),
        "tenantDetail": MessageLookupByLibrary.simpleMessage("Tenant detail"),
        "tenantEdit": MessageLookupByLibrary.simpleMessage("Tenant edit"),
        "tenantId": MessageLookupByLibrary.simpleMessage("Tenant ID"),
        "tenantLessUserMessage": MessageLookupByLibrary.simpleMessage(
            "ਰਜਿਸਟ੍ਰੇਸ਼ਨ ਕਰਨ ਵਾਸਤੇ ਤੁਹਾਡਾ ਬਹੁਤ ਧੰਨਵਾਦ। ਏਹ ਸੌਫਟਵੇਅਰ ਹਾਲੀ ਤਜਰਬੇ ਵਾਲੀ ਸਥਿਤੀ ਵਿੱਚ ਹੈ । ਅਸੀਂ ਤੁਹਾਨੰ ਛੇਤੀ ਹੀ ਵਾਪਿਸ ਜੁਵਾਬ ਦੇਵਾਂਗੇ। ਧੰਨਵਾਦ।"),
        "tenantName": MessageLookupByLibrary.simpleMessage("Tenant name"),
        "tenantType": MessageLookupByLibrary.simpleMessage("Tenant type"),
        "tenantTypeFilter":
            MessageLookupByLibrary.simpleMessage("Filter tenant type"),
        "tenantsTitle": m12,
        "terminalAdd": MessageLookupByLibrary.simpleMessage("Add terminal"),
        "terminalName": MessageLookupByLibrary.simpleMessage("Terminal name"),
        "terminalType": MessageLookupByLibrary.simpleMessage("Terminal type"),
        "terminalTypeFilter":
            MessageLookupByLibrary.simpleMessage("Filter terminal type"),
        "terminalsTitle": m13,
        "userName": MessageLookupByLibrary.simpleMessage("User name"),
        "userType": MessageLookupByLibrary.simpleMessage("User type"),
        "userTypeFilter":
            MessageLookupByLibrary.simpleMessage("Filter user type"),
        "username": MessageLookupByLibrary.simpleMessage("ਉਪਯੋਗਕਰਤਾ ਨਾਮ"),
        "usersTitle": m14,
        "welcome": MessageLookupByLibrary.simpleMessage(
            "ਸ਼ਿੱਪਐਨਥਰ ਤੁਹਾਡਾ ਸਵਾਗਤ ਕਰਦਾ ਹੈ")
      };
}
