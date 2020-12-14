part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState(this.authType);
  final AuthTypeSelector authType;
}

class AuthInitial extends AuthState {
  const AuthInitial() : super(AuthTypeSelector.signIn);
}

class AuthLoading extends AuthState {
  const AuthLoading(AuthTypeSelector authType) : super(authType);
}

class AuthFinished extends AuthState {
  const AuthFinished(this.user, AuthTypeSelector authType) : super(authType);
  final User user;
}

class AuthRequested extends AuthState {
  const AuthRequested(AuthTypeSelector authType) : super(authType);
}

class AuthFailure extends AuthState {
  const AuthFailure(this.message, AuthTypeSelector authType) : super(authType);
  final String message;
}

class AuthVerification extends AuthState {
  const AuthVerification(this.user) : super(null);
  final User user;
}

class AuthEmailResent extends AuthVerification {
  const AuthEmailResent(User user) : super(user);
}

enum AuthTypeSelector {
  signIn,
  register,
}
