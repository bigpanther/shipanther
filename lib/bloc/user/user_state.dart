part of 'user_bloc.dart';

@immutable
abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {}

class UserLoggedIn extends UserState {
  final User user;

  UserLoggedIn(this.user);
}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;
  const UserLoaded(this.user);
}

class UsersLoaded extends UserState {
  final List<User> users;
  final UserRole userRole;
  const UsersLoaded(this.users, this.userRole);
}

class UserFailure extends UserState {
  final String message;
  const UserFailure(this.message);
}
