part of 'tenant_bloc.dart';

@immutable
abstract class TenantEvent {
  const TenantEvent();
}

class GetTenant extends TenantEvent {
  final String id;
  const GetTenant(this.id);
}

class UpdateTenant extends TenantEvent {
  final String id;
  final Tenant tenant;
  const UpdateTenant(this.id, this.tenant);
}

class CreateTenant extends TenantEvent {
  final Tenant tenant;
  const CreateTenant(this.tenant);
}

class DeleteTenant extends TenantEvent {
  final String id;
  const DeleteTenant(this.id);
}

class GetTenants extends TenantEvent {
  final TenantType tenantType;
  const GetTenants(this.tenantType);
}
