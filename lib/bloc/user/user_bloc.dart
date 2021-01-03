import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:trober_sdk/api.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._userRepository) : super(UserInitial());
  final UserRepository _userRepository;

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    yield UserLoading();
    try {
      if (event is GetUser) {
        yield UserLoaded(await _userRepository.fetchUser(event.id));
      }
      if (event is GetUsers) {
        final users =
            await _userRepository.fetchUsers(userRole: event.userRole);
        yield UsersLoaded(users, event.userRole);
      }
      if (event is UpdateUser) {
        await _userRepository.updateUser(event.id, event.user);
        final users = await _userRepository.fetchUsers();
        yield UsersLoaded(users, null);
      }
      if (event is CreateUser) {
        await _userRepository.createUser(event.user);
        final users = await _userRepository.fetchUsers();
        yield UsersLoaded(users, null);
      }
      if (event is DeleteUser) {
        yield const UserFailure('User deletion is not supported');
      }
    } catch (e) {
      yield UserFailure('Request failed: $e');
    }
  }
}
