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
    List<User> users = await client.usersGet();
    return users.firstWhere((u) => u.username == client.userId);
    //return fetchUser(client.userId);
  }
}
