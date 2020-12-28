import 'package:trober_sdk/api.dart';

abstract class OrderRepository {
  const OrderRepository();
  Future<Order> fetchOrder(String id);
  Future<Order> createOrder(Order order);
  Future<Order> updateOrder(String id, Order order);
  Future<List<Order>> fetchOrders(
      {int? page = 1,
      OrderStatus? orderStatus,
      String? customerId,
      String? serialNumber});
}
