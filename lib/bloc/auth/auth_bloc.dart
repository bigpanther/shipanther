import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:trober_sdk/trober_sdk.dart' as api;
import 'package:meta/meta.dart';
import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/extensions/auth_type_selector_extension.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepository) : super(const AuthInitial());
  final AuthRepository _authRepository;

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield AuthLoading(event.authType);
    try {
      if (event is AuthRegister) {
        final user = await _authRepository.registerUser(
            event.name, event.username, event.password);
        yield AuthFinished(user);
      }
      if (event is AuthSignIn) {
        final user =
            await _authRepository.signIn(event.username, event.password);
        yield AuthFinished(user);
      }
      if (event is AuthTypeOtherRequest) {
        yield AuthRequested(event.authType.other);
      }
      if (event is AuthLogout) {
        await _authRepository.logout();
        yield const AuthInitial();
      }
      if (event is AuthCheck) {
        final user = await _authRepository.logIn();
        yield AuthFinished(user);
      }
      if (event is CheckVerified) {
        final user = await _authRepository.verifyEmail();
        yield AuthFinished(user);
      }
      if (event is ForgotPassword) {
        if (event.email == null) {
          yield const ForgotPasswordRequested();
          return;
        }
        await _authRepository.forgotPassword(event.email!);
        yield const AuthInitial();
      }
      if (event is ResendEmail) {
        final emailId = await _authRepository.sendEmailForVerification();
        if (emailId == null) {
          throw UnAuthenticatedException();
        }
        yield AuthEmailResent(emailId);
      }
      // if (event is UpdatePassword) {
      //   final user = _authRepository.loggedInUser();
      // TODO(harsimranmaan): Validate old password here, https://github.com/bigpanther/shipanther/issues/184
      //   await user.updatePassword(event.oldPassword, event.newPassword);
      //   yield const AuthInitial();
      // }
    } on EmailNotVerifiedException catch (e) {
      final email = e.emailId;
      if (email == null) {
        yield const AuthInitial();
      } else {
        yield AuthVerification(email);
      }
    } on UnAuthenticatedException {
      yield const AuthInitial();
    } catch (e) {
      yield AuthFailure('Request failed: $e', event.authType);
    }
  }
}
