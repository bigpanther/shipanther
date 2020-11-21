import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(CustomerInitial());

  @override
  Stream<CustomerState> mapEventToState(
    CustomerEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
