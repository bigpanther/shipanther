import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trober_sdk/api.dart' as api;

extension ShipmentTypeExtension on api.ShipmentType {
  IconData get icon {
    switch (this) {
      case api.ShipmentType.incoming:
        return Icons.arrow_downward;
      case api.ShipmentType.outGoing:
        return Icons.arrow_upward;
    }
    return Icons.broken_image;
  }

  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }
}

extension ShipmentPercent on api.ShipmentStatus {
  double get percentage {
    switch (this) {
      case api.ShipmentStatus.unassigned:
        return 0.1;
      case api.ShipmentStatus.inTransit:
        return 0.2;
      case api.ShipmentStatus.arrived:
        return 0.3;
      case api.ShipmentStatus.assigned:
        return 0.4;
      case api.ShipmentStatus.accepted:
        return 0.5;
      case api.ShipmentStatus.rejected:
        return 0.6;
      case api.ShipmentStatus.loaded:
        return 0.7;
      case api.ShipmentStatus.unloaded:
        return 0.8;
      case api.ShipmentStatus.abandoned:
        return 1;
    }
    return 0.0;
  }
}

extension ShipmentStatusExtension on api.ShipmentStatus {
  IconData get icon {
    switch (this) {
      case api.ShipmentStatus.unassigned:
        return MdiIcons.accessPointMinus;
      case api.ShipmentStatus.inTransit:
        return MdiIcons.accessPointMinus;
      case api.ShipmentStatus.arrived:
        return MdiIcons.accessPointMinus;
      case api.ShipmentStatus.assigned:
        return MdiIcons.accessPointMinus;
      case api.ShipmentStatus.accepted:
        return MdiIcons.accessPointMinus;
      case api.ShipmentStatus.rejected:
        return MdiIcons.accessPointMinus;
      case api.ShipmentStatus.loaded:
        return MdiIcons.accessPointMinus;
      case api.ShipmentStatus.unloaded:
        return MdiIcons.accessPointMinus;
      case api.ShipmentStatus.abandoned:
        return MdiIcons.accessPointMinus;
    }
    return Icons.broken_image;
  }

  // ignore: missing_return
  Color get color {
    switch (this) {
      case api.ShipmentStatus.unassigned:
        return Colors.white;
      case api.ShipmentStatus.inTransit:
        return Colors.white;
      case api.ShipmentStatus.arrived:
        return Colors.greenAccent;
      case api.ShipmentStatus.assigned:
        return Colors.orangeAccent;
      case api.ShipmentStatus.accepted:
        return Colors.yellowAccent;
      case api.ShipmentStatus.rejected:
        return Colors.red;
      case api.ShipmentStatus.loaded:
        return Colors.white;
      case api.ShipmentStatus.unloaded:
        return Colors.white;
      case api.ShipmentStatus.abandoned:
        return Colors.white;
    }
  }

  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }
}

extension ShipmentSizeExtension on api.ShipmentSize {
  IconData get icon {
    switch (this) {
      case api.ShipmentSize.n40sT:
        return MdiIcons.accessPointMinus;
      case api.ShipmentSize.n20sT:
        return MdiIcons.accessPointMinus;
      case api.ShipmentSize.n40hC:
        return MdiIcons.accessPointMinus;
      case api.ShipmentSize.n40hW:
        return MdiIcons.accessPointMinus;
      case api.ShipmentSize.custom:
        return MdiIcons.accessPointMinus;
    }
    return Icons.broken_image;
  }

  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }
}
