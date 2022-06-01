part of 'carrier_bloc.dart';

@immutable
abstract class CarrierEvent {
  const CarrierEvent();
}

class GetCarrier extends CarrierEvent {
  const GetCarrier(this.id);
  final String id;
}

class UpdateCarrier extends CarrierEvent {
  const UpdateCarrier(this.id, this.carrier);
  final String id;
  final api.Carrier carrier;
}

class CreateCarrier extends CarrierEvent {
  const CreateCarrier(this.carrier);
  final api.Carrier carrier;
}

class DeleteCarrier extends CarrierEvent {
  const DeleteCarrier(this.id);
  final String id;
}

class GetCarriers extends CarrierEvent {
  const GetCarriers({this.page = 1, this.carrierType});
  final api.CarrierType? carrierType;
  final int page;
}
