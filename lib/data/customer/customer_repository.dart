import 'package:trober_sdk/trober_sdk.dart';

abstract class CustomerRepository {
  const CustomerRepository();
  Future<Customer> fetchCustomer(String id);
  Future<Customer> createCustomer(Customer customer);
  Future<Customer> updateCustomer(String id, Customer customer);
  Future<List<Customer>> fetchCustomers({int? page = 1, String? name});
}
