import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:trober_sdk/trober_sdk.dart' as api;
import 'package:dio/dio.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc(this._userRepository) : super(UserInitial()) {
    on<GetUser>((event, emit) async {
      emit(UserLoading());
      try {
        emit(UserLoaded(await _userRepository.fetchUser(event.id)));
      } on DioError catch (e) {
        emit(UserFailure('Request failed: ${e.message}'));
      } catch (e) {
        emit(UserFailure('Request failed: $e'));
      }
    });
    on<GetUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final users =
            await _userRepository.fetchUsers(userRole: event.userRole);
        emit(UsersLoaded(users, event.userRole));
      } on DioError catch (e) {
        emit(UserFailure('Request failed: ${e.message}'));
      } catch (e) {
        emit(UserFailure('Request failed: $e'));
      }
    });
    on<UpdateUser>((event, emit) async {
      emit(UserLoading());
      try {
        await _userRepository.updateUser(event.id, event.user);
        final users = await _userRepository.fetchUsers();
        emit(UsersLoaded(users, null));
      } on DioError catch (e) {
        emit(UserFailure('Request failed: ${e.message}'));
      } catch (e) {
        emit(UserFailure('Request failed: $e'));
      }
    });
    on<CreateUser>((event, emit) async {
      emit(UserLoading());
      try {
        await _userRepository.createUser(event.user);
        final users = await _userRepository.fetchUsers();
        emit(UsersLoaded(users, null));
      } on DioError catch (e) {
        emit(UserFailure('Request failed: ${e.message}'));
      } catch (e) {
        emit(UserFailure('Request failed: $e'));
      }
    });
    on<DeleteUser>((event, emit) async {
      emit(const UserFailure('User deletion is not supported'));
    });
  }
}
