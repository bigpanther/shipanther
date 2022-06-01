import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/customer/customer_repository.dart';
import 'package:trober_sdk/trober_sdk.dart' as api;
import 'package:dio/dio.dart';
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
      } on DioError catch (e) {
        emit(CustomerFailure('Request failed: ${e.message}'));
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
      } on DioError catch (e) {
        emit(CustomerFailure('Request failed: ${e.message}'));
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
      } on DioError catch (e) {
        emit(CustomerFailure('Request failed: ${e.message}'));
      } catch (e) {
        emit(CustomerFailure('Request failed: $e'));
      }
    });
    on<DeleteCustomer>((event, emit) async {
      emit(const CustomerFailure('Customer deletion is not supported'));
    });
  }
}
