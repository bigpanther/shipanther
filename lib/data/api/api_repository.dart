import 'package:openapi_dart_common/openapi.dart';
import 'package:trober_sdk/api.dart';

abstract class ApiRepository {
  const ApiRepository();
  Future<ApiWithUserId> apiClient();
}

class ApiWithUserId extends DefaultApi {
  final String userId;

  ApiWithUserId(ApiClient apiClient, this.userId) : super(apiClient);
}
