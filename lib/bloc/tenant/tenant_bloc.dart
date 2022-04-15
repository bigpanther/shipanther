import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/tenant/tenant_repository.dart';
import 'package:trober_sdk/api.dart';

part 'tenant_event.dart';
part 'tenant_state.dart';

class TenantBloc extends Bloc<TenantEvent, TenantState> {
  TenantBloc(this._tenantRepository) : super(TenantInitial()) {
    on<GetTenant>((event, emit) async {
      emit(TenantLoading());
      emit(TenantLoaded(await _tenantRepository.fetchTenant(event.id)));
    });
    on<GetTenants>((event, emit) async {
      emit(TenantLoading());
      final tenants =
          await _tenantRepository.fetchTenants(tenantType: event.tenantType);
      emit(TenantsLoaded(tenants, event.tenantType));
    });
    on<UpdateTenant>((event, emit) async {
      emit(TenantLoading());
      await _tenantRepository.updateTenant(event.id, event.tenant);
      final tenants = await _tenantRepository.fetchTenants();
      emit(TenantsLoaded(tenants, null));
    });
    on<CreateTenant>((event, emit) async {
      emit(TenantLoading());
      await _tenantRepository.createTenant(event.tenant);
      final tenants = await _tenantRepository.fetchTenants();
      emit(TenantsLoaded(tenants, null));
    });
    on<DeleteTenant>((event, emit) async {
      emit(TenantLoading());
      emit(const TenantFailure('Tenant deletion is not supported'));
    });
    //  catch (e) {
    //  emit(TenantFailure('Request failed: $e'));
  }
  final TenantRepository _tenantRepository;
}
