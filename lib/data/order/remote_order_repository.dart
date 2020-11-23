import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/order/order_repository.dart';

import 'package:trober_sdk/api.dart';

class RemoteOrderRepository extends OrderRepository {
  final ApiRepository _apiRepository;

  const RemoteOrderRepository(this._apiRepository);
  @override
  Future<Order> fetchOrder(String id) async {
    var client = await _apiRepository.apiClient();
    return await client.ordersIdGet(id);
  }

  @override
  Future<List<Order>> fetchOrders() async {
    var client = await _apiRepository.apiClient();
    return await client.ordersGet();
  }

  @override
  Future<Order> createOrder(Order order) async {
    var client = await _apiRepository.apiClient();
    return await client.ordersPost(order: order);
  }

  @override
  Future<Order> updateOrder(String id, Order order) async {
    var client = await _apiRepository.apiClient();
    return await client.ordersIdPut(id, order: order);
  }

  @override
  Future<List<Order>> fetchOrdersOfTenant(String tenantId) async {
    var orders = await fetchOrders();

    return orders.where((e) => e.tenantId == tenantId).toList();
  }
}
