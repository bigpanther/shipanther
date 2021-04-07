import 'package:trober_sdk/trober_sdk.dart';

abstract class UserRepository {
  const UserRepository();
  Future<User?> fetchUser(String id);
  Future<User?> assign(UserRole role, String tenantId);
  Future<User?> createUser(User user);
  Future<User?> updateUser(String id, User user);
  Future<Iterable<User>> fetchUsers(
      {int? page = 1, UserRole? userRole, String? name});
}
