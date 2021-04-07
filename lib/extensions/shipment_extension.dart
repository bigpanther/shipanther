import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trober_sdk/trober_sdk.dart';

extension ShipmentTypeExtension on ShipmentType {
  IconData get icon {
    switch (this) {
      case ShipmentType.inbound:
        return Icons.arrow_downward;
      case ShipmentType.outbound:
        return Icons.arrow_upward;
    }
    throw 'invalid ShipmentType';
  }

  String get text {
    return name;
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
        return 0.5;
      case ShipmentStatus.assigned:
        return 0.55;
      case ShipmentStatus.rejected:
        return 0.60;
      case ShipmentStatus.accepted:
        return 0.8;
      case ShipmentStatus.loaded:
        return 0.9;
      case ShipmentStatus.delivered:
        return 1;
    }
    throw 'invalid ShipmentStatus';
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
      case ShipmentStatus.delivered:
        return MdiIcons.accessPointMinus;
    }
    throw 'invalid ShipmentStatus';
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
      case ShipmentStatus.delivered:
        return Colors.green;
    }
  }

  String get text {
    return name;
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
      default:
        return Icons.panorama_fish_eye;
    }
  }

  String get text {
    // ignore: unnecessary_null_comparison
    if (this == null) {
      return '';
    }
    return name;
  }
}
