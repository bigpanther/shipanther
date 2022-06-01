part of 'tenant_bloc.dart';

@immutable
abstract class TenantEvent {
  const TenantEvent();
}

class GetTenant extends TenantEvent {
  const GetTenant(this.id);
  final String id;
}

class UpdateTenant extends TenantEvent {
  const UpdateTenant(this.id, this.tenant);
  final String id;
  final api.Tenant tenant;
}

class CreateTenant extends TenantEvent {
  const CreateTenant(this.tenant);
  final api.Tenant tenant;
}

class DeleteTenant extends TenantEvent {
  const DeleteTenant(this.id);
  final String id;
}

class GetTenants extends TenantEvent {
  const GetTenants({this.tenantType});
  final api.TenantType? tenantType;
}
