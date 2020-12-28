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
  Future<List<Order>> fetchOrders(
      {int? page = 1,
      OrderStatus? orderStatus,
      String? customerId,
      String? serialNumber}) async {
    final client = await _apiRepository.apiClient();
    return await client.ordersGet(
        page: page,
        status: orderStatus,
        customerId: customerId,
        serialNumber: serialNumber);
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
}
