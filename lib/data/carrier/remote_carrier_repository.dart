import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/data/carrier/carrier_repository.dart';
import 'package:trober_sdk/trober_sdk.dart';

class RemoteCarrierRepository extends CarrierRepository {
  const RemoteCarrierRepository(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<Carrier> fetchCarrier(String id) async {
    final client = await _authRepository.apiClient();
    return (await client.carriersIdGet(
      id: id,
    ))
        .data!;
  }

  @override
  Future<List<Carrier>> fetchCarriers(
      {int? page = 1, CarrierType? carrierType, String? name}) async {
    final client = await _authRepository.apiClient();
    return (await client.carriersGet(
      page: page,
      type: carrierType,
      name: name,
    ))
        .data!
        .toList();
  }

  @override
  Future<Carrier> createCarrier(Carrier carrier) async {
    final client = await _authRepository.apiClient();
    return (await client.carriersPost(carrier: carrier)).data!;
  }

  @override
  Future<Carrier> updateCarrier(String id, Carrier carrier) async {
    final client = await _authRepository.apiClient();
    return (await client.carriersIdPut(id: id, carrier: carrier)).data!;
  }
}
