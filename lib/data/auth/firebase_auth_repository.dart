import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shipanther/data/auth/auth_repository.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class FireBaseAuthRepository extends AuthRepository {
  final FirebaseMessaging _firebaseMessaging;
  FireBaseAuthRepository(this._firebaseMessaging);

  @override
  Future<User> registerUser(
      String name, String username, String password) async {
    var userCreds = await _auth.createUserWithEmailAndPassword(
      email: username,
      password: password,
    );
    User user = userCreds.user;

    if (user == null) {
      throw AuthenticationException();
    }
    user.updateProfile(displayName: name);
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
    await _firebaseMessaging.setAutoInitEnabled(true);
    return user;
  }

  @override
  Future<void> logout() async {
    await _firebaseMessaging.setAutoInitEnabled(false);
    await _firebaseMessaging.deleteInstanceID();
    await _auth.signOut();
  }

  @override
  Future<String> deviceToken() async {
    var deviceToken = await _firebaseMessaging.getToken();
    return deviceToken;
  }
}

class AuthenticationException implements Exception {}
