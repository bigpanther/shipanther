import 'package:trober_sdk/api.dart';

abstract class CustomerRepository {
  const CustomerRepository();
  Future<Customer> fetchCustomer(String id);
  Future<Customer> createCustomer(Customer customer);
  Future<Customer> updateCustomer(String id, Customer customer);
  Future<List<Customer>> fetchCustomers();
}
