import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/data/user/user_repository.dart';
import 'package:trober_sdk/api.dart';

class RemoteUserRepository extends UserRepository {
  final ApiRepository _apiRepository;

  const RemoteUserRepository(this._apiRepository);
  @override
  Future<User> assign(UserRole role, String tenantId) {
    // TODO: implement assign
    throw UnimplementedError();
  }

  @override
  Future<List<User>> fetchUnAssignedUsers() {
    // TODO: implement fetchUnAssignedUsers
    throw UnimplementedError();
  }

  @override
  Future<User> fetchUser(String id) {
    // TODO: implement fetchUser
    throw UnimplementedError();
  }

  @override
  Future<User> self() async {
    var client = await _apiRepository.apiClient();
    var users = await client.usersGet();
    return users[0];
  }
}
