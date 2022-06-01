import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/tenant/tenant_repository.dart';
import 'package:trober_sdk/trober_sdk.dart' as api;
import 'package:dio/dio.dart';

part 'tenant_event.dart';
part 'tenant_state.dart';

class TenantBloc extends Bloc<TenantEvent, TenantState> {
  TenantBloc(this._tenantRepository) : super(TenantInitial()) {
    on<GetTenant>((event, emit) async {
      emit(TenantLoading());
      try {
        emit(TenantLoaded(await _tenantRepository.fetchTenant(event.id)));
      } on DioError catch (e) {
        emit(TenantFailure('Request failed: ${e.message}'));
      } catch (e) {
        emit(TenantFailure('Request failed: $e'));
      }
    });
    on<GetTenants>((event, emit) async {
      emit(TenantLoading());
      try {
        final tenants =
            await _tenantRepository.fetchTenants(tenantType: event.tenantType);
        emit(TenantsLoaded(tenants, event.tenantType));
      } on DioError catch (e) {
        emit(TenantFailure('Request failed: ${e.message}'));
      } catch (e) {
        emit(TenantFailure('Request failed: $e'));
      }
    });
    on<UpdateTenant>((event, emit) async {
      emit(TenantLoading());
      try {
        await _tenantRepository.updateTenant(event.id, event.tenant);
        final tenants = await _tenantRepository.fetchTenants();
        emit(TenantsLoaded(tenants, null));
      } on DioError catch (e) {
        emit(TenantFailure('Request failed: ${e.message}'));
      } catch (e) {
        emit(TenantFailure('Request failed: $e'));
      }
    });
    on<CreateTenant>((event, emit) async {
      emit(TenantLoading());
      try {
        await _tenantRepository.createTenant(event.tenant);
        final tenants = await _tenantRepository.fetchTenants();
        emit(TenantsLoaded(tenants, null));
      } on DioError catch (e) {
        emit(TenantFailure('Request failed: ${e.message}'));
      } catch (e) {
        emit(TenantFailure('Request failed: $e'));
      }
    });
    on<DeleteTenant>((event, emit) async {
      emit(const TenantFailure('Tenant deletion is not supported'));
    });
  }
  final TenantRepository _tenantRepository;
}
