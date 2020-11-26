import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:trober_sdk/api.dart';

class RemoteUserRepository extends UserRepository {
  final ApiRepository _apiRepository;
  const RemoteUserRepository(this._apiRepository);
  @override
  Future<User> assign(UserRole role, String tenantId) async {
    //var client = await _apiRepository.apiClient();
    //client.
    throw UnimplementedError();
  }

  @override
  Future<List<User>> fetchUnAssignedUsers() async {
    var client = await _apiRepository.apiClient();
    List<User> users = await client.usersGet();
    return users.where((u) => u.role == UserRole.none);
  }

  @override
  Future<User> fetchUser(String id) async {
    var client = await _apiRepository.apiClient();
    return await client.usersIdGet(client.userId);
  }

  @override
  Future<User> self() async {
    var client = await _apiRepository.apiClient();
    return client.selfGet();
  }

  @override
  Future<User> registerDeviceToken(String token) async {
    var me = await self();

    var client = await _apiRepository.apiClient();
    me.deviceId = token;
    return client.usersIdPut(me.id, user: me);
  }

  @override
  Future<List<User>> fetchUsers() async {
    var client = await _apiRepository.apiClient();
    return await client.usersGet();
  }

  @override
  Future<User> createUser(User user) async {
    var client = await _apiRepository.apiClient();
    return await client.usersPost(user: user);
  }

  @override
  Future<User> updateUser(String id, User user) async {
    var client = await _apiRepository.apiClient();
    return await client.usersIdPut(id, user: user);
  }

  @override
  Future<List<User>> filterUsers(UserRole userRole) async {
    var users = await fetchUsers();
    if (userRole == null) {
      return users;
    }
    return users.where((e) => e.role == userRole).toList();
  }
}
