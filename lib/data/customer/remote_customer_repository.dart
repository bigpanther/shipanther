import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/customer/customer_repository.dart';
import 'package:trober_sdk/api.dart';

class RemoteCustomerRepository extends CustomerRepository {
  const RemoteCustomerRepository(this._apiRepository);
  final ApiRepository _apiRepository;

  @override
  Future<Customer> fetchCustomer(String id) async {
    final client = await _apiRepository.apiClient();
    return await client.customersIdGet(id);
  }

  @override
  Future<List<Customer>> fetchCustomers() async {
    final client = await _apiRepository.apiClient();
    return await client.customersGet();
  }

  @override
  Future<Customer> createCustomer(Customer customer) async {
    final client = await _apiRepository.apiClient();
    return await client.customersPost(customer: customer);
  }

  @override
  Future<Customer> updateCustomer(String id, Customer customer) async {
    final client = await _apiRepository.apiClient();
    return await client.customersIdPut(id, customer: customer);
  }
}
