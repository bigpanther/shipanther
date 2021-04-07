import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/tenant/tenant_repository.dart';
import 'package:trober_sdk/trober_sdk.dart';

part 'tenant_event.dart';
part 'tenant_state.dart';

class TenantBloc extends Bloc<TenantEvent, TenantState> {
  TenantBloc(this._tenantRepository) : super(TenantInitial());
  final TenantRepository _tenantRepository;

  @override
  Stream<TenantState> mapEventToState(
    TenantEvent event,
  ) async* {
    yield TenantLoading();
    try {
      if (event is GetTenant) {
        final tenant = await _tenantRepository.fetchTenant(event.id);
        if (tenant == null) {
          throw 'tenant not found';
        }
        yield TenantLoaded(tenant);
      }
      if (event is GetTenants) {
        final tenants =
            await _tenantRepository.fetchTenants(tenantType: event.tenantType);
        yield TenantsLoaded(tenants, event.tenantType);
      }
      if (event is UpdateTenant) {
        await _tenantRepository.updateTenant(event.id, event.tenant);
        final tenants = await _tenantRepository.fetchTenants();
        yield TenantsLoaded(tenants, null);
      }
      if (event is CreateTenant) {
        await _tenantRepository.createTenant(event.tenant);
        final tenants = await _tenantRepository.fetchTenants();
        yield TenantsLoaded(tenants, null);
      }
      if (event is DeleteTenant) {
        yield const TenantFailure('Tenant deletion is not supported');
      }
    } catch (e) {
      yield TenantFailure('Request failed: $e');
    }
  }
}
