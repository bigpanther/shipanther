import 'package:trober_sdk/trober_sdk.dart';

abstract class CarrierRepository {
  const CarrierRepository();
  Future<Carrier> fetchCarrier(String id);
  Future<Carrier> createCarrier(Carrier carrier);
  Future<Carrier> updateCarrier(String id, Carrier carrier);
  Future<List<Carrier>> fetchCarriers(
      {int? page = 1, CarrierType? carrierType, String? name});
}
