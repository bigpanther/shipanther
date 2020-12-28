import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/tenant/tenant_repository.dart';
import 'package:trober_sdk/api.dart';

class RemoteTenantRepository extends TenantRepository {
  const RemoteTenantRepository(this._apiRepository);
  final ApiRepository _apiRepository;

  @override
  Future<Tenant> fetchTenant(String id) async {
    final client = await _apiRepository.apiClient();
    return await client.tenantsIdGet(id);
  }

  @override
  Future<List<Tenant>> fetchTenants(
      {int? page = 1, TenantType? tenantType, String? name}) async {
    final client = await _apiRepository.apiClient();
    return await client.tenantsGet(page: page, type: tenantType, name: name);
  }

  @override
  Future<Tenant> createTenant(Tenant tenant) async {
    final client = await _apiRepository.apiClient();
    return await client.tenantsPost(tenant: tenant);
  }

  @override
  Future<Tenant> updateTenant(String id, Tenant tenant) async {
    final client = await _apiRepository.apiClient();
    return await client.tenantsIdPut(id, tenant: tenant);
  }
}
