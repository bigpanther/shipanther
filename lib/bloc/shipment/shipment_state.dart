part of 'shipment_bloc.dart';

@immutable
abstract class ShipmentState {
  const ShipmentState();
}

class ShipmentInitial extends ShipmentState {}

class ShipmentLoading extends ShipmentState {}

class ShipmentLoaded extends ShipmentState {
  const ShipmentLoaded(this.shipment, this.downloadURL);
  final Shipment shipment;
  final String? downloadURL;
}

class ShipmentsLoaded extends ShipmentState {
  const ShipmentsLoaded(this.shipments, this.shipmentStatus);
  final List<Shipment> shipments;
  final ShipmentStatus? shipmentStatus;
}

class ShipmentFailure extends ShipmentState {
  const ShipmentFailure(this.message);
  final String message;
}
