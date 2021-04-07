import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:trober_sdk/trober_sdk.dart' as api;

class RemoteAuthRepository extends AuthRepository {
  RemoteAuthRepository(this._auth, this._firebaseMessaging, this._url);
  final firebase.FirebaseAuth _auth;
  final String _url;
  final FirebaseMessaging _firebaseMessaging;
  api.User? _self;

  @override
  Future<api.User> registerUser(
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
    return logIn();
  }

  @override
  Future<api.User> signIn(String username, String password) async {
    final userCreds = await _auth.signInWithEmailAndPassword(
      email: username,
      password: password,
    );
    final user = userCreds.user;
    if (user == null) {
      throw AuthenticationException();
    }
    return logIn();
  }

  @override
  Future<void> logout() async {
    await _firebaseMessaging.setAutoInitEnabled(false);
    try {
      await _deleteDeviceToken();
    } catch (_) {
      //ignore
    }
    await _firebaseMessaging.deleteToken();
    await _auth.signOut();
    _self = null;
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<ApiWithUserId> apiClient() async {
    final authUser = _auth.currentUser;
    if (authUser == null) {
      throw UnAuthenticatedException();
    }
    final token = await authUser.getIdToken(false);
    final authHeader = {'X-TOKEN': token};
    return ApiWithUserId(
        Dio(
          BaseOptions(
            baseUrl: _url,
            //  connectTimeout: 5000,
            //  receiveTimeout: 5000,
            headers: authHeader,
          ),
        ),
        api.serializers,
        authUser.uid);
  }

  @override
  Future<api.User> logIn() async {
    await _firebaseMessaging.setAutoInitEnabled(true);
    final u = _auth.currentUser;
    if (u == null) {
      throw UnAuthenticatedException();
    }
    if (!u.emailVerified) {
      throw EmailNotVerifiedException(u.email);
    }
    final user = await loggedInUser();
    await _registerDeviceToken(user);
    return user;
  }

  @override
  Future<api.User> loggedInUser() async {
    if (_self != null) {
      return _self!;
    }
    final client = await apiClient();
    final resp = await client.selfGet();
    _self = resp.data;
    return _self!;
  }

  Future<void> _registerDeviceToken(api.User user) async {
    if (user.role == api.UserRole.none) {
      return;
    }
    final client = await apiClient();
    final deviceToken = await _firebaseMessaging.getToken();
    final resp = await client.selfDeviceRegisterPost(
        deviceId: (api.DeviceIdBuilder()..token = deviceToken).build());
    return resp.data;
  }

  Future<void> _deleteDeviceToken() async {
    final client = await apiClient();
    final deviceToken = await _firebaseMessaging.getToken();
    final resp = await client.selfDeviceRemovePost(
        deviceId: (api.DeviceIdBuilder()..token = deviceToken).build());
    return resp.data;
  }

  @override
  Future<api.User> verifyEmail() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw AuthenticationException();
    }
    // See https://github.com/FirebaseExtended/flutterfire/issues/717
    await user.reload();
    if (!user.emailVerified) {
      throw EmailNotVerifiedException(user.email);
    }
    return loggedInUser();
  }

  @override
  Future<String?> sendEmailForVerification() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw AuthenticationException();
    }
    await user.sendEmailVerification();
    return user.email;
  }
}
