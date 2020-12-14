import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trober_sdk/api.dart' as api;

extension ContainerTypeExtension on api.ContainerType {
  // ignore: missing_return
  IconData get icon {
    switch (this) {
      case api.ContainerType.incoming:
        return Icons.arrow_downward;
      case api.ContainerType.outGoing:
        return Icons.arrow_upward;
    }
  }

  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }
}

extension ContainerStatusExtension on api.ContainerStatus {
  // ignore: missing_return
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
  // ignore: missing_return
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
  }

  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }
}
