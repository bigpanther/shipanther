part of 'user_bloc.dart';

@immutable
abstract class UserEvent {
  const UserEvent();
}

class UserLogin extends UserEvent {
  final Future<String> deviceToken;
  const UserLogin(this.deviceToken);
}

class GetUser extends UserEvent {
  final String id;
  const GetUser(this.id);
}

class UpdateUser extends UserEvent {
  final String id;
  final User user;
  const UpdateUser(this.id, this.user);
}

class CreateUser extends UserEvent {
  final User user;
  const CreateUser(this.user);
}

class DeleteUser extends UserEvent {
  final String id;
  const DeleteUser(this.id);
}

class GetUsers extends UserEvent {
  final UserRole userRole;
  const GetUsers(this.userRole);
}
