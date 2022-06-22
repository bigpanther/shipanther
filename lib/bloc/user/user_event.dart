part of 'user_bloc.dart';

@immutable
abstract class UserEvent {
  const UserEvent();
}

class GetUser extends UserEvent {
  const GetUser(this.id);
  final String id;
}

class UpdateUser extends UserEvent {
  const UpdateUser(this.id, this.user);
  final String id;
  final api.User user;
}

class CreateUser extends UserEvent {
  const CreateUser(this.user);
  final api.User user;
}

class DeleteUser extends UserEvent {
  const DeleteUser(this.id);
  final String id;
}

class GetUsers extends UserEvent {
  const GetUsers({this.userRole});
  final api.UserRole? userRole;
}

class SearchUser extends UserEvent {
  const SearchUser(this.name);
  final String name;
}
