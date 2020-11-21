part of 'customer_bloc.dart';

@immutable
abstract class CustomerEvent {
  const CustomerEvent();
}

class UpdateCustomer extends CustomerEvent {
  final String id;
  final Customer customer;
  const UpdateCustomer(this.id, this.customer);
}

class CreateCustomer extends CustomerEvent {
  final Customer customer;
  const CreateCustomer(this.customer);
}

class DeleteCustomer extends CustomerEvent {
  final String id;
  const DeleteCustomer(this.id);
}

class GetCustomers extends CustomerEvent {
  const GetCustomers();
}
