// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class ShipantherLocalizations {
  ShipantherLocalizations();

  static ShipantherLocalizations? _current;

  static ShipantherLocalizations get current {
    assert(_current != null,
        'No instance of ShipantherLocalizations was loaded. Try to initialize the ShipantherLocalizations delegate before accessing ShipantherLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<ShipantherLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = ShipantherLocalizations();
      ShipantherLocalizations._current = instance;

      return instance;
    });
  }

  static ShipantherLocalizations of(BuildContext context) {
    final instance = ShipantherLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of ShipantherLocalizations present in the widget tree. Did you add ShipantherLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static ShipantherLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<ShipantherLocalizations>(
        context, ShipantherLocalizations);
  }

  /// `{howMany,plural, =0{Tenant}=1{Tenant}other{Tenants}}`
  String tenantsTitle(num howMany) {
    return Intl.plural(
      howMany,
      zero: 'Tenant',
      one: 'Tenant',
      other: 'Tenants',
      name: 'tenantsTitle',
      desc: 'Title for the Tenants page',
      args: [howMany],
    );
  }

  /// `Thanks for signing up. We will review your registration. We are in a limited beta at the moment. Please check back later.`
  String get tenantLessUserMessage {
    return Intl.message(
      'Thanks for signing up. We will review your registration. We are in a limited beta at the moment. Please check back later.',
      name: 'tenantLessUserMessage',
      desc: 'Message to display when a new user signs up',
      args: [],
    );
  }

  /// `Tenant name`
  String get tenantName {
    return Intl.message(
      'Tenant name',
      name: 'tenantName',
      desc: 'Tenant name',
      args: [],
    );
  }

  /// `Tenant type`
  String get tenantType {
    return Intl.message(
      'Tenant type',
      name: 'tenantType',
      desc: 'Tenant type',
      args: [],
    );
  }

  /// `Filter tenant type`
  String get tenantTypeFilter {
    return Intl.message(
      'Filter tenant type',
      name: 'tenantTypeFilter',
      desc: 'Filter tenant type',
      args: [],
    );
  }

  /// `Add tenant`
  String get tenantAdd {
    return Intl.message(
      'Add tenant',
      name: 'tenantAdd',
      desc: 'Add tenant',
      args: [],
    );
  }

  /// `Tenant detail`
  String get tenantDetail {
    return Intl.message(
      'Tenant detail',
      name: 'tenantDetail',
      desc: 'Tenant detail',
      args: [],
    );
  }

  /// `Tenant delete`
  String get tenantDelete {
    return Intl.message(
      'Tenant delete',
      name: 'tenantDelete',
      desc: 'Tenant delete',
      args: [],
    );
  }

  /// `Tenant edit`
  String get tenantEdit {
    return Intl.message(
      'Tenant edit',
      name: 'tenantEdit',
      desc: 'Tenant edit',
      args: [],
    );
  }

  /// `{howMany,plural, =0{Terminal}=1{Terminal}other{Terminals}}`
  String terminalsTitle(num howMany) {
    return Intl.plural(
      howMany,
      zero: 'Terminal',
      one: 'Terminal',
      other: 'Terminals',
      name: 'terminalsTitle',
      desc: 'Title for the Terminals page',
      args: [howMany],
    );
  }

  /// `Terminal name`
  String get terminalName {
    return Intl.message(
      'Terminal name',
      name: 'terminalName',
      desc: 'Terminal name',
      args: [],
    );
  }

  /// `Terminal type`
  String get terminalType {
    return Intl.message(
      'Terminal type',
      name: 'terminalType',
      desc: 'Terminal type',
      args: [],
    );
  }

  /// `Filter terminal type`
  String get terminalTypeFilter {
    return Intl.message(
      'Filter terminal type',
      name: 'terminalTypeFilter',
      desc: 'Filter terminal type',
      args: [],
    );
  }

  /// `Add terminal`
  String get terminalAdd {
    return Intl.message(
      'Add terminal',
      name: 'terminalAdd',
      desc: 'Add terminal',
      args: [],
    );
  }

  /// `{howMany,plural, =0{Order}=1{Order}other{Orders}}`
  String ordersTitle(num howMany) {
    return Intl.plural(
      howMany,
      zero: 'Order',
      one: 'Order',
      other: 'Orders',
      name: 'ordersTitle',
      desc: 'Title for the Orders page',
      args: [howMany],
    );
  }

  /// `Order number`
  String get orderNumber {
    return Intl.message(
      'Order number',
      name: 'orderNumber',
      desc: 'Order number',
      args: [],
    );
  }

  /// `Order status`
  String get orderStatus {
    return Intl.message(
      'Order status',
      name: 'orderStatus',
      desc: 'Order status',
      args: [],
    );
  }

  /// `Filter order status`
  String get orderStatusFilter {
    return Intl.message(
      'Filter order status',
      name: 'orderStatusFilter',
      desc: 'Filter Order status',
      args: [],
    );
  }

  /// `Add order`
  String get orderAdd {
    return Intl.message(
      'Add order',
      name: 'orderAdd',
      desc: 'Add order',
      args: [],
    );
  }

  /// `{howMany,plural, =0{User}=1{User}other{Users}}`
  String usersTitle(num howMany) {
    return Intl.plural(
      howMany,
      zero: 'User',
      one: 'User',
      other: 'Users',
      name: 'usersTitle',
      desc: 'Title for the Users page',
      args: [howMany],
    );
  }

  /// `User name`
  String get userName {
    return Intl.message(
      'User name',
      name: 'userName',
      desc: 'User name',
      args: [],
    );
  }

  /// `User type`
  String get userType {
    return Intl.message(
      'User type',
      name: 'userType',
      desc: 'User type',
      args: [],
    );
  }

  /// `Filter user type`
  String get userTypeFilter {
    return Intl.message(
      'Filter user type',
      name: 'userTypeFilter',
      desc: 'Filter user type',
      args: [],
    );
  }

  /// `{howMany,plural, =0{Carrier}=1{Carrier}other{Carriers}}`
  String carriersTitle(num howMany) {
    return Intl.plural(
      howMany,
      zero: 'Carrier',
      one: 'Carrier',
      other: 'Carriers',
      name: 'carriersTitle',
      desc: 'Title for the Carriers page',
      args: [howMany],
    );
  }

  /// `ETA`
  String get carriersETA {
    return Intl.message(
      'ETA',
      name: 'carriersETA',
      desc: 'ETA',
      args: [],
    );
  }

  /// `Carrier name`
  String get carrierName {
    return Intl.message(
      'Carrier name',
      name: 'carrierName',
      desc: 'Carrier name',
      args: [],
    );
  }

  /// `Carrier type`
  String get carrierType {
    return Intl.message(
      'Carrier type',
      name: 'carrierType',
      desc: 'Carrier type',
      args: [],
    );
  }

  /// `Add carrier`
  String get addCarrier {
    return Intl.message(
      'Add carrier',
      name: 'addCarrier',
      desc: 'Add carrier',
      args: [],
    );
  }

  /// `{howMany,plural, =0{Shipment}=1{Shipment}other{Shipments}}`
  String shipmentsTitle(num howMany) {
    return Intl.plural(
      howMany,
      zero: 'Shipment',
      one: 'Shipment',
      other: 'Shipments',
      name: 'shipmentsTitle',
      desc: 'Title for the Shipments page',
      args: [howMany],
    );
  }

  /// `Are you sure you want to reject this delivery?`
  String get shipmentRejectConfirmation {
    return Intl.message(
      'Are you sure you want to reject this delivery?',
      name: 'shipmentRejectConfirmation',
      desc: 'Are you sure you want to reject this delivery?',
      args: [],
    );
  }

  /// `Cancel`
  String get shipmentCancel {
    return Intl.message(
      'Cancel',
      name: 'shipmentCancel',
      desc: 'Cancel',
      args: [],
    );
  }

  /// `Reject`
  String get shipmentReject {
    return Intl.message(
      'Reject',
      name: 'shipmentReject',
      desc: 'Reject',
      args: [],
    );
  }

  /// `Delivered`
  String get shipmentDelivered {
    return Intl.message(
      'Delivered',
      name: 'shipmentDelivered',
      desc: 'Delivered',
      args: [],
    );
  }

  /// `Accept`
  String get shipmentAccept {
    return Intl.message(
      'Accept',
      name: 'shipmentAccept',
      desc: 'Accept',
      args: [],
    );
  }

  /// `Pending`
  String get shipmentPending {
    return Intl.message(
      'Pending',
      name: 'shipmentPending',
      desc: 'Pending',
      args: [],
    );
  }

  /// `Completed`
  String get shipmentCompleted {
    return Intl.message(
      'Completed',
      name: 'shipmentCompleted',
      desc: 'Completed',
      args: [],
    );
  }

  /// `LFD`
  String get shipmentLFD {
    return Intl.message(
      'LFD',
      name: 'shipmentLFD',
      desc: 'LFD',
      args: [],
    );
  }

  /// `Reservation time`
  String get shipmentReservationTime {
    return Intl.message(
      'Reservation time',
      name: 'shipmentReservationTime',
      desc: 'Reservation time',
      args: [],
    );
  }

  /// `No items here`
  String get shipmentNoItem {
    return Intl.message(
      'No items here',
      name: 'shipmentNoItem',
      desc: 'No items here',
      args: [],
    );
  }

  /// `Serial number`
  String get shipmentSerialNumber {
    return Intl.message(
      'Serial number',
      name: 'shipmentSerialNumber',
      desc: 'Serial number',
      args: [],
    );
  }

  /// `Origin`
  String get shipmentOrigin {
    return Intl.message(
      'Origin',
      name: 'shipmentOrigin',
      desc: 'Origin',
      args: [],
    );
  }

  /// `Destination`
  String get shipmentDestination {
    return Intl.message(
      'Destination',
      name: 'shipmentDestination',
      desc: 'Destination',
      args: [],
    );
  }

  /// `Shipment size`
  String get shipmentSize {
    return Intl.message(
      'Shipment size',
      name: 'shipmentSize',
      desc: 'Shipment size',
      args: [],
    );
  }

  /// `Shipment type`
  String get shipmentType {
    return Intl.message(
      'Shipment type',
      name: 'shipmentType',
      desc: 'Shipment type',
      args: [],
    );
  }

  /// `Shipment status`
  String get shipmentStatus {
    return Intl.message(
      'Shipment status',
      name: 'shipmentStatus',
      desc: 'Shipment status',
      args: [],
    );
  }

  /// `Add shipment`
  String get shipmentAdd {
    return Intl.message(
      'Add shipment',
      name: 'shipmentAdd',
      desc: 'Add shipment',
      args: [],
    );
  }

  /// `Filter shipment status`
  String get shipmentStatusFilter {
    return Intl.message(
      'Filter shipment status',
      name: 'shipmentStatusFilter',
      desc: 'Add shipment',
      args: [],
    );
  }

  /// `{howMany,plural, =0{Customer}=1{Customer}other{Customers}}`
  String customersTitle(num howMany) {
    return Intl.plural(
      howMany,
      zero: 'Customer',
      one: 'Customer',
      other: 'Customers',
      name: 'customersTitle',
      desc: 'Title for the Customers page',
      args: [howMany],
    );
  }

  /// `Customer name`
  String get customerName {
    return Intl.message(
      'Customer name',
      name: 'customerName',
      desc: 'Customer name',
      args: [],
    );
  }

  /// `Add customer`
  String get addCustomer {
    return Intl.message(
      'Add customer',
      name: 'addCustomer',
      desc: 'Add customer',
      args: [],
    );
  }

  /// `{param} should not be empty`
  String paramEmpty(Object param) {
    return Intl.message(
      '$param should not be empty',
      name: 'paramEmpty',
      desc: 'Param should not be empty',
      args: [param],
    );
  }

  /// `{param} is required`
  String paramRequired(Object param) {
    return Intl.message(
      '$param is required',
      name: 'paramRequired',
      desc: 'Param required',
      args: [param],
    );
  }

  /// `{paramFrom} to {paramTo}`
  String paramFromTo(Object paramFrom, Object paramTo) {
    return Intl.message(
      '$paramFrom to $paramTo',
      name: 'paramFromTo',
      desc: 'ParamFrom to ParamTo',
      args: [paramFrom, paramTo],
    );
  }

  /// `Hello {param}`
  String helloParam(Object param) {
    return Intl.message(
      'Hello $param',
      name: 'helloParam',
      desc: 'Hello param',
      args: [param],
    );
  }

  /// `Edit {param}`
  String editParam(Object param) {
    return Intl.message(
      'Edit $param',
      name: 'editParam',
      desc: 'Edit param',
      args: [param],
    );
  }

  /// `Add new {param}`
  String addNewParam(Object param) {
    return Intl.message(
      'Add new $param',
      name: 'addNewParam',
      desc: 'Add new param',
      args: [param],
    );
  }

  /// `Select {param}`
  String selectParam(Object param) {
    return Intl.message(
      'Select $param',
      name: 'selectParam',
      desc: 'Select param',
      args: [param],
    );
  }

  /// `Reservation time`
  String get reservationTime {
    return Intl.message(
      'Reservation time',
      name: 'reservationTime',
      desc: 'Reservation time ',
      args: [],
    );
  }

  /// `Size`
  String get size {
    return Intl.message(
      'Size',
      name: 'size',
      desc: 'Size ',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: 'Status ',
      args: [],
    );
  }

  /// `ETA`
  String get eta {
    return Intl.message(
      'ETA',
      name: 'eta',
      desc: 'ETA ',
      args: [],
    );
  }

  /// `Created at`
  String get createdAt {
    return Intl.message(
      'Created at',
      name: 'createdAt',
      desc: 'Created at ',
      args: [],
    );
  }

  /// `Last update`
  String get lastUpdate {
    return Intl.message(
      'Last update',
      name: 'lastUpdate',
      desc: 'Last update ',
      args: [],
    );
  }

  /// `Tenant ID`
  String get tenantId {
    return Intl.message(
      'Tenant ID',
      name: 'tenantId',
      desc: 'Tenant ID ',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: 'Email',
      args: [],
    );
  }

  /// `Role`
  String get role {
    return Intl.message(
      'Role',
      name: 'role',
      desc: 'Role',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: 'Home',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: 'Logout',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: 'Sign In',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: 'Register',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: 'Settings',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: 'About Us',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: 'Password',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: 'Name',
      args: [],
    );
  }

  /// `Welcome to Shipanther`
  String get welcome {
    return Intl.message(
      'Welcome to Shipanther',
      name: 'welcome',
      desc: 'Welcome to Shipanther',
      args: [],
    );
  }

  /// `No date chosen`
  String get noDateChosen {
    return Intl.message(
      'No date chosen',
      name: 'noDateChosen',
      desc: 'No date chosen',
      args: [],
    );
  }

  /// `An Email has been sent to {emailId}. Please check your inbox.`
  String emailSent(Object emailId) {
    return Intl.message(
      'An Email has been sent to $emailId. Please check your inbox.',
      name: 'emailSent',
      desc: 'An Email has been sent',
      args: [emailId],
    );
  }

  /// `This Email Id is not yet verified. Please try again.`
  String get emailNotVerified {
    return Intl.message(
      'This Email Id is not yet verified. Please try again.',
      name: 'emailNotVerified',
      desc: 'This Email Id is not yet verified. Please try again.',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: 'Reset Password',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: 'Forgot Password?',
      args: [],
    );
  }

  /// `An email with the reset link would be sent to you.`
  String get resetPasswordMessage {
    return Intl.message(
      'An email with the reset link would be sent to you.',
      name: 'resetPasswordMessage',
      desc: 'Reset password message',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: 'profile',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: 'save',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: 'edit',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: 'create',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordDoesntMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordDoesntMatch',
      desc: 'Passwords do not match',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: 'Username',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
      desc: 'Confirm password',
      args: [],
    );
  }

  /// `Change password`
  String get changePassword {
    return Intl.message(
      'Change password',
      name: 'changePassword',
      desc: 'Change password',
      args: [],
    );
  }

  /// `New password`
  String get newPassword {
    return Intl.message(
      'New password',
      name: 'newPassword',
      desc: 'new password',
      args: [],
    );
  }

  /// `Old password`
  String get oldPassword {
    return Intl.message(
      'Old password',
      name: 'oldPassword',
      desc: 'old password',
      args: [],
    );
  }

  /// `I verified`
  String get iVerified {
    return Intl.message(
      'I verified',
      name: 'iVerified',
      desc: 'I verified',
      args: [],
    );
  }

  /// `Resend email`
  String get resendEmail {
    return Intl.message(
      'Resend email',
      name: 'resendEmail',
      desc: 'Resend email',
      args: [],
    );
  }

  /// `An error occured during log-in. Please retry.`
  String get loginError {
    return Intl.message(
      'An error occured during log-in. Please retry.',
      name: 'loginError',
      desc: 'An error occured during log-in. Please retry.',
      args: [],
    );
  }

  /// `driver`
  String get driver {
    return Intl.message(
      'driver',
      name: 'driver',
      desc: 'driver',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: 'clear',
      args: [],
    );
  }

  /// `Shipanther`
  String get shipantherTitle {
    return Intl.message(
      'Shipanther',
      name: 'shipantherTitle',
      desc: 'Shipanther',
      args: [],
    );
  }

  /// `©2020-2022 Big Panther Technologies Inc.`
  String get applicationLegalese {
    return Intl.message(
      '©2020-2022 Big Panther Technologies Inc.',
      name: 'applicationLegalese',
      desc: '©2020-2022 Big Panther Technologies Inc.',
      args: [],
    );
  }

  /// `Built with ♥️ in Canada`
  String get madeWithLove {
    return Intl.message(
      'Built with ♥️ in Canada',
      name: 'madeWithLove',
      desc: 'Built with ♥️ in Canada',
      args: [],
    );
  }

  /// `Reach us at`
  String get reachUsAt {
    return Intl.message(
      'Reach us at',
      name: 'reachUsAt',
      desc: 'Reach us at',
      args: [],
    );
  }

  /// `New in this update`
  String get whatsNew {
    return Intl.message(
      'New in this update',
      name: 'whatsNew',
      desc: 'New in this update',
      args: [],
    );
  }

  /// `Manage your shipping business with ease. Shipanther helps you track your deliveries, update customers and manage orders.`
  String get homePageText {
    return Intl.message(
      'Manage your shipping business with ease. Shipanther helps you track your deliveries, update customers and manage orders.',
      name: 'homePageText',
      desc: 'home page text',
      args: [],
    );
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<ShipantherLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pa'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<ShipantherLocalizations> load(Locale locale) =>
      ShipantherLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
