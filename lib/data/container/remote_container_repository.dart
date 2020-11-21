import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/container/container_repository.dart';
import 'package:trober_sdk/api.dart';

class RemoteContainerRepository extends ContainerRepository {
  final ApiRepository _apiRepository;

  const RemoteContainerRepository(this._apiRepository);

  @override
  Future<Container> fetchContainer(String id) async {
    var client = await _apiRepository.apiClient();
    return await client.containersIdGet(id);
  }

  // @override
  // Future<List<Container>> fetchContainers() async {
  //   var client = await _apiRepository.apiClient();
  //   return await client.containersGet();
  // }

  @override
  Future<Container> createContainer(Container container) async {
    var client = await _apiRepository.apiClient();
    return await client.containersPost(container: container);
  }

  @override
  Future<Container> updateContainer(String id, Container container) async {
    var client = await _apiRepository.apiClient();
    return await client.containersIdPatch(id, container: container);
  }

  // @override
  // Future<List<Container>> fetchContainersForDriver(String driverId) async {
  //   var containers = await fetchContainers();

  //   return containers.where((e) => e.driverId == driverId).toList();
  // }

  // @override
  // Future<List<Container>> fetchContainersForTenant(String tenantId) async {
  //   var containers = await fetchContainers();

  //   return containers.where((e) => e.tenantId == tenantId).toList();
  // }
  @override
  Future<List<Container>> fetchContainers(User user) async {
    var containers = await fetchContainers(null);
    if (user.role == UserRole.admin) {
      return containers.where((e) => e.tenantId == user.id).toList();
    }
    if (user.role == UserRole.driver) {
      return containers.where((e) => e.driverId == user.id).toList();
    }
    return null;
  }

  // @override
  // Future<Container> deleteContainer(String id) async {
  //   var client = await _apiRepository.apiClient();
  //   return await client.containers
  // }
}
