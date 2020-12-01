import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trober_sdk/api.dart';

extension TenantExtension on Tenant {
  IconData get icon {
    switch (this.type) {
      case TenantType.production:
        return Icons.money;
      case TenantType.system:
        return Icons.home_work;
      case TenantType.test:
        return Icons.home_work;
    }
  }
}
