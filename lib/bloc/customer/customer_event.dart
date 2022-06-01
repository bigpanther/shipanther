part of 'customer_bloc.dart';

@immutable
abstract class CustomerEvent {
  const CustomerEvent();
}

class UpdateCustomer extends CustomerEvent {
  const UpdateCustomer(this.id, this.customer);
  final String id;
  final api.Customer customer;
}

class CreateCustomer extends CustomerEvent {
  const CreateCustomer(this.customer);
  final api.Customer customer;
}

class DeleteCustomer extends CustomerEvent {
  const DeleteCustomer(this.id);
  final String id;
}

class GetCustomers extends CustomerEvent {
  const GetCustomers();
}
