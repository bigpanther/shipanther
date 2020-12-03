import 'package:flutter/material.dart';
import 'package:trober_sdk/api.dart';

extension CarrierExtension on Carrier {
  // ignore: missing_return
  IconData get icon {
    switch (this.type) {
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
}
