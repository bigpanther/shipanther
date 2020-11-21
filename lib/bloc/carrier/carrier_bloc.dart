import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'carrier_event.dart';
part 'carrier_state.dart';

class CarrierBloc extends Bloc<CarrierEvent, CarrierState> {
  CarrierBloc() : super(CarrierInitial());

  @override
  Stream<CarrierState> mapEventToState(
    CarrierEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
