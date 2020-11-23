part of 'user_bloc.dart';

@immutable
abstract class UserEvent {
  const UserEvent();
}

class UserLogin extends UserEvent {
  final Future<String> deviceToken;
  const UserLogin(this.deviceToken);
}
