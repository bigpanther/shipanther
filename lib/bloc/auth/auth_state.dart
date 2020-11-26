part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  final AuthTypeSelector authType;
  const AuthState(this.authType);
}

class AuthInitial extends AuthState {
  AuthInitial() : super(AuthTypeSelector.signIn);
}

class AuthLoading extends AuthState {
  AuthLoading(AuthTypeSelector authType) : super(authType);
}

class AuthFinished extends AuthState {
  final User user;
  const AuthFinished(this.user, AuthTypeSelector authType) : super(authType);
}

class AuthRequested extends AuthState {
  final AuthTypeSelector authType;
  AuthRequested(this.authType) : super(authType);
}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message, AuthTypeSelector authType) : super(authType);
}

class AuthVerification extends AuthState {
  final User user;
  const AuthVerification(this.user) : super(null);
}

enum AuthTypeSelector {
  signIn,
  register,
}

extension AuthTypeSelectorExtension on AuthTypeSelector {
  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }

  String get otherText {
    if (this == AuthTypeSelector.register) {
      return "Already registered? Sign In";
    }
    return 'Not registered? Register now';
  }

  AuthTypeSelector get other {
    if (this == AuthTypeSelector.register) {
      return AuthTypeSelector.signIn;
    }
    return AuthTypeSelector.register;
  }
}
