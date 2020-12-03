import 'package:flutter/material.dart';
import 'package:trober_sdk/api.dart';

extension TerminalExtension on Terminal {
  // ignore: missing_return
  IconData get icon {
    switch (this.type) {
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
  }
}
