import 'package:trober_sdk/api.dart';

abstract class UserRepository {
  const UserRepository();
  Future<User> fetchUser(String id);
  Future<User> self();
  Future<List<User>> fetchUnAssignedUsers();
  Future<User> assign(UserRole role, String tenantId);
}
