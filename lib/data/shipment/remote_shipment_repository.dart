import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/data/shipment/shipment_repository.dart';
import 'package:trober_sdk/trober_sdk.dart';

class RemoteShipmentRepository extends ShipmentRepository {
  const RemoteShipmentRepository(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<Shipment> fetchShipment(String id) async {
    final client = await _authRepository.apiClient();
    return (await client.shipmentsIdGet(id: id)).data!;
  }

  @override
  Future<Shipment> createShipment(Shipment shipment) async {
    final client = await _authRepository.apiClient();
    return (await client.shipmentsPost(shipment: shipment)).data!;
  }

  @override
  Future<Shipment> updateShipment(String id, Shipment shipment) async {
    final client = await _authRepository.apiClient();
    return (await client.shipmentsIdPut(id: id, shipment: shipment)).data!;
  }

  @override
  Future<List<Shipment>> fetchShipments(
      {int? page = 1,
      ShipmentType? shipmentType,
      ShipmentStatus? shipmentStatus,
      ShipmentSize? shipmentSize,
      String? terminalId,
      String? carrierId,
      String? driverId,
      String? orderId,
      String? serialNumber}) async {
    final client = await _authRepository.apiClient();
    return (await client.shipmentsGet(
            page: page,
            type: shipmentType,
            size: shipmentSize,
            status: shipmentStatus,
            driverId: driverId,
            orderId: orderId,
            serialNumber: serialNumber,
            carrierId: carrierId))
        .data!
        .toList();
  }
}
