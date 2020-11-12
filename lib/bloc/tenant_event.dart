part of 'tenant_bloc.dart';

@immutable
abstract class TenantEvent {
  const TenantEvent();
}

class GetTenant extends TenantEvent {
  final String id;
  const GetTenant(this.id);
}
