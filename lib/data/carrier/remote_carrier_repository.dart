import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/data/carrier/carrier_repository.dart';
import 'package:trober_sdk/trober_sdk.dart';

class RemoteCarrierRepository extends CarrierRepository {
  const RemoteCarrierRepository(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<Carrier?> fetchCarrier(String id) async {
    final client = await _authRepository.apiClient();
    final resp = await client.carriersIdGet(id: id);
    return resp.data;
  }

  @override
  Future<Iterable<Carrier>> fetchCarriers(
      {int? page = 1, CarrierType? carrierType, String? name}) async {
    final client = await _authRepository.apiClient();
    final resp = await client.carriersGet(
      page: page,
      type: carrierType,
      name: name,
    );
    return resp.data ?? [];
  }

  @override
  Future<Carrier?> createCarrier(Carrier carrier) async {
    final client = await _authRepository.apiClient();
    final resp = await client.carriersPost(carrier: carrier);
    return resp.data;
  }

  @override
  Future<Carrier?> updateCarrier(String id, Carrier carrier) async {
    final client = await _authRepository.apiClient();
    final resp = await client.carriersIdPut(id: id, carrier: carrier);
    return resp.data;
  }
}
