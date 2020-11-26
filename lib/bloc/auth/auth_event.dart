part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  final AuthTypeSelector authType;
  const AuthEvent(this.authType);
}

class AuthTypeOtherRequest extends AuthEvent {
  final AuthTypeSelector authType;
  const AuthTypeOtherRequest(this.authType) : super(authType);
}

class AuthLogout extends AuthEvent {
  const AuthLogout() : super(AuthTypeSelector.signIn);
}

class AuthRegister extends AuthEvent {
  final String name;
  final String username;
  final String password;

  AuthRegister(this.name, this.username, this.password)
      : super(AuthTypeSelector.register);
}

class AuthCheck extends AuthEvent {
  AuthCheck() : super(AuthTypeSelector.signIn);
}

class IsVerified extends AuthEvent {
  final User user;
  IsVerified(this.user) : super(null);
}

class AuthSignIn extends AuthEvent {
  final String username;
  final String password;

  AuthSignIn(this.username, this.password) : super(AuthTypeSelector.signIn);
}
