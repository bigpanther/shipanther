import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shipanther/router/router.gr.dart';
import 'package:trober_sdk/trober_sdk.dart';

extension UserExtension on User {
  bool get isAtleastBackOffice {
    return [UserRole.superAdmin, UserRole.admin, UserRole.backOffice]
        .contains(role);
  }

  bool get isDriver {
    return role == UserRole.driver;
  }

  bool get isSuperAdmin {
    return role == UserRole.superAdmin;
  }

  bool get isCustomer {
    return role == UserRole.customer;
  }

  bool get isAtleastTenantBackOffice {
    return role == UserRole.admin || role == UserRole.backOffice;
  }

  bool get isAdmin {
    return role == UserRole.admin;
  }

  bool get isBackOffice {
    return role == UserRole.backOffice;
  }

  PageRouteInfo get homePage {
    switch (role) {
      case UserRole.superAdmin:
        return SuperAdminHome(user: this);
      case UserRole.admin:
        return BackOfficeHome(user: this);
      case UserRole.backOffice:
        return BackOfficeHome(user: this);
      case UserRole.driver:
        return DriverHome(user: this);
      case UserRole.customer:
        return CustomerHome(user: this);
      case UserRole.none:
        return NoneHome(user: this);
    }
    throw 'noop';
  }
}

extension UserRoleExtension on UserRole {
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
    throw 'noop';
  }
}
