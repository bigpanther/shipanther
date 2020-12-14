part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent(this.authType);
  final AuthTypeSelector authType;
}

class AuthTypeOtherRequest extends AuthEvent {
  const AuthTypeOtherRequest(AuthTypeSelector authType) : super(authType);
}

class AuthLogout extends AuthEvent {
  const AuthLogout() : super(AuthTypeSelector.signIn);
}

class AuthRegister extends AuthEvent {
  const AuthRegister(this.name, this.username, this.password)
      : super(AuthTypeSelector.register);
  final String name;
  final String username;
  final String password;
}

class AuthCheck extends AuthEvent {
  const AuthCheck() : super(AuthTypeSelector.signIn);
}

class CheckVerified extends AuthEvent {
  const CheckVerified(this.user) : super(null);
  final User user;
}

class ResendEmail extends AuthEvent {
  const ResendEmail(this.user) : super(null);
  final User user;
}

class ForgotPassword extends AuthEvent {
  const ForgotPassword(this.email) : super(null);
  final String email;
}

class UpdatePassword extends AuthEvent {
  const UpdatePassword(this.oldPassword, this.newPassword) : super(null);
  final String oldPassword;
  final String newPassword;
}

class UpdateName extends AuthEvent {
  const UpdateName(this.name) : super(null);
  final String name;
}

class AuthSignIn extends AuthEvent {
  const AuthSignIn(this.username, this.password)
      : super(AuthTypeSelector.signIn);
  final String username;
  final String password;
}
