import 'package:trober_sdk/api.dart';

abstract class UserRepository {
  const UserRepository();
  Future<User> fetchUser(String id);
  Future<User> self();
  Future<User> registerDeviceToken(String token);
  Future<User> assign(UserRole role, String tenantId);
  Future<User> createUser(User user);
  Future<User> updateUser(String id, User user);
  Future<List<User>> fetchUsers();
  Future<List<User>> filterUsers(UserRole userRole);
}
