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
        User u = await _userRepository.self();
        yield UserLoggedIn(u);
      } catch (e) {
        print(e);
        yield UserFailure("User validation failed: $e");
      }
    }
  }
}
