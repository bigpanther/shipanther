import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/tenant/tenant_repository.dart';
import 'package:trober_sdk/api.dart';

part 'tenant_event.dart';
part 'tenant_state.dart';

class TenantBloc extends Bloc<TenantEvent, TenantState> {
  final TenantRepository _tenantRepository;

  TenantBloc(this._tenantRepository) : super(TenantInitial());

  @override
  Stream<TenantState> mapEventToState(
    TenantEvent event,
  ) async* {
    yield TenantLoading();
    if (event is GetTenant) {
      yield TenantLoaded(await _tenantRepository.fetchTenant(event.id));
    }
    if (event is GetTenants) {
      var tenants = await _tenantRepository.filterTenants(event.tenantType);
      yield TenantsLoaded(tenants, event.tenantType);
    }
    if (event is DeleteTenant) {
      yield TenantFailure("Tenant deletion is not supported");
    }
  }
}
