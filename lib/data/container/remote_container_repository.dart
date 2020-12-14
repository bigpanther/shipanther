import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/container/container_repository.dart';
import 'package:trober_sdk/api.dart';

class RemoteContainerRepository extends ContainerRepository {
  const RemoteContainerRepository(this._apiRepository);
  final ApiRepository _apiRepository;

  @override
  Future<Container> fetchContainer(String id) async {
    final client = await _apiRepository.apiClient();
    return await client.containersIdGet(id);
  }

  @override
  Future<Container> createContainer(Container container) async {
    final client = await _apiRepository.apiClient();
    return await client.containersPost(container: container);
  }

  @override
  Future<Container> updateContainer(String id, Container container) async {
    final client = await _apiRepository.apiClient();
    return await client.containersIdPut(id, container: container);
  }

  @override
  Future<List<Container>> fetchContainers() async {
    final client = await _apiRepository.apiClient();
    return client.containersGet();
  }
}
