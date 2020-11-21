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
  final List<Customer> customers;
  const CustomersLoaded(this.customers);
}

class CustomerFailure extends CustomerState {
  final String message;
  const CustomerFailure(this.message);
}
