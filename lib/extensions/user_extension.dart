import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:shipanther/screens/back_office_home.dart';
import 'package:shipanther/screens/customer_home.dart';
import 'package:shipanther/screens/driver_home.dart';
import 'package:shipanther/screens/none_home.dart';
import 'package:shipanther/screens/super_admin_home.dart';
import 'package:trober_sdk/api.dart';

extension UserExtension on User {
  bool get isAtleastBackOffice {
    return [UserRole.superAdmin, UserRole.admin, UserRole.backOffice]
        .contains(this.role);
  }

  bool get isDriver {
    return this.role == UserRole.driver;
  }

  bool get isSuperAdmin {
    return this.role == UserRole.superAdmin;
  }

  bool get isCustomer {
    return this.role == UserRole.customer;
  }

  bool get isAtleastTenantBackOffice {
    return this.role == UserRole.admin || this.role == UserRole.backOffice;
  }

  bool get isAdmin {
    return this.role == UserRole.admin;
  }

  bool get isBackOffice {
    return this.role == UserRole.backOffice;
  }

  // ignore: missing_return
  Widget get homePage {
    switch (this.role) {
      case UserRole.superAdmin:
        return SuperAdminHome(this);
      case UserRole.admin:
        return BackOfficeHome(this);
      case UserRole.backOffice:
        return BackOfficeHome(this);
      case UserRole.driver:
        return DriverHome(this);
      case UserRole.customer:
        return CustomerHome(this);
      case UserRole.none:
        return NoneHome(this);
    }
  }
}

extension UserRoleExtension on UserRole {
  // ignore: missing_return
  IconData get icon {
    switch (this) {
      case UserRole.superAdmin:
        return Icons.android;
      case UserRole.admin:
        return Icons.person_add;
      case UserRole.backOffice:
        return Icons.person;
      case UserRole.driver:
        return Icons.local_shipping;
      case UserRole.customer:
        return Icons.perm_identity;
      case UserRole.none:
        return Icons.not_accessible;
    }
  }

  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }
}
