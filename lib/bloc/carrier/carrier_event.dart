part of 'carrier_bloc.dart';

@immutable
abstract class CarrierEvent {
  const CarrierEvent();
}

class GetCarrier extends CarrierEvent {
  final String id;
  const GetCarrier(this.id);
}

class UpdateCarrier extends CarrierEvent {
  final String id;
  final Carrier carrier;
  const UpdateCarrier(this.id, this.carrier);
}

class CreateCarrier extends CarrierEvent {
  final Carrier carrier;
  const CreateCarrier(this.carrier);
}

class DeleteCarrier extends CarrierEvent {
  final String id;
  const DeleteCarrier(this.id);
}

class GetCarriers extends CarrierEvent {
  final CarrierType carrierType;
  const GetCarriers(this.carrierType);
}
