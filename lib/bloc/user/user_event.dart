part of 'user_bloc.dart';

@immutable
abstract class UserEvent {
  const UserEvent();
}

class UserLogin extends UserEvent {
  const UserLogin(this.deviceToken);
  final Future<String> deviceToken;
}

class GetUser extends UserEvent {
  const GetUser(this.id);
  final String id;
}

class UpdateUser extends UserEvent {
  const UpdateUser(this.id, this.user);
  final String id;
  final User user;
}

class CreateUser extends UserEvent {
  const CreateUser(this.user);
  final User user;
}

class DeleteUser extends UserEvent {
  const DeleteUser(this.id);
  final String id;
}

class GetUsers extends UserEvent {
  const GetUsers({this.userRole});
  final UserRole? userRole;
}
