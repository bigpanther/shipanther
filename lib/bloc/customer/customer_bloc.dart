import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/customer/customer_repository.dart';
import 'package:trober_sdk/trober_sdk.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepository _customerRepository;
  CustomerBloc(this._customerRepository) : super(CustomerInitial()) {
    on<GetCustomers>((event, emit) async {
      try {
        emit(CustomerLoading());
        final customers = await _customerRepository.fetchCustomers();
        emit(CustomersLoaded(customers));
      } catch (e) {
        emit(CustomerFailure('Request failed: $e'));
      }
    });
    on<UpdateCustomer>((event, emit) async {
      try {
        emit(CustomerLoading());
        await _customerRepository.updateCustomer(event.id, event.customer);
        final customers = await _customerRepository.fetchCustomers();
        emit(CustomersLoaded(customers));
      } catch (e) {
        emit(CustomerFailure('Request failed: $e'));
      }
    });
    on<CreateCustomer>((event, emit) async {
      try {
        emit(CustomerLoading());
        await _customerRepository.createCustomer(event.customer);
        final customers = await _customerRepository.fetchCustomers();
        emit(CustomersLoaded(customers));
      } catch (e) {
        emit(CustomerFailure('Request failed: $e'));
      }
    });
    on<DeleteCustomer>((event, emit) async {
      try {
        emit(CustomerLoading());
      } catch (e) {
        emit(CustomerFailure('Request failed: $e'));
      }
      emit(const CustomerFailure('Customer deletion is not supported'));
    });
  }
}
