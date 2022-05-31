import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/carrier/carrier_repository.dart';
import 'package:trober_sdk/trober_sdk.dart';

part 'carrier_event.dart';
part 'carrier_state.dart';

class CarrierBloc extends Bloc<CarrierEvent, CarrierState> {
  final CarrierRepository _carrierRepository;
  CarrierBloc(this._carrierRepository) : super(CarrierInitial()) {
    on<GetCarrier>((event, emit) async {
      emit(CarrierLoading());
      try {
        emit(CarrierLoaded(await _carrierRepository.fetchCarrier(event.id)));
      } catch (e) {
        emit(CarrierFailure('Request failed: $e'));
      }
    });

    on<GetCarriers>((event, emit) async {
      try {
        emit(CarrierLoading());

        final carriers = await _carrierRepository.fetchCarriers(
            page: event.page, carrierType: event.carrierType);
        emit(CarriersLoaded(carriers, event.carrierType));
      } catch (e) {
        emit(CarrierFailure('Request failed: $e'));
      }
    });

    on<UpdateCarrier>((event, emit) async {
      try {
        emit(CarrierLoading());

        await _carrierRepository.updateCarrier(event.id, event.carrier);
        final carriers = await _carrierRepository.fetchCarriers();
        emit(CarriersLoaded(carriers, null));
      } catch (e) {
        emit(CarrierFailure('Request failed: $e'));
      }
    });

    on<CreateCarrier>((event, emit) async {
      try {
        emit(CarrierLoading());

        await _carrierRepository.createCarrier(event.carrier);
        final carriers = await _carrierRepository.fetchCarriers();
        emit(CarriersLoaded(carriers, null));
      } catch (e) {
        emit(CarrierFailure('Request failed: $e'));
      }
    });

    on<DeleteCarrier>((event, emit) async {
      emit(const CarrierFailure('Carrier deletion is not supported'));
    });
  }
}
