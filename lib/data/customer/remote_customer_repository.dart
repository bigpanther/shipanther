import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/data/customer/customer_repository.dart';
import 'package:trober_sdk/trober_sdk.dart';

class RemoteCustomerRepository extends CustomerRepository {
  const RemoteCustomerRepository(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<Customer?> fetchCustomer(String id) async {
    final client = await _authRepository.apiClient();
    final resp = await client.customersIdGet(id: id);
    return resp.data;
  }

  @override
  Future<Iterable<Customer>> fetchCustomers(
      {int? page = 1, String? name}) async {
    final client = await _authRepository.apiClient();
    final resp = await client.customersGet(page: page, name: name);
    return resp.data ?? [];
  }

  @override
  Future<Customer?> createCustomer(Customer customer) async {
    final client = await _authRepository.apiClient();
    final resp = await client.customersPost(customer: customer);
    return resp.data;
  }

  @override
  Future<Customer?> updateCustomer(String id, Customer customer) async {
    final client = await _authRepository.apiClient();
    final resp = await client.customersIdPut(id: id, customer: customer);
    return resp.data;
  }
}
