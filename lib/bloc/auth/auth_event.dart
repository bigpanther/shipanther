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

class CheckVerified extends AuthEvent {
  final User user;
  const CheckVerified(this.user) : super(null);
}

class ResendEmail extends AuthEvent {
  final User user;
  const ResendEmail(this.user) : super(null);
}

class ForgotPassword extends AuthEvent {
  final String email;
  const ForgotPassword(this.email) : super(null);
}

class UpdatePassword extends AuthEvent {
  final String oldPassword;
  final String newPassword;
  const UpdatePassword(this.oldPassword, this.newPassword) : super(null);
}

class UpdateName extends AuthEvent {
  final String name;
  const UpdateName(this.name) : super(null);
}

class AuthSignIn extends AuthEvent {
  final String username;
  final String password;

  AuthSignIn(this.username, this.password) : super(AuthTypeSelector.signIn);
}
