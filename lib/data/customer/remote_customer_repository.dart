import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/data/customer/customer_repository.dart';
import 'package:trober_sdk/trober_sdk.dart';

class RemoteCustomerRepository extends CustomerRepository {
  const RemoteCustomerRepository(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<Customer> fetchCustomer(String id) async {
    final client = await _authRepository.apiClient();
    return (await client.customersIdGet(id: id)).data!;
  }

  @override
  Future<List<Customer>> fetchCustomers({int? page = 1, String? name}) async {
    final client = await _authRepository.apiClient();
    return (await client.customersGet(page: page, name: name)).data!.toList();
  }

  @override
  Future<Customer> createCustomer(Customer customer) async {
    final client = await _authRepository.apiClient();
    return (await client.customersPost(customer: customer)).data!;
  }

  @override
  Future<Customer> updateCustomer(String id, Customer customer) async {
    final client = await _authRepository.apiClient();
    return (await client.customersIdPut(id: id, customer: customer)).data!;
  }
}
