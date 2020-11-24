import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield AuthLoading(event.authType);
    if (event is AuthRegister) {
      try {
        final user = await _authRepository.registerUser(
            event.name, event.username, event.password);
        yield AuthFinished(user, event.authType);
      } catch (e) {
        yield AuthFailure("Registration failed: $e", event.authType);
      }
    }
    if (event is AuthSignIn) {
      try {
        final user =
            await _authRepository.fetchAuthUser(event.username, event.password);
        print(user);
        yield AuthFinished(user, event.authType);
      } catch (e) {
        yield AuthFailure("Authentication failed: $e", event.authType);
      }
    }
    if (event is AuthTypeOtherRequest) {
      yield AuthRequested(event.authType.other);
    }
    if (event is AuthLogout) {
      await _authRepository.logout();
      yield AuthInitial();
    }
    if (event is AuthCheck) {
      var user = _authRepository.loggedInUser();
      if (user != null) {
        yield AuthFinished(user, AuthTypeSelector.signIn);
      } else {
        yield AuthInitial();
      }
    }
  }
}
