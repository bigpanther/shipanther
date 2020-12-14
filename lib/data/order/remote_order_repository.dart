import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/order/order_repository.dart';
import 'package:trober_sdk/api.dart';

class RemoteOrderRepository extends OrderRepository {
  const RemoteOrderRepository(this._apiRepository);
  final ApiRepository _apiRepository;

  @override
  Future<Order> fetchOrder(String id) async {
    final client = await _apiRepository.apiClient();
    return await client.ordersIdGet(id);
  }

  @override
  Future<List<Order>> fetchOrders() async {
    final client = await _apiRepository.apiClient();
    return await client.ordersGet();
  }

  @override
  Future<Order> createOrder(Order order) async {
    final client = await _apiRepository.apiClient();
    return await client.ordersPost(order: order);
  }

  @override
  Future<Order> updateOrder(String id, Order order) async {
    final client = await _apiRepository.apiClient();
    return await client.ordersIdPut(id, order: order);
  }

  @override
  Future<List<Order>> filterOrders(OrderStatus orderStatus) async {
    final orders = await fetchOrders();
    if (orderStatus == null) {
      return orders;
    }
    return orders.where((e) => e.status == orderStatus).toList();
  }
}
