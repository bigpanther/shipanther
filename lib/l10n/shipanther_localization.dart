import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shipanther/l10n/locales/messages_all.dart';

class ShipantherLocalizations {
  const ShipantherLocalizations(this.locale);
  final Locale locale;

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
  DateFormat get dateFormatter => DateFormat('dd-MM-yyyy');
  DateFormat get dateTimeFormatter => DateFormat('dd-MM-yy - kk:mm');
  DateFormat get timeFormatter => DateFormat('kk:mm');

  //tenant
  String tenantsTitle(int howMany) => Intl.plural(
        howMany,
        zero: 'Tenant',
        one: 'tenant',
        other: 'Tenants',
        name: 'tenantsTitle',
        desc: 'Title for the Tenants page',
        locale: locale.toString(),
        args: [howMany],
        examples: const {'howMany': 2},
      );

  String get tenantLessUserMessage => Intl.message(
        'Thanks for signing up. We will review your registration. We are in a limited beta at the moment. Please check back later.',
        name: 'tenantLessUserMessage',
        desc: 'Message to display when a new user signs up',
        locale: locale.toString(),
      );

  String get tenantName => Intl.message(
        'Tenant name',
        name: 'tenantName',
        desc: 'Tenant name',
        locale: locale.toString(),
      );
  String get tenantType => Intl.message(
        'Tenant type',
        name: 'tenantType',
        desc: 'Tenant type',
        locale: locale.toString(),
      );

  String get tenantTypeFilter => Intl.message(
        'Filter tenant type',
        name: 'tenantTypeFilter',
        desc: 'Filter tenant type',
        locale: locale.toString(),
      );
  String get tenantAdd => Intl.message(
        'Add tenant',
        name: 'tenantAdd',
        desc: 'Add tenant',
        locale: locale.toString(),
      );
  //terminal
  String terminalsTitle(int howMany) => Intl.plural(
        howMany,
        zero: 'Terminal',
        one: 'Terminal',
        other: 'Terminals',
        name: 'terminalsTitle',
        desc: 'Title for the Terminals page',
        locale: locale.toString(),
        args: [howMany],
        examples: const {'howMany': 2},
      );

  String get terminalName => Intl.message(
        'Terminal name',
        name: 'terminalName',
        desc: 'Terminal name',
        locale: locale.toString(),
      );
  String get terminalType => Intl.message(
        'Terminal type',
        name: 'terminalType',
        desc: 'Terminal type',
        locale: locale.toString(),
      );

  String get terminalTypeFilter => Intl.message(
        'Filter terminal type',
        name: 'terminalTypeFilter',
        desc: 'Filter terminal type',
        locale: locale.toString(),
      );
  String get terminalAdd => Intl.message(
        'Add terminal',
        name: 'terminalAdd',
        desc: 'Add terminal',
        locale: locale.toString(),
      );
  //order
  String ordersTitle(int howMany) => Intl.plural(
        howMany,
        zero: 'Order',
        one: 'order',
        other: 'Orders',
        name: 'ordersTitle',
        desc: 'Title for the Orders page',
        locale: locale.toString(),
        args: [howMany],
        examples: const {'howMany': 2},
      );

  String get orderNumber => Intl.message(
        'Order number',
        name: 'orderNumber',
        desc: 'Order number',
        locale: locale.toString(),
      );
  String get orderStatus => Intl.message(
        'Order status',
        name: 'orderStatus',
        desc: 'Order status',
        locale: locale.toString(),
      );
  String get orderStatusFilter => Intl.message(
        'Filter order status',
        name: 'orderStatusFilter',
        desc: 'Filter Order status',
        locale: locale.toString(),
      );
  String get orderAdd => Intl.message(
        'Add order',
        name: 'orderAdd',
        desc: 'Add order',
        locale: locale.toString(),
      );
//user
  String usersTitle(int howMany) => Intl.plural(
        howMany,
        zero: 'User',
        one: 'user',
        other: 'Users',
        name: 'usersTitle',
        desc: 'Title for the Users page',
        locale: locale.toString(),
        args: [howMany],
        examples: const {'howMany': 2},
      );

