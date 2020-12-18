import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:trober_sdk/api.dart';

extension TerminalTypeExtension on TerminalType {
  IconData get icon {
    switch (this) {
      case TerminalType.rail:
        return Icons.train;
      case TerminalType.port:
        return Icons.directions_boat;
      case TerminalType.warehouse:
        return Icons.house;
      case TerminalType.yard:
        return Icons.directions_boat;
      case TerminalType.custom:
        return Icons.local_shipping;
    }
    return Icons.broken_image;
  }

  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }
}
