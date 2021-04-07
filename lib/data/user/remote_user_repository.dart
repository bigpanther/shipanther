import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:trober_sdk/trober_sdk.dart';

class RemoteUserRepository extends UserRepository {
  const RemoteUserRepository(this._authRepository);
  final AuthRepository _authRepository;
  @override
  Future<User> assign(UserRole role, String tenantId) async {
    throw UnimplementedError();
  }

  @override
  Future<User?> fetchUser(String id) async {
    final client = await _authRepository.apiClient();
    final resp = await client.usersIdGet(id: client.userId);
    return resp.data;
  }

  @override
  Future<Iterable<User>> fetchUsers(
      {int? page = 1, UserRole? userRole, String? name}) async {
    final client = await _authRepository.apiClient();
    final resp = await client.usersGet(page: page, role: userRole, name: name);
    return resp.data ?? [];
  }

  @override
  Future<User?> createUser(User user) async {
    final client = await _authRepository.apiClient();
    final resp = await client.usersPost(user: user);
    return resp.data;
  }

  @override
  Future<User?> updateUser(String id, User user) async {
    final client = await _authRepository.apiClient();
    final resp = await client.usersIdPut(id: id, user: user);
    return resp.data;
  }
}
