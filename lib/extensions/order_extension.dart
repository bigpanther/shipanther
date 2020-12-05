import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:trober_sdk/api.dart';

extension OrderStatusExtension on OrderStatus {
  // ignore: missing_return
  IconData get icon {
    switch (this) {
      case OrderStatus.open:
        // TODO: Handle this case.
        break;
      case OrderStatus.cancelled:
        // TODO: Handle this case.
        break;
      case OrderStatus.inProgress:
        // TODO: Handle this case.
        break;
      case OrderStatus.delivered:
        // TODO: Handle this case.
        break;
      case OrderStatus.invoiced:
        // TODO: Handle this case.
        break;
      case OrderStatus.paymentReceived:
        // TODO: Handle this case.
        break;
      case OrderStatus.accepted:
        // TODO: Handle this case.
        break;
    }
  }

  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }
}
