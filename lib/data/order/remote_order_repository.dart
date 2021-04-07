import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/data/order/order_repository.dart';
import 'package:trober_sdk/trober_sdk.dart';

class RemoteOrderRepository extends OrderRepository {
  const RemoteOrderRepository(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<Order?> fetchOrder(String id) async {
    final client = await _authRepository.apiClient();
    final resp = await client.ordersIdGet(id: id);
    return resp.data;
  }

  @override
  Future<Iterable<Order>> fetchOrders(
      {int? page = 1,
      OrderStatus? orderStatus,
      String? customerId,
      String? serialNumber}) async {
    final client = await _authRepository.apiClient();
    final resp = await client.ordersGet(
        page: page,
        status: orderStatus,
        customerId: customerId,
        serialNumber: serialNumber);
    return resp.data ?? [];
  }

  @override
  Future<Order?> createOrder(Order order) async {
    final client = await _authRepository.apiClient();
    final resp = await client.ordersPost(order: order);
    return resp.data;
  }

  @override
  Future<Order?> updateOrder(String id, Order order) async {
    final client = await _authRepository.apiClient();
    final resp = await client.ordersIdPut(id: id, order: order);
    return resp.data;
  }
}
