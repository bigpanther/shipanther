import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/dio/shipanther_interceptor.dart';
import 'package:trober_sdk/trober_sdk.dart' as api;

class RemoteAuthRepository extends AuthRepository {
  RemoteAuthRepository(this._auth, this._firebaseMessaging, this._url) {
    _d = api.TroberSdk(
        basePathOverride: _url,
        dio: Dio(BaseOptions(
          baseUrl: _url,
          connectTimeout: 10000,
          receiveTimeout: 5000,
        )),
        interceptors: [
          api.ApiKeyAuthInterceptor(),
          ShipantherInterceptor(api.standardSerializers)
        ]);
  }
  final firebase.FirebaseAuth _auth;
  final String _url;
  late api.TroberSdk _d;
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
    await user.updateDisplayName(name);
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
      await _firebaseMessaging.deleteToken();
      await _auth.signOut();
    } catch (_) {
      _self = null;
      //ignore
    }
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
    _d.setApiKey('ApiKeyAuth', token);
    return ApiWithUserId(_d, authUser.uid);
  }

  @override
  Future<api.User> logIn() async {
    await _firebaseMessaging.setAutoInitEnabled(true);
    var u = _auth.currentUser ?? await _auth.authStateChanges().first;
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
    _self = (await client.selfGet()).data!;
    return _self!;
  }

  Future<void> _registerDeviceToken(api.User user) async {
    if (user.role == api.UserRole.none) {
      return;
    }
    final client = await apiClient();
    final deviceToken = await _firebaseMessaging.getToken();
    if (deviceToken == null) {
      //print('failed to get device token');
      return;
    }
    return (await client.selfDeviceRegisterPost(
            deviceId: api.DeviceId(((b) => b..token = deviceToken))))
        .data;
  }

  Future<void> _deleteDeviceToken() async {
    final client = await apiClient();
    final deviceToken = await _firebaseMessaging.getToken();
    if (deviceToken == null) {
      //print('failed to get device token');
      return;
    }
    return (await client.selfDeviceRemovePost(
            deviceId: api.DeviceId(((b) => b..token = deviceToken))))
        .data;
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
  Future<String> sendEmailForVerification() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw AuthenticationException();
    }
    await user.sendEmailVerification();
    if (user.email == null) {
      throw UnAuthenticatedException();
    }
    return user.email!;
  }
}
