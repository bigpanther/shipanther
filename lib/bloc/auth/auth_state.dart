part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState({this.authType = AuthTypeSelector.signIn});
  final AuthTypeSelector authType;
}

class AuthInitial extends AuthState {
  const AuthInitial() : super();
}

class ForgotPasswordRequested extends AuthState {
  const ForgotPasswordRequested() : super();
}

class AuthLoading extends AuthState {
  const AuthLoading(AuthTypeSelector authType) : super(authType: authType);
}

class AuthFinished extends AuthState {
  const AuthFinished(this.user) : super();
  final api.User user;
}

class AuthRequested extends AuthState {
  const AuthRequested(AuthTypeSelector authType) : super(authType: authType);
}

class AuthFailure extends AuthState {
  const AuthFailure(this.message, AuthTypeSelector authType)
      : super(authType: authType);
  final String message;
}

class AuthVerification extends AuthState {
  const AuthVerification(this.emailId) : super();
  final String emailId;
}

class AuthEmailResent extends AuthVerification {
  const AuthEmailResent(String emailId) : super(emailId);
}

enum AuthTypeSelector {
  signIn,
  register,
}
