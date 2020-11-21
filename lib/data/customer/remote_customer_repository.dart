import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/customer/customer_repository.dart';
import 'package:trober_sdk/api.dart';

class RemoteCustomerRepository extends CustomerRepository {
  final ApiRepository _apiRepository;

  const RemoteCustomerRepository(this._apiRepository);
  @override
  Future<Customer> fetchCustomer(String id) async {
    var client = await _apiRepository.apiClient();
    return await client.customersIdGet(id);
  }

  @override
  Future<List<Customer>> fetchCustomers() async {
    var client = await _apiRepository.apiClient();
    return await client.customersGet();
  }

  @override
  Future<Customer> createCustomer(Customer customer) async {
    var client = await _apiRepository.apiClient();
    return await client.customersPost(customer: customer);
  }

  @override
  Future<Customer> updateCustomer(String id, Customer customer) async {
    var client = await _apiRepository.apiClient();
    return await client.customersIdPatch(id, customer: customer);
  }
}
