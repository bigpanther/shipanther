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

  @override
  Future<List<Container>> fetchContainers() async {
    var client = await _apiRepository.apiClient();
    return client.containersGet();
  }
}
