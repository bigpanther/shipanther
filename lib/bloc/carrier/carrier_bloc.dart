import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/carrier/carrier_repository.dart';
import 'package:trober_sdk/api.dart';

part 'carrier_event.dart';
part 'carrier_state.dart';

class CarrierBloc extends Bloc<CarrierEvent, CarrierState> {
  final CarrierRepository _carrierRepository;

  CarrierBloc(this._carrierRepository) : super(CarrierInitial());

  @override
  Stream<CarrierState> mapEventToState(
    CarrierEvent event,
  ) async* {
    yield CarrierLoading();
    if (event is GetCarrier) {
      yield CarrierLoaded(await _carrierRepository.fetchCarrier(event.id));
    }
    if (event is GetCarriers) {
      var carriers = await _carrierRepository.filterCarriers(event.carrierType);
      yield CarriersLoaded(carriers, event.carrierType);
    }
    if (event is UpdateCarrier) {
      await _carrierRepository.updateCarrier(event.id, event.carrier);
      var carriers = await _carrierRepository.filterCarriers(null);
      yield CarriersLoaded(carriers, null);
    }
    if (event is CreateCarrier) {
      await _carrierRepository.createCarrier(event.carrier);
      var carriers = await _carrierRepository.filterCarriers(null);
      yield CarriersLoaded(carriers, null);
    }
    if (event is DeleteCarrier) {
      yield CarrierFailure("Carrier deletion is not supported");
    }
  }
}
