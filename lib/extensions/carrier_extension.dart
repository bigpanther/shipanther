import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:trober_sdk/api.dart';

extension CarrierTypeExtension on CarrierType {
  IconData get icon {
    switch (this) {
      case CarrierType.air:
        return Icons.airplanemode_active;
      case CarrierType.rail:
        return Icons.train;
      case CarrierType.vessel:
        return Icons.directions_boat;
      case CarrierType.road:
        return Icons.local_shipping;
    }
  }

  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }
}
