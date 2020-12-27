import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/shipment/shipment_repository.dart';
import 'package:trober_sdk/api.dart';

class RemoteShipmentRepository extends ShipmentRepository {
  const RemoteShipmentRepository(this._apiRepository);
  final ApiRepository _apiRepository;

  @override
  Future<Shipment> fetchShipment(String id) async {
    final client = await _apiRepository.apiClient();
    return await client.shipmentsIdGet(id);
  }

  @override
  Future<Shipment> createShipment(Shipment shipment) async {
    final client = await _apiRepository.apiClient();
    return await client.shipmentsPost(shipment: shipment);
  }

  @override
  Future<Shipment> updateShipment(String id, Shipment shipment) async {
    final client = await _apiRepository.apiClient();
    return await client.shipmentsIdPut(id, shipment: shipment);
  }

  @override
  Future<List<Shipment>> fetchShipments() async {
    final client = await _apiRepository.apiClient();
    return client.shipmentsGet();
  }

  @override
  Future<List<Shipment>> filterShipments(
      ShipmentStatus shipmentStatus) async {
    final shipments = await fetchShipments();
    if (shipmentStatus == null) {
      return shipments;
    }
    return shipments.where((e) => e.status == shipmentStatus).toList();
  }
}
