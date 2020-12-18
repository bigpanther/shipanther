import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trober_sdk/api.dart' as api;

extension ContainerTypeExtension on api.ContainerType {
  IconData get icon {
    switch (this) {
      case api.ContainerType.incoming:
        return Icons.arrow_downward;
      case api.ContainerType.outGoing:
        return Icons.arrow_upward;
    }
    return Icons.broken_image;
  }

  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }
}

extension ContainerPercent on api.ContainerStatus {
  double get percentage {
    switch (this) {
      case api.ContainerStatus.unassigned:
        return 0.1;
      case api.ContainerStatus.inTransit:
        return 0.2;
      case api.ContainerStatus.arrived:
        return 0.3;
      case api.ContainerStatus.assigned:
        return 0.4;
      case api.ContainerStatus.accepted:
        return 0.5;
      case api.ContainerStatus.rejected:
        return 0.6;
      case api.ContainerStatus.loaded:
        return 0.7;
      case api.ContainerStatus.unloaded:
        return 0.8;
      case api.ContainerStatus.abandoned:
        return 1;
    }
    return 0.0;
  }
}

extension ContainerStatusExtension on api.ContainerStatus {
  IconData get icon {
    switch (this) {
      case api.ContainerStatus.unassigned:
        return MdiIcons.accessPointMinus;
      case api.ContainerStatus.inTransit:
        return MdiIcons.accessPointMinus;
      case api.ContainerStatus.arrived:
        return MdiIcons.accessPointMinus;
      case api.ContainerStatus.assigned:
        return MdiIcons.accessPointMinus;
      case api.ContainerStatus.accepted:
        return MdiIcons.accessPointMinus;
      case api.ContainerStatus.rejected:
        return MdiIcons.accessPointMinus;
      case api.ContainerStatus.loaded:
        return MdiIcons.accessPointMinus;
      case api.ContainerStatus.unloaded:
        return MdiIcons.accessPointMinus;
      case api.ContainerStatus.abandoned:
        return MdiIcons.accessPointMinus;
    }
    return Icons.broken_image;
  }

  // ignore: missing_return
  Color get color {
    switch (this) {
      case api.ContainerStatus.unassigned:
        return Colors.white;
      case api.ContainerStatus.inTransit:
        return Colors.white;
      case api.ContainerStatus.arrived:
        return Colors.greenAccent;
      case api.ContainerStatus.assigned:
        return Colors.orangeAccent;
      case api.ContainerStatus.accepted:
        return Colors.yellowAccent;
      case api.ContainerStatus.rejected:
        return Colors.red;
      case api.ContainerStatus.loaded:
        return Colors.white;
      case api.ContainerStatus.unloaded:
        return Colors.white;
      case api.ContainerStatus.abandoned:
        return Colors.white;
    }
  }

  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }
}

extension ContainerSizeExtension on api.ContainerSize {
  IconData get icon {
    switch (this) {
      case api.ContainerSize.n40sT:
        return MdiIcons.accessPointMinus;
      case api.ContainerSize.n20sT:
        return MdiIcons.accessPointMinus;
      case api.ContainerSize.n40hC:
        return MdiIcons.accessPointMinus;
      case api.ContainerSize.n40hW:
        return MdiIcons.accessPointMinus;
      case api.ContainerSize.custom:
        return MdiIcons.accessPointMinus;
    }
    return Icons.broken_image;
  }

  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }
}
