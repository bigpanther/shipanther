part of 'customer_bloc.dart';

@immutable
abstract class CustomerState {
  const CustomerState();
}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

// class CustomerLoaded extends CustomerState {
//   final Customer customer;
//   const CustomerLoaded(this.customer);
// }

class CustomersLoaded extends CustomerState {
  const CustomersLoaded(this.customers);
  final List<Customer> customers;
}

class CustomerFailure extends CustomerState {
  const CustomerFailure(this.message);
  final String message;
}
