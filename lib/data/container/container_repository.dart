import 'package:trober_sdk/api.dart';

abstract class ContainerRepository {
  const ContainerRepository();
  Future<Container> fetchContainer(String id);
  Future<Container> createContainer(Container container);
  Future<Container> updateContainer(String id, Container container);
  Future<List<Container>> fetchContainers(User user);
  // Future<List<Container>> fetchContainersForDriver(String driverId);
  // Future<List<Container>> fetchContainersForTenant(String tenantId);
}
