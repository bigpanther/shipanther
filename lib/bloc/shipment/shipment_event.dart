part of 'shipment_bloc.dart';

@immutable
abstract class ShipmentEvent {
  const ShipmentEvent();
}

class GetShipment extends ShipmentEvent {
  const GetShipment(this.id);
  final String id;
}

class UpdateShipment extends ShipmentEvent {
  const UpdateShipment(this.id, this.shipment);
  final String id;
  final Shipment shipment;
}

class CreateShipment extends ShipmentEvent {
  const CreateShipment(this.shipment);
  final Shipment shipment;
}

class DeleteShipment extends ShipmentEvent {
  const DeleteShipment(this.id);
  final String id;
}

class GetShipments extends ShipmentEvent {
  const GetShipments(this.shipmentStatus);
  final ShipmentStatus shipmentStatus;
}