  String get userName => Intl.message(
        'User name',
        name: 'userName',
        desc: 'User name',
        locale: locale.toString(),
      );
  String get userType => Intl.message(
        'User type',
        name: 'userType',
        desc: 'User type',
        locale: locale.toString(),
      );
  String get userTypeFilter => Intl.message(
        'Filter user type',
        name: 'userTypeFilter',
        desc: 'Filter user type',
        locale: locale.toString(),
      );
//carrier
  String carriersTitle(int howMany) => Intl.plural(
        howMany,
        zero: 'Carrier',
        one: 'carrier',
        other: 'Carriers',
        name: 'carriersTitle',
        desc: 'Title for the Carriers page',
        locale: locale.toString(),
        args: [howMany],
        examples: const {'howMany': 2},
      );
  String get carriersETA => Intl.message(
        'ETA',
        name: 'carriersETA',
        desc: 'ETA',
        locale: locale.toString(),
      );

  String get carrierName => Intl.message(
        'Carrier name',
        name: 'carrierName',
        desc: 'Carrier name',
        locale: locale.toString(),
      );
  String get carrierType => Intl.message(
        'Carrier type',
        name: 'carrierType',
        desc: 'Carrier type',
        locale: locale.toString(),
      );
  String get addCarrier => Intl.message(
        'Add carrier',
        name: 'addCarrier',
        desc: 'Add carrier',
        locale: locale.toString(),
      );

//container
  String containersTitle(int howMany) => Intl.plural(
        howMany,
        zero: 'Container',
        one: 'container',
        other: 'Containers',
        name: 'containersTitle',
        desc: 'Title for the Containers page',
        locale: locale.toString(),
        args: [howMany],
        examples: const {'howMany': 2},
      );
  String get containerRejectConfirmation => Intl.message(
        'Are you sure you want to reject this delivery?',
        name: 'containerRejectConfirmation',
        desc: 'Are you sure you want to reject this delivery?',
        locale: locale.toString(),
      );
  String get containerCancel => Intl.message(
        'Cancel',
        name: 'containerCancel',
        desc: 'Cancel',
        locale: locale.toString(),
      );
  String get containerReject => Intl.message(
        'Reject',
        name: 'ContainerReject',
        desc: 'Reject',
        locale: locale.toString(),
      );

  String get containerDelivered => Intl.message(
        'Delivered',
        name: 'containerDelivered',
        desc: 'Delivered',
        locale: locale.toString(),
      );
  String get containerAccept => Intl.message(
        'Accept',
        name: 'containerAccept',
        desc: 'Accept',
        locale: locale.toString(),
      );
  String get containerPending => Intl.message(
        'Pending',
        name: 'containerPending',
        desc: 'Pending',
        locale: locale.toString(),
      );
  String get containerCompleted => Intl.message(
        'Completed',
        name: 'containerCompleted',
        desc: 'Completed',
        locale: locale.toString(),
      );
  String get containerLFD => Intl.message(
        'LFD',
        name: 'containerLFD',
        desc: 'LFD',
        locale: locale.toString(),
      );
  String get containerReservationTime => Intl.message(
        'Reservation time',
        name: 'containerReservationTime',
        desc: 'Reservation time',
        locale: locale.toString(),
      );
  String get containerNoItem => Intl.message(
        'No items here',
        name: 'containerNoItem',
        desc: 'No items here',
        locale: locale.toString(),
      );

  String get containerSerialNumber => Intl.message(
        'Serial number',
        name: 'containerSerialNumber',
        desc: 'Serial number',
        locale: locale.toString(),
      );
  String get containerOrigin => Intl.message(
        'Origin',
        name: 'containerOrigin',
        desc: 'Origin',
        locale: locale.toString(),
      );
  String get containerDestination => Intl.message(
        'Destination',
        name: 'containerDestination',
        desc: 'Destination',
        locale: locale.toString(),
      );
  String get containerSize => Intl.message(
        'Container size',
        name: 'containerSize',
        desc: 'Container size',
        locale: locale.toString(),
      );
  String get containerType => Intl.message(
        'Container type',
        name: 'containerType',
        desc: 'Container type',
        locale: locale.toString(),
      );
  String get containerStatus => Intl.message(
        'Container status',
        name: 'containerStatus',
        desc: 'Container status',
        locale: locale.toString(),
      );
  String get containerAdd => Intl.message(
        'Add container',
        name: 'containerAdd',
        desc: 'Add container',
        locale: locale.toString(),
      );
  //customer
  String customersTitle(int howMany) => Intl.plural(
        howMany,
        zero: 'Customer',
        one: 'customer',
        other: 'Customers',
        name: 'customersTitle',
        desc: 'Title for the Customers page',
        locale: locale.toString(),
        args: [howMany],
        examples: const {'howMany': 2},
      );

