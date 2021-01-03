import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/data/customer/customer_repository.dart';
import 'package:trober_sdk/api.dart';

class RemoteCustomerRepository extends CustomerRepository {
  const RemoteCustomerRepository(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<Customer> fetchCustomer(String id) async {
    final client = await _authRepository.apiClient();
    return await client.customersIdGet(id);
  }

  @override
  Future<List<Customer>> fetchCustomers({int? page = 1, String? name}) async {
    final client = await _authRepository.apiClient();
    return await client.customersGet(page: page, name: name);
  }

  @override
  Future<Customer> createCustomer(Customer customer) async {
    final client = await _authRepository.apiClient();
    return await client.customersPost(customer: customer);
  }

  @override
  Future<Customer> updateCustomer(String id, Customer customer) async {
    final client = await _authRepository.apiClient();
    return await client.customersIdPut(id, customer: customer);
  }
}
