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

class UserFailure extends UserState {
  final String message;
  const UserFailure(this.message);
}

class UserLoading extends UserState {}
