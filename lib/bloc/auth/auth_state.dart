part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState(
      {this.authType = AuthTypeSelector.signIn,
      this.name = '',
      this.email = '',
      this.password = ''});
  final AuthTypeSelector authType;
  final String name;
  final String email;
  final String password;
}

class AuthInitial extends AuthState {
  const AuthInitial({super.authType, super.name, super.email, super.password});
}

class ForgotPasswordRequested extends AuthState {
  const ForgotPasswordRequested({
    super.email,
  });
}

class AuthLoading extends AuthState {
  const AuthLoading({super.authType, super.name, super.email, super.password});
}

class AuthFinished extends AuthState {
  const AuthFinished(this.user) : super();
  final api.User user;
}

class AuthRequested extends AuthState {
  const AuthRequested(
      {super.authType, super.name, super.email, super.password});
}

class AuthFailure extends AuthState {
  const AuthFailure(this.message,
      {super.authType, super.name, super.email, super.password});
  final String message;
}

class AuthVerification extends AuthState {
  const AuthVerification({
    required super.email,
  });
}

class AuthEmailResent extends AuthVerification {
  const AuthEmailResent({
    required super.email,
  });
}

enum AuthTypeSelector {
  signIn,
  register,
}
