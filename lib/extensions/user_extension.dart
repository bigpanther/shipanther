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

  IconData get icon {
    switch (this.role) {
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
}
