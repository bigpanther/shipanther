import 'package:enum_to_string/enum_to_string.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';

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
