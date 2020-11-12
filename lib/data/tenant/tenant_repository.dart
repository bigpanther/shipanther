import 'package:trober_sdk/api.dart';

abstract class TenantRepository {
  const TenantRepository();
  Future<Tenant> fetchTenant(String id);
  Future<List<Tenant>> fetchTenants();
}
