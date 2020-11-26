import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:trober_sdk/api.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc(this._userRepository) : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    yield UserLoading();
    if (event is UserLogin) {
      try {
        var deviceToken = await event.deviceToken;
        print(deviceToken);
        User u = await _userRepository.registerDeviceToken(deviceToken);
        yield UserLoggedIn(u);
      } catch (e) {
        print(e);
        yield UserFailure("User validation failed: $e");
      }
    }
    if (event is GetUser) {
      yield UserLoaded(await _userRepository.fetchUser(event.id));
    }
    if (event is GetUsers) {
      var users = await _userRepository.filterUsers(event.userRole);
      yield UsersLoaded(users, event.userRole);
    }
    if (event is UpdateUser) {
      await _userRepository.updateUser(event.id, event.user);
      var users = await _userRepository.filterUsers(null);
      yield UsersLoaded(users, null);
    }
    if (event is CreateUser) {
      await _userRepository.createUser(event.user);
      var users = await _userRepository.filterUsers(null);
      yield UsersLoaded(users, null);
    }
    if (event is DeleteUser) {
      yield UserFailure("User deletion is not supported");
    }
  }
}
