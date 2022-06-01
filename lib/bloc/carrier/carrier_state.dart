part of 'carrier_bloc.dart';

@immutable
abstract class CarrierState {
  const CarrierState();
}

class CarrierInitial extends CarrierState {}

class CarrierLoading extends CarrierState {}

class CarrierLoaded extends CarrierState {
  const CarrierLoaded(this.carrier);
  final api.Carrier carrier;
}

class CarriersLoaded extends CarrierState {
  const CarriersLoaded(this.carriers, this.carrierType);
  final List<api.Carrier> carriers;
  final api.CarrierType? carrierType;
}

class CarrierFailure extends CarrierState {
  const CarrierFailure(this.message);
  final String message;
}
