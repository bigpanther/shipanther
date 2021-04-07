import 'package:trober_sdk/trober_sdk.dart';

abstract class OrderRepository {
  const OrderRepository();
  Future<Order?> fetchOrder(String id);
  Future<Order?> createOrder(Order order);
  Future<Order?> updateOrder(String id, Order order);
  Future<Iterable<Order>> fetchOrders(
      {int? page = 1,
      OrderStatus? orderStatus,
      String? customerId,
      String? serialNumber});
}
