import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/extensions/auth_type_selector_extension.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepository) : super(const AuthInitial());
  final AuthRepository _authRepository;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield AuthLoading(event.authType);
    try {
      if (event is AuthRegister) {
        final user = await _authRepository.registerUser(
            event.name, event.username, event.password);
        if (user.emailVerified) {
          yield AuthFinished(user, event.authType);
        } else {
          yield AuthVerification(user);
        }
      }
      if (event is AuthSignIn) {
        final user =
            await _authRepository.fetchAuthUser(event.username, event.password);
        if (user.emailVerified) {
          yield AuthFinished(user, event.authType);
        } else {
          yield AuthVerification(user);
        }
      }
      if (event is AuthTypeOtherRequest) {
        yield AuthRequested(event.authType.other);
      }
      if (event is AuthLogout) {
        await _authRepository.logout();
        yield const AuthInitial();
      }
      if (event is AuthCheck) {
        final user = _authRepository.loggedInUser();
        if (user != null) {
          if (user.emailVerified) {
            yield AuthFinished(user, event.authType);
          } else {
            yield AuthVerification(user);
          }
        } else {
          yield const AuthInitial();
        }
      }
      if (event is CheckVerified) {
        final user = await _authRepository.refreshUserProfile();
        if (user.emailVerified) {
          yield AuthFinished(user, AuthTypeSelector.signIn);
        } else {
          yield AuthVerification(user);
        }
      }
      if (event is ForgotPassword) {
        await _authRepository.resetPassword(event.email);
        yield const AuthInitial();
      }
      if (event is ResendEmail) {
        await event.user.sendEmailVerification();
        yield AuthEmailResent(event.user);
      }
      if (event is UpdatePassword) {
        final user = _authRepository.loggedInUser();
        // TODO(harsimranmaan): Validate old password here, https://github.com/bigpanther/shipanther/issues/184
        await user.updatePassword(event.newPassword);

        yield const AuthInitial();
      }
      if (event is UpdateName) {
        final user = _authRepository.loggedInUser();
        await user.updateProfile(displayName: event.name);
        yield const AuthInitial();
      }
    } catch (e) {
      yield AuthFailure('Request failed: $e', event.authType);
    }
  }
}
