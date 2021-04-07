import 'dart:async';
import 'package:trober_sdk/trober_sdk.dart' as api;
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

abstract class AuthRepository {
  const AuthRepository();
  Future<api.User> signIn(String username, String password);
  Future<api.User> registerUser(String name, String username, String password);
  Future<api.User> loggedInUser();
  Future<api.User> logIn();
  Future<void> logout();
  Future<api.User> verifyEmail();
  Future<void> forgotPassword(String email);
  Future<ApiWithUserId> apiClient();
  Future<String?> sendEmailForVerification();
}

class ApiWithUserId extends api.DefaultApi {
  ApiWithUserId(Dio dio, Serializers serializers, this.userId)
      : super(dio, serializers);
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
