import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/data/order/order_repository.dart';
import 'package:trober_sdk/api.dart';

class RemoteOrderRepository extends OrderRepository {
  const RemoteOrderRepository(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<Order> fetchOrder(String id) async {
    final client = await _authRepository.apiClient();
    return await client.ordersIdGet(id);
  }

  @override
  Future<List<Order>> fetchOrders(
      {int? page = 1,
      OrderStatus? orderStatus,
      String? customerId,
      String? serialNumber}) async {
    final client = await _authRepository.apiClient();
    return await client.ordersGet(
        page: page,
        status: orderStatus,
        customerId: customerId,
        serialNumber: serialNumber);
  }

  @override
  Future<Order> createOrder(Order order) async {
    final client = await _authRepository.apiClient();
    return await client.ordersPost(order: order);
  }

  @override
  Future<Order> updateOrder(String id, Order order) async {
    final client = await _authRepository.apiClient();
    return await client.ordersIdPut(id, order: order);
  }
}
