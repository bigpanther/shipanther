import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/data/tenant/tenant_repository.dart';
import 'package:trober_sdk/trober_sdk.dart';

class RemoteTenantRepository extends TenantRepository {
  const RemoteTenantRepository(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<Tenant> fetchTenant(String id) async {
    final client = await _authRepository.apiClient();
    return (await client.tenantsIdGet(id: id)).data!;
  }

  @override
  Future<List<Tenant>> fetchTenants(
      {int? page = 1, TenantType? tenantType, String? name}) async {
    final client = await _authRepository.apiClient();
    return (await client.tenantsGet(page: page, type: tenantType, name: name))
        .data!
        .toList();
  }

  @override
  Future<Tenant> createTenant(Tenant tenant) async {
    final client = await _authRepository.apiClient();
    return (await client.tenantsPost(tenant: tenant)).data!;
  }

  @override
  Future<Tenant> updateTenant(String id, Tenant tenant) async {
    final client = await _authRepository.apiClient();
    return (await client.tenantsIdPut(id: id, tenant: tenant)).data!;
  }
}
