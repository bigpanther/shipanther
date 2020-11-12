import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/data/tenant/tenant_repository.dart';
import 'package:trober_sdk/api.dart';

class RemoteTenantRepository extends TenantRepository {
  final ApiRepository _apiRepository;

  const RemoteTenantRepository(this._apiRepository);
  @override
  Future<Tenant> fetchTenant(String id) {
    // TODO: implement fetchTenant
    throw UnimplementedError();
  }

  @override
  Future<List<Tenant>> fetchTenants() {
    // TODO: implement fetchTenants
    throw UnimplementedError();
  }
}
