import 'package:trober_sdk/trober_sdk.dart';

abstract class ShipmentRepository {
  const ShipmentRepository();
  Future<Shipment?> fetchShipment(String id);
  Future<Shipment?> createShipment(Shipment shipment);
  Future<Shipment?> updateShipment(String id, Shipment shipment);

  Future<Iterable<Shipment>> fetchShipments(
      {int? page = 1,
      ShipmentType? shipmentType,
      ShipmentStatus? shipmentStatus,
      ShipmentSize? shipmentSize,
      String? terminalId,
      String? carrierId,
      String? driverId,
      String? orderId,
      String? serialNumber});
}
