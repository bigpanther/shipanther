import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
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
