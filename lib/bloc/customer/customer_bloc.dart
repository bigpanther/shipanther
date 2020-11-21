import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/customer/customer_repository.dart';
import 'package:trober_sdk/api.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepository _customerRepository;
  CustomerBloc(this._customerRepository) : super(CustomerInitial());

  @override
  Stream<CustomerState> mapEventToState(
    CustomerEvent event,
  ) async* {
    yield CustomerLoading();
    // if (event is GetCustomer) {
    //   yield CustomerLoaded(await _customerRepository.fetchCustomer(event.id));
    // }
    if (event is GetCustomers) {
      var customers = await _customerRepository.fetchCustomers();
      yield CustomersLoaded(customers);
    }
    if (event is UpdateCustomer) {
      await _customerRepository.updateCustomer(event.id, event.customer);
      var customers = await _customerRepository.fetchCustomers();
      yield CustomersLoaded(customers);
    }
    if (event is CreateCustomer) {
      await _customerRepository.createCustomer(event.customer);
      var customers = await _customerRepository.fetchCustomers();
      yield CustomersLoaded(customers);
    }
    if (event is DeleteCustomer) {
      yield CustomerFailure("Customer deletion is not supported");
    }
  }
}
