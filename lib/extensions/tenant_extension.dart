import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:trober_sdk/trober_sdk.dart';

extension TenantTypeExtension on TenantType {
  IconData get icon {
    switch (this) {
      case TenantType.production:
        return Icons.money;
      case TenantType.system:
        return Icons.home_work;
      case TenantType.test:
        return Icons.home_work;
    }
    throw 'invalid TenantType';
  }

  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }
}
