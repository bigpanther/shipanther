import 'package:trober_sdk/api.dart';

abstract class TenantRepository {
  const TenantRepository();
  Future<Tenant> fetchTenant(String id);
  Future<Tenant> createTenant(Tenant tenant);
  Future<Tenant> updateTenant(String id, Tenant tenant);
  Future<List<Tenant>> fetchTenants();
}