  String get customerName => Intl.message(
        'Customer name',
        name: 'customername',
        desc: 'customerName',
        locale: locale.toString(),
      );
  String get addCustomer => Intl.message(
        'Add customer',
        name: 'addCustomer',
        desc: 'Add customer',
        locale: locale.toString(),
      );

  // params

  String paramEmpty(String param) => Intl.message(
        '$param should not be empty',
        name: 'paramEmpty',
        args: [param],
        desc: 'Param should not be empty',
        locale: locale.toString(),
        examples: const {'param': 'Serial number'},
      );
  String paramRequired(String param) => Intl.message(
        '$param is required',
        name: 'paramRequired',
        args: [param],
        desc: 'Param required',
        locale: locale.toString(),
        examples: const {'param': 'Name'},
      );
  String paramFromTo(String paramFrom, String paramTo) => Intl.message(
        '$paramFrom to $paramTo',
        name: 'paramFromTo',
        args: [paramFrom, paramTo],
        desc: 'ParamFrom to ParamTo',
        locale: locale.toString(),
        examples: const {'paramFrom': 'Canada', 'paramTo': 'China'},
      );
  String helloParam(String param) => Intl.message(
        'Hello $param',
        name: 'helloParam',
        args: [param],
        desc: 'Hello param',
        locale: locale.toString(),
        examples: const {'param': 'Username'},
      );
  String editParam(String param) => Intl.message(
        'Edit $param',
        name: 'editParam',
        args: [param],
        desc: 'Edit param',
        locale: locale.toString(),
        examples: const {'param': 'Container'},
      );
  String addNewParam(String param) => Intl.message(
        'Add new $param',
        name: 'addNewParam',
        args: [param],
        desc: 'Add new param',
        locale: locale.toString(),
        examples: const {'param': 'Container'},
      );
  String selectParam(String param) => Intl.message(
        'Select $param',
        name: 'selectParam',
        args: [param],
        desc: 'Select param',
        locale: locale.toString(),
        examples: const {'param': 'Container'},
      );
  //expandable
  String get lfd => Intl.message(
        'LFD',
        name: 'lfd',
        desc: 'LFD ',
        locale: locale.toString(),
      );
  String get reservationTime => Intl.message(
        'Reservation time',
        name: 'reservationTime',
        desc: 'Reservation time ',
        locale: locale.toString(),
      );
  String get size => Intl.message(
        'Size',
        name: 'size',
        desc: 'Size ',
        locale: locale.toString(),
      );
  String get status => Intl.message(
        'Status',
        name: 'status',
        desc: 'Status ',
        locale: locale.toString(),
      );
  String get eta => Intl.message(
        'ETA',
        name: 'eta',
        desc: 'ETA ',
        locale: locale.toString(),
      );
  String get createdAt => Intl.message(
        'Created at',
        name: 'createdAt',
        desc: 'Created at ',
        locale: locale.toString(),
      );
  String get lastUpdate => Intl.message(
        'Last update',
        name: 'lastUpdate',
        desc: 'Last update ',
        locale: locale.toString(),
      );
  String get tenantId => Intl.message(
        'Tenant ID',
        name: 'tenantId',
        desc: 'Tenant ID ',
        locale: locale.toString(),
      );

  String get email => Intl.message(
        'Email',
        name: 'email',
        desc: 'Email ',
        locale: locale.toString(),
      );
  String get role => Intl.message(
        'Role',
        name: 'roleParam',
        desc: 'Role param',
        locale: locale.toString(),
      );

  //other
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
  String get aboutUs => Intl.message(
        'About Us',
        name: 'aboutUs',
        desc: 'About Us',
        locale: locale.toString(),
      );

