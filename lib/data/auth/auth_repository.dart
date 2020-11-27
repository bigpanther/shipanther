import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  const AuthRepository();
  Future<User> fetchAuthUser(String username, String password);
  Future<User> registerUser(String name, String username, String password);
  Future<User> refreshUserProfile();
  User loggedInUser();
  Future<String> deviceToken();
  Future<void> logout();
}
