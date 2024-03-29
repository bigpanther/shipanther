part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent({this.authType = AuthTypeSelector.signIn});
  final AuthTypeSelector authType;
}

class AuthTypeOtherRequest extends AuthEvent {
  const AuthTypeOtherRequest(AuthTypeSelector authType)
      : super(authType: authType);
}

class AuthLogout extends AuthEvent {
  const AuthLogout() : super();
}

class AuthRegister extends AuthEvent {
  const AuthRegister(this.name, this.email, this.password)
      : super(authType: AuthTypeSelector.register);
  final String name;
  final String email;
  final String password;
}

class AuthCheck extends AuthEvent {
  const AuthCheck() : super();
}

class CheckVerified extends AuthEvent {
  const CheckVerified() : super();
}

class ResendEmail extends AuthEvent {
  const ResendEmail() : super();
}

class ForgotPassword extends AuthEvent {
  const ForgotPassword({this.email}) : super();
  final String? email;
}

// class UpdatePassword extends AuthEvent {
//   const UpdatePassword(this.oldPassword, this.newPassword) : super();
//   final String oldPassword;
//   final String newPassword;
// }

class AuthSignIn extends AuthEvent {
  const AuthSignIn(this.email, this.password) : super();
  final String email;
  final String password;
}
