import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/customer/customer_repository.dart';
import 'package:trober_sdk/trober_sdk.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc(this._customerRepository) : super(CustomerInitial());
  final CustomerRepository _customerRepository;

  @override
  Stream<CustomerState> mapEventToState(
    CustomerEvent event,
  ) async* {
    yield CustomerLoading();
    try {
      if (event is GetCustomers) {
        final customers = await _customerRepository.fetchCustomers();
        yield CustomersLoaded(customers);
      }
      if (event is UpdateCustomer) {
        await _customerRepository.updateCustomer(event.id, event.customer);
        final customers = await _customerRepository.fetchCustomers();
        yield CustomersLoaded(customers);
      }
      if (event is CreateCustomer) {
        await _customerRepository.createCustomer(event.customer);
        final customers = await _customerRepository.fetchCustomers();
        yield CustomersLoaded(customers);
      }
      if (event is DeleteCustomer) {
        yield const CustomerFailure('Customer deletion is not supported');
      }
    } catch (e) {
      yield CustomerFailure('Request failed: $e');
    }
  }
}
