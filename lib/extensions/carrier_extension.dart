import 'package:flutter/material.dart';
import 'package:trober_sdk/trober_sdk.dart';

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
    throw 'invalid CarrierType';
  }

  String get text {
    return name;
  }
}
