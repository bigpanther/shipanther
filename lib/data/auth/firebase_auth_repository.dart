import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shipanther/data/auth/auth_repository.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class FireBaseAuthRepository extends AuthRepository {
  FireBaseAuthRepository(this._firebaseMessaging);
  final FirebaseMessaging _firebaseMessaging;

  @override
  Future<User> registerUser(
      String name, String username, String password) async {
    final userCreds = await _auth.createUserWithEmailAndPassword(
      email: username,
      password: password,
    );
    final user = userCreds.user;

    if (user == null) {
      throw AuthenticationException();
    }

    await user.updateProfile(displayName: name);
    await user.sendEmailVerification();
    return user;
  }

  @override
  User loggedInUser() {
    return _auth.currentUser;
  }

  @override
  Future<User> fetchAuthUser(String username, String password) async {
    final userCreds = await _auth.signInWithEmailAndPassword(
      email: username,
      password: password,
    );
    final user = userCreds.user;
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
    final deviceToken = await _firebaseMessaging.getToken();
    return deviceToken;
  }

  @override
  Future<User> refreshUserProfile() async {
    // See https://github.com/FirebaseExtended/flutterfire/issues/717
    await _auth.currentUser.reload();
    return _auth.currentUser;
  }

  @override
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}

class AuthenticationException implements Exception {}
