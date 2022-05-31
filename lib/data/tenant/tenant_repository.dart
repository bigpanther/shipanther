import 'package:trober_sdk/trober_sdk.dart';

abstract class TenantRepository {
  const TenantRepository();
  Future<Tenant> fetchTenant(String id);
  Future<Tenant> createTenant(Tenant tenant);
  Future<Tenant> updateTenant(String id, Tenant tenant);
  Future<List<Tenant>> fetchTenants(
      {int? page = 1, TenantType? tenantType, String? name});
}
