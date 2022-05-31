import 'package:flutter/material.dart';
import 'package:trober_sdk/trober_sdk.dart';

extension OrderStatusExtension on OrderStatus {
  IconData get icon {
    switch (this) {
      case OrderStatus.open:
        return Icons.read_more;
      case OrderStatus.cancelled:
        return Icons.cancel;
      case OrderStatus.inProgress:
        return Icons.query_builder;
      case OrderStatus.delivered:
        return Icons.check_circle_outline;
      case OrderStatus.invoiced:
        return Icons.attach_money;
      case OrderStatus.paymentReceived:
        return Icons.money;
      case OrderStatus.accepted:
        return Icons.check;
    }
    throw 'noop';
  }
}
