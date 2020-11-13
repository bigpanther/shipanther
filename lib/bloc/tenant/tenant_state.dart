part of 'tenant_bloc.dart';

@immutable
abstract class TenantState {
  const TenantState();
}

class TenantInitial extends TenantState {}

class TenantLoading extends TenantState {}

class TenantLoaded extends TenantState {
  final Tenant tenant;
  const TenantLoaded(this.tenant);
}

class TenantsLoaded extends TenantState {
  final List<Tenant> tenants;
  final TenantType tenantType;
  const TenantsLoaded(this.tenants, this.tenantType);
}

class TenantFailure extends TenantState {
  final String message;
  const TenantFailure(this.message);
}
