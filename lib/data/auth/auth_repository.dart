import 'dart:async';
import 'package:openapi_dart_common/openapi.dart';
import 'package:trober_sdk/api.dart';

abstract class AuthRepository {
  const AuthRepository();
  Future<User> signIn(String username, String password);
  Future<User> registerUser(String name, String username, String password);
  Future<User> loggedInUser();
  Future<User> logIn();
  Future<void> logout();
  Future<User> verifyEmail();
  Future<void> forgotPassword(String email);
  Future<ApiWithUserId> apiClient();
  Future<String> sendEmailForVerification();
}

class ApiWithUserId extends DefaultApi {
  ApiWithUserId(ApiClient apiClient, this.userId) : super(apiClient);
  final String userId;
}

// AuthenticationException is thrown when a user auth fails
class AuthenticationException implements Exception {}

// UnAuthenticatedException is thrown when the user is not signed in
class UnAuthenticatedException implements Exception {}

//EmailNotVerifiedException is thrown when the user's email is not verified
class EmailNotVerifiedException implements Exception {
  const EmailNotVerifiedException(this.emailId);
  final String? emailId;
}
