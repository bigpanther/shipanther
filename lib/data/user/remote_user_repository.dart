import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:trober_sdk/api.dart';

class RemoteUserRepository extends UserRepository {
  const RemoteUserRepository(this._apiRepository);
  final ApiRepository _apiRepository;
  @override
  Future<User> assign(UserRole role, String tenantId) async {
    throw UnimplementedError();
  }

  @override
  Future<User> fetchUser(String id) async {
    final client = await _apiRepository.apiClient();
    return await client.usersIdGet(client.userId);
  }

  @override
  Future<User> self() async {
    final client = await _apiRepository.apiClient();
    return client.selfGet();
  }

  @override
  Future<User> registerDeviceToken(String token) async {
    final me = await self();

    final client = await _apiRepository.apiClient();
    me.deviceId = token;
    return client.usersIdPut(me.id, user: me);
  }

  @override
  Future<List<User>> fetchUsers(
      {int? page = 1, UserRole? userRole, String? name}) async {
    final client = await _apiRepository.apiClient();
    return await client.usersGet(page: page, role: userRole, name: name);
  }

  @override
  Future<User> createUser(User user) async {
    final client = await _apiRepository.apiClient();
    return await client.usersPost(user: user);
  }

  @override
  Future<User> updateUser(String id, User user) async {
    final client = await _apiRepository.apiClient();
    return await client.usersIdPut(id, user: user);
  }
}
