import 'package:shipanther/bloc/auth/auth_bloc.dart';

extension AuthTypeSelectorExtension on AuthTypeSelector {
  AuthTypeSelector get other {
    if (this == AuthTypeSelector.register) {
      return AuthTypeSelector.signIn;
    }
    return AuthTypeSelector.register;
  }
}
