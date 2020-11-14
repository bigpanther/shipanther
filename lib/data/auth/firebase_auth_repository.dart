import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shipanther/data/auth/auth_repository.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class FireBaseAuthRepository extends AuthRepository {
  @override
  Future<User> registerUser(String username, String password) async {
    var userCreds = await _auth.createUserWithEmailAndPassword(
      email: username,
      password: password,
    );
    User user = userCreds.user;
    if (user == null) {
      throw AuthenticationException();
    }
    return user;
  }

  @override
  User loggedInUser() {
    return _auth.currentUser;
  }

  @override
  Future<User> fetchAuthUser(String username, String password) async {
    var userCreds = await _auth.signInWithEmailAndPassword(
      email: username,
      password: password,
    );
    User user = userCreds.user;
    if (user == null) {
      throw AuthenticationException();
    }
    return user;
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }
}

class AuthenticationException implements Exception {}
