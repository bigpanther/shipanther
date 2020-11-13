part of 'tenant_bloc.dart';

@immutable
abstract class TenantEvent {
  const TenantEvent();
}

class GetTenant extends TenantEvent {
  final String id;
  const GetTenant(this.id);
}

class DeleteTenant extends TenantEvent {
  final String id;
  const DeleteTenant(this.id);
}

class GetTenants extends TenantEvent {
  final TenantType tenantType;
  const GetTenants(this.tenantType);
}
