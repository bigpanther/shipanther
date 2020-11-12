import 'package:trober_sdk/api.dart';

abstract class ApiRepository {
  const ApiRepository();
  Future<DefaultApi> apiClient();
}
