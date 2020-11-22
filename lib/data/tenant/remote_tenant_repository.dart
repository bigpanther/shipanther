import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/tenant/tenant_repository.dart';
import 'package:trober_sdk/api.dart';

class RemoteTenantRepository extends TenantRepository {
  final ApiRepository _apiRepository;

  const RemoteTenantRepository(this._apiRepository);
  @override
  Future<Tenant> fetchTenant(String id) async {
    var client = await _apiRepository.apiClient();
    return await client.tenantsIdGet(id);
  }

  @override
  Future<List<Tenant>> fetchTenants() async {
    var client = await _apiRepository.apiClient();
    return await client.tenantsGet();
  }

  @override
  Future<Tenant> createTenant(Tenant tenant) async {
    var client = await _apiRepository.apiClient();
    return await client.tenantsPost(tenant: tenant);
  }

  @override
  Future<Tenant> updateTenant(String id, Tenant tenant) async {
    var client = await _apiRepository.apiClient();
    return await client.tenantsIdPut(id, tenant: tenant);
  }

  @override
  Future<List<Tenant>> filterTenants(TenantType tenantType) async {
    var tenants = await fetchTenants();
    if (tenantType == null) {
      return tenants;
    }
    return tenants.where((e) => e.type == tenantType).toList();
  }
}
