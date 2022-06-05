import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/extensions/auth_type_selector_extension.dart';
import 'package:trober_sdk/trober_sdk.dart' as api;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepository) : super(const AuthInitial()) {
    on<AuthRegister>((event, emit) async {
      emit(AuthLoading(authType: event.authType));
      try {
        final user = await _authRepository.registerUser(
            event.name, event.email, event.password);
        emit(AuthFinished(user));
      } on EmailNotVerifiedException catch (e) {
        final email = e.emailId;
        if (email == null) {
          emit(AuthInitial(
              authType: event.authType,
              name: event.name,
              email: event.email,
              password: event.password));
        } else {
          emit(AuthVerification(email: email));
        }
      } on UnAuthenticatedException {
        emit(const AuthInitial());
      } on DioError catch (e) {
        emit(AuthFailure('Request failed: ${e.message}',
            authType: event.authType,
            name: event.name,
            email: event.email,
            password: event.password));
      } catch (e) {
        emit(AuthFailure('Request failed: $e',
            authType: event.authType,
            name: event.name,
            email: event.email,
            password: event.password));
      }
    });
    on<AuthSignIn>((event, emit) async {
      emit(AuthLoading(
          authType: event.authType,
          name: '',
          email: event.email,
          password: event.password));
      try {
        final user = await _authRepository.signIn(event.email, event.password);
        emit(AuthFinished(user));
      } on EmailNotVerifiedException catch (e) {
        final email = e.emailId;
        if (email == null) {
          emit(const AuthInitial());
        } else {
          emit(AuthVerification(
            email: email,
          ));
        }
      } on UnAuthenticatedException {
        emit(AuthInitial(
            authType: event.authType,
            name: '',
            email: event.email,
            password: event.password));
      } on DioError catch (e) {
        emit(AuthFailure('Request failed: ${e.message}',
            authType: event.authType,
            email: event.email,
            password: event.password));
      } catch (e) {
        emit(AuthFailure('Request failed: $e',
            authType: event.authType,
            email: event.email,
            password: event.password));
      }
    });
    on<AuthTypeOtherRequest>((event, emit) async {
      emit(AuthLoading(
        authType: event.authType,
      ));
      emit(AuthRequested(authType: event.authType.other));
    });
    on<AuthLogout>((event, emit) async {
      emit(AuthLoading(authType: event.authType));
      try {
        await _authRepository.logout();
        emit(AuthInitial(
          authType: event.authType,
        ));
      } on EmailNotVerifiedException catch (e) {
        final email = e.emailId;
        if (email == null) {
          emit(const AuthInitial());
        } else {
          emit(AuthVerification(email: email));
        }
      } on UnAuthenticatedException {
        emit(const AuthInitial());
      } on DioError catch (e) {
        emit(AuthFailure('Request failed: ${e.message}',
            authType: event.authType));
      } catch (e) {
        emit(AuthFailure('Request failed: $e', authType: event.authType));
      }
    });
    on<AuthCheck>((event, emit) async {
      emit(AuthLoading(authType: event.authType));
      try {
        final user = await _authRepository.logIn();
        emit(AuthFinished(user));
      } on EmailNotVerifiedException catch (e) {
        final email = e.emailId;
        if (email == null) {
          emit(const AuthInitial());
        } else {
          emit(AuthVerification(email: email));
        }
      } on UnAuthenticatedException {
        emit(const AuthInitial());
      } catch (e) {
        emit(AuthFailure('Request failed: $e', authType: event.authType));
      }
    });

    on<CheckVerified>((event, emit) async {
      emit(AuthLoading(authType: event.authType));
      try {
        final user = await _authRepository.verifyEmail();
        emit(AuthFinished(user));
      } on EmailNotVerifiedException catch (e) {
        final email = e.emailId;
        if (email == null) {
          emit(const AuthInitial());
        } else {
          emit(AuthVerification(email: email));
        }
      } on UnAuthenticatedException {
        emit(const AuthInitial());
      } on DioError catch (e) {
        emit(AuthFailure('Request failed: ${e.message}',
            authType: event.authType));
      } catch (e) {
        emit(AuthFailure('Request failed: $e', authType: event.authType));
      }
    });

    on<ForgotPassword>((event, emit) async {
      emit(AuthLoading(authType: event.authType));

      if (event.email == null) {
        emit(const ForgotPasswordRequested());
        return;
      }
      try {
        await _authRepository.forgotPassword(event.email!);
        emit(const AuthInitial());
      } on EmailNotVerifiedException catch (e) {
        final email = e.emailId;
        if (email == null) {
          emit(const AuthInitial());
        } else {
          emit(AuthVerification(email: email));
        }
      } on UnAuthenticatedException {
        emit(const AuthInitial());
      } on DioError catch (e) {
        emit(AuthFailure('Request failed: ${e.message}',
            authType: event.authType));
      } catch (e) {
        emit(AuthFailure('Request failed: $e', authType: event.authType));
      }
    });
    on<ResendEmail>((event, emit) async {
      emit(AuthLoading(authType: event.authType));
      try {
        final emailId = await _authRepository.sendEmailForVerification();
        emit(AuthEmailResent(email: emailId));
      } on EmailNotVerifiedException catch (e) {
        final email = e.emailId;
        if (email == null) {
          emit(const AuthInitial());
        } else {
          emit(AuthVerification(email: email));
        }
      } on UnAuthenticatedException {
        emit(const AuthInitial());
      } on DioError catch (e) {
        emit(AuthFailure('Request failed: ${e.message}',
            authType: event.authType));
      } catch (e) {
        emit(AuthFailure('Request failed: $e', authType: event.authType));
      }
    });
//     on<UpdatePassword>((event, emit) async {
//       emit(AuthLoading(event.authType));
//       try {
//         final user = _authRepository.loggedInUser();
//         // TODO(harsimranmaan): Validate old password here, https://github.com/bigpanther/shipanther/issues/184
//         await user.updatePassword(event.oldPassword, event.newPassword);
//         emit(const AuthInitial());
//       } on EmailNotVerifiedException catch (e) {
//         final email = e.emailId;
//         if (email == null) {
//           emit(const AuthInitial());
//         } else {
//           emit(AuthVerification(email));
//         }
//       } on UnAuthenticatedException {
//         emit(const AuthInitial());
//       } catch (e) {
//         emit(AuthFailure('Request failed: $e', event.authType));
//       }
//     });
  }
  final AuthRepository _authRepository;

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
  }
}
