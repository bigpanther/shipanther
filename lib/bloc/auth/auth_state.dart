part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  final AuthTypeSelector authType;
  const AuthState(this.authType);
}

class AuthInitial extends AuthState {
  const AuthInitial() : super(AuthTypeSelector.signIn);
}

class AuthLoading extends AuthState {
  const AuthLoading(AuthTypeSelector authType) : super(authType);
}

class AuthFinished extends AuthState {
  final User user;
  const AuthFinished(this.user, AuthTypeSelector authType) : super(authType);
}

class AuthRequested extends AuthState {
  final AuthTypeSelector authType;
  const AuthRequested(this.authType) : super(authType);
}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message, AuthTypeSelector authType) : super(authType);
}

class AuthVerification extends AuthState {
  final User user;
  const AuthVerification(this.user) : super(null);
}

class AuthEmailResent extends AuthVerification {
  final User user;
  const AuthEmailResent(this.user) : super(null);
}

enum AuthTypeSelector {
  signIn,
  register,
}
