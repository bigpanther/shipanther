import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  const AuthRepository();
  Future<User> fetchAuthUser(String username, String password);
  Future<User> registerUser(String username, String password);
  User loggedInUser();
  Future<void> logout();
}
