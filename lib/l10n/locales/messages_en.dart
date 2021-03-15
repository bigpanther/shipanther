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

  static m0(param) => "Add new ${param}";

  static m1(howMany) =>
      "${Intl.plural(howMany, zero: 'Carrier', one: 'Carrier', other: 'Carriers')}";

  static m2(howMany) =>
      "${Intl.plural(howMany, zero: 'Customer', one: 'Customer', other: 'Customers')}";

  static m3(param) => "Edit ${param}";

  static m4(emailId) =>
      "An Email has been sent to ${emailId}. Please check your inbox.";

  static m5(param) => "Hello ${param}";

  static m6(howMany) =>
      "${Intl.plural(howMany, zero: 'Order', one: 'Order', other: 'Orders')}";

  static m7(param) => "${param} should not be empty";

  static m8(paramFrom, paramTo) => "${paramFrom} to ${paramTo}";

  static m9(param) => "${param} is required";

  static m10(param) => "Select ${param}";

  static m11(howMany) =>
      "${Intl.plural(howMany, zero: 'Shipment', one: 'Shipment', other: 'Shipments')}";

  static m12(howMany) =>
      "${Intl.plural(howMany, zero: 'Tenant', one: 'Tenant', other: 'Tenants')}";

  static m13(howMany) =>
      "${Intl.plural(howMany, zero: 'Terminal', one: 'Terminal', other: 'Terminals')}";

  static m14(howMany) =>
      "${Intl.plural(howMany, zero: 'User', one: 'User', other: 'Users')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "aboutUs": MessageLookupByLibrary.simpleMessage("About Us"),
        "addCarrier": MessageLookupByLibrary.simpleMessage("Add carrier"),
        "addCustomer": MessageLookupByLibrary.simpleMessage("Add customer"),
        "addNewParam": m0,
        "applicationLegalese": MessageLookupByLibrary.simpleMessage(
            "©2020-2021 Big Panther Technologies Inc."),
        "carrierName": MessageLookupByLibrary.simpleMessage("Carrier name"),
        "carrierType": MessageLookupByLibrary.simpleMessage("Carrier type"),
        "carriersETA": MessageLookupByLibrary.simpleMessage("ETA"),
        "carriersTitle": m1,
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Change password"),
        "clear": MessageLookupByLibrary.simpleMessage("Clear"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "create": MessageLookupByLibrary.simpleMessage("Create"),
        "createdAt": MessageLookupByLibrary.simpleMessage("Created at"),
        "customerName": MessageLookupByLibrary.simpleMessage("Customer name"),
        "customersTitle": m2,
        "driver": MessageLookupByLibrary.simpleMessage("driver"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "editParam": m3,
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailNotVerified": MessageLookupByLibrary.simpleMessage(
            "This Email Id is not yet verified. Please try again."),
        "emailSent": m4,
        "eta": MessageLookupByLibrary.simpleMessage("ETA"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot Password?"),
        "helloParam": m5,
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "iVerified": MessageLookupByLibrary.simpleMessage("I verified"),
        "lastUpdate": MessageLookupByLibrary.simpleMessage("Last update"),
        "loginError": MessageLookupByLibrary.simpleMessage(
            "An error occured during log-in. Please retry."),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "madeWithLove":
            MessageLookupByLibrary.simpleMessage("Built with ♥️ in Canada"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "newPassword": MessageLookupByLibrary.simpleMessage("New password"),
        "noDateChosen": MessageLookupByLibrary.simpleMessage("No date chosen"),
        "oldPassword": MessageLookupByLibrary.simpleMessage("Old password"),
        "orderAdd": MessageLookupByLibrary.simpleMessage("Add order"),
        "orderNumber": MessageLookupByLibrary.simpleMessage("Order number"),
        "orderStatus": MessageLookupByLibrary.simpleMessage("Order status"),
        "orderStatusFilter":
            MessageLookupByLibrary.simpleMessage("Filter order status"),
        "ordersTitle": m6,
        "paramEmpty": m7,
        "paramFromTo": m8,
        "paramRequired": m9,
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordDoesntMatch":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "reachUsAt": MessageLookupByLibrary.simpleMessage("Reach us at"),
        "register": MessageLookupByLibrary.simpleMessage("Register"),
        "resendEmail": MessageLookupByLibrary.simpleMessage("Resend email"),
        "reservationTime":
            MessageLookupByLibrary.simpleMessage("Reservation time"),
        "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
        "resetPasswordMessage": MessageLookupByLibrary.simpleMessage(
            "An email with the reset link would be sent to you."),
        "role": MessageLookupByLibrary.simpleMessage("Role"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "selectParam": m10,
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
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
        "signIn": MessageLookupByLibrary.simpleMessage("Sign In"),
        "size": MessageLookupByLibrary.simpleMessage("Size"),
        "status": MessageLookupByLibrary.simpleMessage("Status"),
        "tenantAdd": MessageLookupByLibrary.simpleMessage("Add tenant"),
        "tenantDelete": MessageLookupByLibrary.simpleMessage("Tenant delete"),
        "tenantDetail": MessageLookupByLibrary.simpleMessage("Tenant detail"),
        "tenantEdit": MessageLookupByLibrary.simpleMessage("Tenant edit"),
        "tenantId": MessageLookupByLibrary.simpleMessage("Tenant ID"),
        "tenantLessUserMessage": MessageLookupByLibrary.simpleMessage(
            "Thanks for signing up. We will review your registration. We are in a limited beta at the moment. Please check back later."),
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
        "username": MessageLookupByLibrary.simpleMessage("Username"),
        "usersTitle": m14,
        "welcome": MessageLookupByLibrary.simpleMessage("Welcome to Shipanther")
      };
}
