import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trober_sdk/api.dart';

extension ShipmentTypeExtension on ShipmentType {
  IconData get icon {
    switch (this) {
      case ShipmentType.incoming:
        return Icons.arrow_downward;
      case ShipmentType.outGoing:
        return Icons.arrow_upward;
    }
  }

  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }
}

extension ShipmentPercent on ShipmentStatus {
  double get percentage {
    switch (this) {
      case ShipmentStatus.unassigned:
        return 0.1;
      case ShipmentStatus.inTransit:
        return 0.2;
      case ShipmentStatus.arrived:
        return 0.3;
      case ShipmentStatus.assigned:
        return 0.4;
      case ShipmentStatus.accepted:
        return 0.5;
      case ShipmentStatus.rejected:
        return 0.6;
      case ShipmentStatus.loaded:
        return 0.7;
      case ShipmentStatus.unloaded:
        return 0.8;
      case ShipmentStatus.abandoned:
        return 1;
    }
  }
}

extension ShipmentStatusExtension on ShipmentStatus {
  IconData get icon {
    switch (this) {
      case ShipmentStatus.unassigned:
        return MdiIcons.accessPointMinus;
      case ShipmentStatus.inTransit:
        return MdiIcons.accessPointMinus;
      case ShipmentStatus.arrived:
        return MdiIcons.accessPointMinus;
      case ShipmentStatus.assigned:
        return MdiIcons.accessPointMinus;
      case ShipmentStatus.accepted:
        return MdiIcons.accessPointMinus;
      case ShipmentStatus.rejected:
        return MdiIcons.accessPointMinus;
      case ShipmentStatus.loaded:
        return MdiIcons.accessPointMinus;
      case ShipmentStatus.unloaded:
        return MdiIcons.accessPointMinus;
      case ShipmentStatus.abandoned:
        return MdiIcons.accessPointMinus;
    }
  }

  Color? color({Color? baseColor}) {
    switch (this) {
      case ShipmentStatus.unassigned:
        return baseColor;
      case ShipmentStatus.inTransit:
        return Colors.blue;
      case ShipmentStatus.arrived:
        return Colors.green;
      case ShipmentStatus.assigned:
        return Colors.orange;
      case ShipmentStatus.accepted:
        return Colors.yellow;
      case ShipmentStatus.rejected:
        return Colors.red;
      case ShipmentStatus.loaded:
        return baseColor;
      case ShipmentStatus.unloaded:
        return baseColor;
      case ShipmentStatus.abandoned:
        return baseColor;
    }
  }

  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }
}

extension ShipmentSizeExtension on ShipmentSize {
  IconData get icon {
    switch (this) {
      case ShipmentSize.n40sT:
        return MdiIcons.accessPointMinus;
      case ShipmentSize.n20sT:
        return MdiIcons.accessPointMinus;
      case ShipmentSize.n40hC:
        return MdiIcons.accessPointMinus;
      case ShipmentSize.n40hW:
        return MdiIcons.accessPointMinus;
      case ShipmentSize.custom:
        return MdiIcons.accessPointMinus;
    }
  }

  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }
}
