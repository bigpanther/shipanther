part of 'user_bloc.dart';

@immutable
abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {}

class UserNotFound extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  const UserLoaded(this.user);
  final api.User user;
}

class UsersLoaded extends UserState {
  const UsersLoaded(this.users, this.userRole);
  final List<api.User> users;
  final api.UserRole? userRole;
}

class UserFailure extends UserState {
  const UserFailure(this.message);
  final String message;
}
