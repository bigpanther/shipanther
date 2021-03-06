import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/carrier/carrier_repository.dart';
import 'package:trober_sdk/api.dart';

part 'carrier_event.dart';
part 'carrier_state.dart';

class CarrierBloc extends Bloc<CarrierEvent, CarrierState> {
  CarrierBloc(this._carrierRepository) : super(CarrierInitial());
  final CarrierRepository _carrierRepository;

  @override
  Stream<CarrierState> mapEventToState(
    CarrierEvent event,
  ) async* {
    yield CarrierLoading();
    try {
      if (event is GetCarrier) {
        yield CarrierLoaded(await _carrierRepository.fetchCarrier(event.id));
      }
      if (event is GetCarriers) {
        final carriers = await _carrierRepository.fetchCarriers(
            page: event.page, carrierType: event.carrierType);
        yield CarriersLoaded(carriers, event.carrierType);
      }
      if (event is UpdateCarrier) {
        await _carrierRepository.updateCarrier(event.id, event.carrier);
        final carriers = await _carrierRepository.fetchCarriers();
        yield CarriersLoaded(carriers, null);
      }
      if (event is CreateCarrier) {
        await _carrierRepository.createCarrier(event.carrier);
        final carriers = await _carrierRepository.fetchCarriers();
        yield CarriersLoaded(carriers, null);
      }
      if (event is DeleteCarrier) {
        yield const CarrierFailure('Carrier deletion is not supported');
      }
    } catch (e) {
      yield CarrierFailure('Request failed: $e');
    }
  }
}
