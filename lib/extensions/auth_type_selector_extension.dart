import 'package:enum_to_string/enum_to_string.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';

extension AuthTypeSelectorExtension on AuthTypeSelector {
  String get text {
    return EnumToString.convertToString(this, camelCase: true);
  }

  AuthTypeSelector get other {
    if (this == AuthTypeSelector.register) {
      return AuthTypeSelector.signIn;
    }
    return AuthTypeSelector.register;
  }
}
