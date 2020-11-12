import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shipanther/data/auth/auth_repository.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class FireBaseAuthRepository extends AuthRepository {
  User _loggedInUser;
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
    _loggedInUser = user;
    return user;
  }

  @override
  User loggedInUser() {
    return _loggedInUser;
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
    _loggedInUser = user;
    return user;
  }
}

class AuthenticationException implements Exception {}
