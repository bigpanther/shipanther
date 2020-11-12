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

class TenantError extends TenantState {
  final String message;
  const TenantError(this.message);
}
