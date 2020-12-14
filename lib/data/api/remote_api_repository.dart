import 'package:shipanther/data/api/api_repository.dart';
import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:trober_sdk/api.dart';
import 'package:openapi_dart_common/openapi.dart';

class RemoteApiRepository extends ApiRepository {
  RemoteApiRepository(this._authRepository, this._url) {
    _d = DefaultApi(ApiClient(basePath: _url));
  }
  final AuthRepository _authRepository;
  final String _url;
  DefaultApi _d;

  @override
  Future<ApiWithUserId> apiClient() async {
    final authUser = _authRepository.loggedInUser();
    final token = await authUser.getIdToken(false);
    _d.apiDelegate.apiClient.setDefaultHeader('X-TOKEN', token);
    final auth = ApiKeyAuth('header', 'X-TOKEN');
    auth.apiKey = token;
    _d.apiDelegate.apiClient.setAuthentication('ApiKeyAuth', auth);
    return ApiWithUserId(_d.apiDelegate.apiClient, authUser.uid);
  }
}
