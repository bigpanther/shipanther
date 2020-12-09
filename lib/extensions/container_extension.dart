import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
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
        // TODO: Handle this case.
        break;
      case api.ContainerStatus.inTransit:
        // TODO: Handle this case.
        break;
      case api.ContainerStatus.arrived:
        // TODO: Handle this case.
        break;
      case api.ContainerStatus.assigned:
        // TODO: Handle this case.
        break;
      case api.ContainerStatus.accepted:
        // TODO: Handle this case.
        break;
      case api.ContainerStatus.rejected:
        // TODO: Handle this case.
        break;
      case api.ContainerStatus.loaded:
        // TODO: Handle this case.
        break;
      case api.ContainerStatus.unloaded:
        // TODO: Handle this case.
        break;
      case api.ContainerStatus.abandoned:
        // TODO: Handle this case.
        break;
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
        // TODO: Handle this case.
        break;
      case api.ContainerSize.n20sT:
        // TODO: Handle this case.
        break;
      case api.ContainerSize.n40hC:
        // TODO: Handle this case.
        break;
      case api.ContainerSize.n40hW:
        // TODO: Handle this case.
        break;
      case api.ContainerSize.custom:
        // TODO: Handle this case.
        break;
    }
  }

  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }
}
