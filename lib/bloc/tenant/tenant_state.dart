part of 'tenant_bloc.dart';

@immutable
abstract class TenantState {
  const TenantState();
}

class TenantInitial extends TenantState {}

class TenantLoading extends TenantState {}

class TenantLoaded extends TenantState {
  const TenantLoaded(this.tenant);
  final Tenant tenant;
}

class TenantsLoaded extends TenantState {
  const TenantsLoaded(this.tenants, this.tenantType);
  final Iterable<Tenant> tenants;
  final TenantType? tenantType;
}

class TenantFailure extends TenantState {
  const TenantFailure(this.message);
  final String message;
}