  String get password => Intl.message(
        'Password',
        name: 'password',
        desc: 'Password',
        locale: locale.toString(),
      );

  String get name => Intl.message(
        'Name',
        name: 'name',
        desc: 'Name',
        locale: locale.toString(),
      );
  String get welcome => Intl.message(
        'Welcome to Shipanther',
        name: 'welcome',
        desc: 'Welcome to Shipanther',
        locale: locale.toString(),
      );
  String get noDateChosen => Intl.message(
        'No date chosen',
        name: 'noDateChosen',
        desc: 'No date chosen',
        locale: locale.toString(),
      );

  String emailSent(String emailId) => Intl.message(
        'An Email has been sent to $emailId. Please check your inbox.',
        name: 'emailSent',
        desc: 'An Email has been sent',
        locale: locale.toString(),
        args: [emailId],
        examples: const {'emailId': 'info@bigpanther.ca'},
      );

  String get emailNotVerified => Intl.message(
        'This Email Id is not yet verified. Please try again.',
        name: 'emailNotVerified',
        desc: 'This Email Id is not yet verified. Please try again.',
        locale: locale.toString(),
      );
  String get resetPassword => Intl.message(
        'Reset Password',
        name: 'resetPassword',
        desc: 'Reset Password',
        locale: locale.toString(),
      );
  String get forgotPassword => Intl.message(
        'Forgot Password?',
        name: 'forgotPassword',
        desc: 'Forgot Password?',
        locale: locale.toString(),
      );
  String get resetPasswordMessage => Intl.message(
        'An email with the reset link would be sent to you.',
        name: 'resetPasswordMessage',
        desc: 'Reset password message',
        locale: locale.toString(),
      );
  String get profile => Intl.message(
        'Profile',
        name: 'profile',
        desc: 'profile',
        locale: locale.toString(),
      );
  String get save => Intl.message(
        'Save',
        name: 'save',
        desc: 'save',
        locale: locale.toString(),
      );
  String get edit => Intl.message(
        'Edit',
        name: 'edit',
        desc: 'edit',
        locale: locale.toString(),
      );
  String get create => Intl.message(
        'Create',
        name: 'create',
        desc: 'create',
        locale: locale.toString(),
      );
  String get passowrdDoesntMatch => Intl.message(
        'Passwords do not match',
        name: 'passowrdDoesntMatch',
        desc: 'Passwords do not match',
        locale: locale.toString(),
      );
  String get username => Intl.message(
        'Username',
        name: 'username',
        desc: 'Username',
        locale: locale.toString(),
      );
  String get confirmPassword => Intl.message(
        'Confirm password',
        name: 'confirmPassword',
        desc: 'Confirm password',
        locale: locale.toString(),
      );
  String get changePassword => Intl.message(
        'Change password',
        name: 'changePassword',
        desc: 'Change password',
        locale: locale.toString(),
      );
  String get newPassword => Intl.message(
        'New password',
        name: 'newPassword',
        desc: 'new password',
        locale: locale.toString(),
      );
  String get oldPassword => Intl.message(
        'Old password',
        name: 'oldPassword',
        desc: 'old password',
        locale: locale.toString(),
      );
  String get iVerified => Intl.message(
        'I verified',
        name: 'iVerified',
        desc: 'I verified',
        locale: locale.toString(),
      );
  String get resendEmail => Intl.message(
        'Resend email',
        name: 'resendEmail',
        desc: 'Resend email',
        locale: locale.toString(),
      );
  String get loginError => Intl.message(
        'An error occured during log-in. Please retry.',
        name: 'loginError',
        desc: 'An error occured during log-in. Please retry.',
        locale: locale.toString(),
      );
  String get driver => Intl.message(
        'driver',
        name: 'driver',
        desc: 'driver',
        locale: locale.toString(),
      );
  String get clear => Intl.message(
        'Clear',
        name: 'clear',
        desc: 'clear',
        locale: locale.toString(),
      );
  String get shipantherTitle => Intl.message(
        'Shipanther',
        name: 'shipantherTitle',
        desc: 'Shipanther',
        locale: locale.toString(),
      );
}

class ShipantherLocalizationsDelegate
    extends LocalizationsDelegate<ShipantherLocalizations> {
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
