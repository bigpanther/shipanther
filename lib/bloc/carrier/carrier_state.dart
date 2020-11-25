part of 'carrier_bloc.dart';

@immutable
abstract class CarrierState {
  const CarrierState();
}

class CarrierInitial extends CarrierState {}

class CarrierLoading extends CarrierState {}

class CarrierLoaded extends CarrierState {
  final Carrier carrier;
  const CarrierLoaded(this.carrier);
}

class CarriersLoaded extends CarrierState {
  final List<Carrier> carriers;
  final CarrierType carrierType;
  const CarriersLoaded(this.carriers, this.carrierType);
}

class CarrierFailure extends CarrierState {
  final String message;
  const CarrierFailure(this.message);
}
