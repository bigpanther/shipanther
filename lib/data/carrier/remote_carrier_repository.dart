import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/carrier/carrier_repository.dart';
import 'package:trober_sdk/api.dart';

class RemoteCarrierRepository extends CarrierRepository {
  const RemoteCarrierRepository(this._apiRepository);
  final ApiRepository _apiRepository;

  @override
  Future<Carrier> fetchCarrier(String id) async {
    final client = await _apiRepository.apiClient();
    return await client.carriersIdGet(id);
  }

  @override
  Future<List<Carrier>> fetchCarriers() async {
    final client = await _apiRepository.apiClient();
    return await client.carriersGet();
  }

  @override
  Future<Carrier> createCarrier(Carrier carrier) async {
    final client = await _apiRepository.apiClient();
    return await client.carriersPost(carrier: carrier);
  }

  @override
  Future<Carrier> updateCarrier(String id, Carrier carrier) async {
    final client = await _apiRepository.apiClient();
    return await client.carriersIdPut(id, carrier: carrier);
  }

  @override
  Future<List<Carrier>> filterCarriers(CarrierType carrierType) async {
    final carriers = await fetchCarriers();
    if (carrierType == null) {
      return carriers;
    }
    return carriers.where((e) => e.type == carrierType).toList();
  }
}
