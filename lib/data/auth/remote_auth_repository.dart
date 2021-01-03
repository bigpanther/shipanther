import 'dart:async';
import 'package:openapi_dart_common/openapi.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:trober_sdk/api.dart' as api;

class RemoteAuthRepository extends AuthRepository {
  RemoteAuthRepository(this._auth, this._firebaseMessaging, this._url) {
    _d = api.DefaultApi(ApiClient(basePath: _url));
  }
  final firebase.FirebaseAuth _auth;
  final String _url;
  late api.DefaultApi _d;
  final FirebaseMessaging _firebaseMessaging;

  @override
  Future<api.User> registerUser(
      String name, String username, String password) async {
    final userCreds = await _auth.createUserWithEmailAndPassword(
      email: username,
      password: password,
    );
    final user = userCreds.user;
    //ignore:unnecessary_null_comparison
    if (user == null) {
      throw AuthenticationException();
    }
    await user.updateProfile(displayName: name);
    await user.sendEmailVerification();
    if (!user.emailVerified) {
      throw EmailNotVerified(user);
    }
    return loggedInUser();
  }

  @override
  Future<api.User> signIn(String username, String password) async {
    final userCreds = await _auth.signInWithEmailAndPassword(
      email: username,
      password: password,
    );
    final user = userCreds.user;
    //ignore:unnecessary_null_comparison
    if (user == null) {
      throw AuthenticationException();
    }
    await _firebaseMessaging.setAutoInitEnabled(true);
    if (!user.emailVerified) {
      throw EmailNotVerified(user);
    }
    final self = await loggedInUser();
    if (self.role != api.UserRole.none) {
      await _registerDeviceToken();
    }
    return self;
  }

  @override
  Future<void> logout() async {
    await _firebaseMessaging.setAutoInitEnabled(false);
    await _deleteDeviceToken();
    await _firebaseMessaging.deleteToken();
    await _auth.signOut();
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<ApiWithUserId> apiClient() async {
    final authUser = _auth.currentUser;
    //ignore:unnecessary_null_comparison
    if (authUser == null) {
      throw UnAuthenticatedException();
    }
    final token = await authUser.getIdToken(false);
    _d.apiDelegate.apiClient.setDefaultHeader('X-TOKEN', token);
    final auth = ApiKeyAuth('header', 'X-TOKEN');
    auth.apiKey = token;
    _d.apiDelegate.apiClient.setAuthentication('ApiKeyAuth', auth);
    return ApiWithUserId(_d.apiDelegate.apiClient, authUser.uid);
  }

  @override
  Future<api.User> logIn() async {
    final user = await loggedInUser();
    await _registerDeviceToken();
    return user;
  }

  @override
  Future<api.User> loggedInUser() async {
    final client = await apiClient();
    return client.selfGet();
  }

  Future<void> _registerDeviceToken() async {
    final client = await apiClient();
    final deviceToken = await _firebaseMessaging.getToken();
    return client.selfDeviceRegisterPost(
        deviceId: api.DeviceId()..token = deviceToken);
  }

  Future<void> _deleteDeviceToken() async {
    final client = await apiClient();
    final deviceToken = await _firebaseMessaging.getToken();
    return client.selfDeviceRemovePost(
        deviceId: api.DeviceId()..token = deviceToken);
  }

  @override
  Future<api.User> verifyEmail() async {
    final user = _auth.currentUser;
    // See https://github.com/FirebaseExtended/flutterfire/issues/717
    await user.reload();
    if (!user.emailVerified) {
      throw EmailNotVerified(user);
    }
    return loggedInUser();
  }
}

class AuthenticationException implements Exception {}

class UnAuthenticatedException implements Exception {}

class EmailNotVerified implements Exception {
  const EmailNotVerified(this.user);
  final firebase.User user;
}
