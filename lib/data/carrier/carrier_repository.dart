import 'package:trober_sdk/api.dart';

abstract class CarrierRepository {
  const CarrierRepository();
  Future<Carrier> fetchCarrier(String id);
  Future<Carrier> createCarrier(Carrier carrier);
  Future<Carrier> updateCarrier(String id, Carrier carrier);
  Future<List<Carrier>> fetchCarriers();
  Future<List<Carrier>> filterCarriers(CarrierType carrierType);
}
