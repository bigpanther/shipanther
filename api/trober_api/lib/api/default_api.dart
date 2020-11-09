part of trober_api.api;

class DefaultApi {
  final DefaultApiDelegate apiDelegate;
  DefaultApi(ApiClient apiClient)
      : assert(apiClient != null),
        apiDelegate = DefaultApiDelegate(apiClient);

  /// Get server health
  ///
  /// Get server health status
  Future healthGet({Options options}) async {
    final response = await apiDelegate.healthGet(
      options: options,
    );

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, await decodeBodyBytes(response));
    } else {
      return await apiDelegate.healthGet_decode(response);
    }
  }

  /// Get server health
  ///
  /// Get server health status
  /// List all tenants
  ///
  /// List all tenants
  Future<List<Tenant>> tenantsGet({Options options}) async {
    final response = await apiDelegate.tenantsGet(
      options: options,
    );

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, await decodeBodyBytes(response));
    } else {
      return await apiDelegate.tenantsGet_decode(response);
    }
  }

  /// List all tenants
  ///
  /// List all tenants
  /// Get tenant details
  ///
  /// Get tenant details
  Future<Tenant> tenantsIdGet(String id, {Options options}) async {
    final response = await apiDelegate.tenantsIdGet(
      id,
      options: options,
    );

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, await decodeBodyBytes(response));
    } else {
      return await apiDelegate.tenantsIdGet_decode(response);
    }
  }

  /// Get tenant details
  ///
  /// Get tenant details
  /// Update an existing tenant
  ///
  /// Update an existing tenant
  Future<Tenant> tenantsIdPatch(String id,
      {Options options, Tenant tenant}) async {
    final response =
        await apiDelegate.tenantsIdPatch(id, options: options, tenant: tenant);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, await decodeBodyBytes(response));
    } else {
      return await apiDelegate.tenantsIdPatch_decode(response);
    }
  }

  /// Update an existing tenant
  ///
  /// Update an existing tenant
  /// Create a new tenant
  ///
  /// Create a new tenant
  Future<Tenant> tenantsPost({Options options, Tenant tenant}) async {
    final response =
        await apiDelegate.tenantsPost(options: options, tenant: tenant);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, await decodeBodyBytes(response));
    } else {
      return await apiDelegate.tenantsPost_decode(response);
    }
  }

  /// Create a new tenant
  ///
  /// Create a new tenant
  /// List all users
  ///
  /// List all users
  Future<List<User>> usersGet(
      {Options options, String name, UserRole role}) async {
    final response =
        await apiDelegate.usersGet(options: options, name: name, role: role);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, await decodeBodyBytes(response));
    } else {
      return await apiDelegate.usersGet_decode(response);
    }
  }

  /// List all users
  ///
  /// List all users
  /// Delete the user
  ///
  /// Delete the user
  Future usersIdDelete(String id, {Options options}) async {
    final response = await apiDelegate.usersIdDelete(
      id,
      options: options,
    );

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, await decodeBodyBytes(response));
    } else {
      return await apiDelegate.usersIdDelete_decode(response);
    }
  }

  /// Delete the user
  ///
  /// Delete the user
  /// Get user details
  ///
  /// Get user details
  Future<User> usersIdGet(String id, {Options options}) async {
    final response = await apiDelegate.usersIdGet(
      id,
      options: options,
    );

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, await decodeBodyBytes(response));
    } else {
      return await apiDelegate.usersIdGet_decode(response);
    }
  }

  /// Get user details
  ///
  /// Get user details
  /// Update an existing user
  ///
  /// Update an existing user
  Future<User> usersIdPatch(String id, {Options options, User user}) async {
    final response =
        await apiDelegate.usersIdPatch(id, options: options, user: user);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, await decodeBodyBytes(response));
    } else {
      return await apiDelegate.usersIdPatch_decode(response);
    }
  }

  /// Update an existing user
  ///
  /// Update an existing user
  /// Create a new user
  ///
  /// Create a new user
  Future<User> usersPost({Options options, User user}) async {
    final response = await apiDelegate.usersPost(options: options, user: user);

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, await decodeBodyBytes(response));
    } else {
      return await apiDelegate.usersPost_decode(response);
    }
  }

  /// Create a new user
  ///
  /// Create a new user
}

class DefaultApiDelegate {
  final ApiClient apiClient;

  DefaultApiDelegate(this.apiClient) : assert(apiClient != null);

  Future<ApiResponse> healthGet({Options options}) async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    final __path = '/health';

    // query params
    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{}
      ..addAll(options?.headers?.cast<String, String>() ?? {});
    if (headerParams['Accept'] == null) {
      // we only want to accept this format as we can parse it
      headerParams['Accept'] = 'application/json';
    }

    final authNames = <String>[];
    final opt = options ?? Options();

    final contentTypes = [];

    if (contentTypes.isNotEmpty && headerParams['Content-Type'] == null) {
      headerParams['Content-Type'] = contentTypes[0];
    }
    if (postBody != null) {
      postBody = LocalApiClient.serialize(postBody);
    }

    opt.headers = headerParams;
    opt.method = 'GET';

    return await apiClient.invokeAPI(
        __path, queryParams, postBody, authNames, opt);
  }

  Future healthGet_decode(ApiResponse response) async {
    if (response.body != null) {}

    return;
  }

  Future<ApiResponse> tenantsGet({Options options}) async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    final __path = '/tenants';

    // query params
    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{}
      ..addAll(options?.headers?.cast<String, String>() ?? {});
    if (headerParams['Accept'] == null) {
      // we only want to accept this format as we can parse it
      headerParams['Accept'] = 'application/json';
    }

    final authNames = <String>['ApiKeyAuth'];
    final opt = options ?? Options();

    final contentTypes = [];

    if (contentTypes.isNotEmpty && headerParams['Content-Type'] == null) {
      headerParams['Content-Type'] = contentTypes[0];
    }
    if (postBody != null) {
      postBody = LocalApiClient.serialize(postBody);
    }

    opt.headers = headerParams;
    opt.method = 'GET';

    return await apiClient.invokeAPI(
        __path, queryParams, postBody, authNames, opt);
  }

  Future<List<Tenant>> tenantsGet_decode(ApiResponse response) async {
    if (response.body != null) {
      return (LocalApiClient.deserializeFromString(
              await decodeBodyBytes(response), 'List<Tenant>') as List)
          .map((item) => item as Tenant)
          .toList();
    }

    return null;
  }

  Future<ApiResponse> tenantsIdGet(String id, {Options options}) async {
    Object postBody;

    // verify required params are set
    if (id == null) {
      throw ApiException(400, 'Missing required param: id');
    }

    // create path and map variables
    final __path = '/tenants/{id}'.replaceAll('{' + 'id' + '}', id.toString());

    // query params
    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{}
      ..addAll(options?.headers?.cast<String, String>() ?? {});
    if (headerParams['Accept'] == null) {
      // we only want to accept this format as we can parse it
      headerParams['Accept'] = 'application/json';
    }

    final authNames = <String>['ApiKeyAuth'];
    final opt = options ?? Options();

    final contentTypes = [];

    if (contentTypes.isNotEmpty && headerParams['Content-Type'] == null) {
      headerParams['Content-Type'] = contentTypes[0];
    }
    if (postBody != null) {
      postBody = LocalApiClient.serialize(postBody);
    }

    opt.headers = headerParams;
    opt.method = 'GET';

    return await apiClient.invokeAPI(
        __path, queryParams, postBody, authNames, opt);
  }

  Future<Tenant> tenantsIdGet_decode(ApiResponse response) async {
    if (response.body != null) {
      return LocalApiClient.deserializeFromString(
          await decodeBodyBytes(response), 'Tenant') as Tenant;
    }

    return null;
  }

  Future<ApiResponse> tenantsIdPatch(String id,
      {Options options, Tenant tenant}) async {
    Object postBody = tenant;

    // verify required params are set
    if (id == null) {
      throw ApiException(400, 'Missing required param: id');
    }

    // create path and map variables
    final __path = '/tenants/{id}'.replaceAll('{' + 'id' + '}', id.toString());

    // query params
    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{}
      ..addAll(options?.headers?.cast<String, String>() ?? {});
    if (headerParams['Accept'] == null) {
      // we only want to accept this format as we can parse it
      headerParams['Accept'] = 'application/json';
    }

    final authNames = <String>['ApiKeyAuth'];
    final opt = options ?? Options();

    final contentTypes = ['application/json'];

    if (contentTypes.isNotEmpty && headerParams['Content-Type'] == null) {
      headerParams['Content-Type'] = contentTypes[0];
    }
    if (postBody != null) {
      postBody = LocalApiClient.serialize(postBody);
    }

    opt.headers = headerParams;
    opt.method = 'PATCH';

    return await apiClient.invokeAPI(
        __path, queryParams, postBody, authNames, opt);
  }

  Future<Tenant> tenantsIdPatch_decode(ApiResponse response) async {
    if (response.body != null) {
      return LocalApiClient.deserializeFromString(
          await decodeBodyBytes(response), 'Tenant') as Tenant;
    }

    return null;
  }

  Future<ApiResponse> tenantsPost({Options options, Tenant tenant}) async {
    Object postBody = tenant;

    // verify required params are set

    // create path and map variables
    final __path = '/tenants';

    // query params
    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{}
      ..addAll(options?.headers?.cast<String, String>() ?? {});
    if (headerParams['Accept'] == null) {
      // we only want to accept this format as we can parse it
      headerParams['Accept'] = 'application/json';
    }

    final authNames = <String>['ApiKeyAuth'];
    final opt = options ?? Options();

    final contentTypes = ['application/json'];

    if (contentTypes.isNotEmpty && headerParams['Content-Type'] == null) {
      headerParams['Content-Type'] = contentTypes[0];
    }
    if (postBody != null) {
      postBody = LocalApiClient.serialize(postBody);
    }

    opt.headers = headerParams;
    opt.method = 'POST';

    return await apiClient.invokeAPI(
        __path, queryParams, postBody, authNames, opt);
  }

  Future<Tenant> tenantsPost_decode(ApiResponse response) async {
    if (response.body != null) {
      return LocalApiClient.deserializeFromString(
          await decodeBodyBytes(response), 'Tenant') as Tenant;
    }

    return null;
  }

  Future<ApiResponse> usersGet(
      {Options options, String name, UserRole role}) async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    final __path = '/users';

    // query params
    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{}
      ..addAll(options?.headers?.cast<String, String>() ?? {});
    if (headerParams['Accept'] == null) {
      // we only want to accept this format as we can parse it
      headerParams['Accept'] = 'application/json';
    }

    if (name != null) {
      queryParams.addAll(convertParametersForCollectionFormat(
          LocalApiClient.parameterToString, '', 'name', name));
    }
    if (role != null) {
      queryParams.addAll(convertParametersForCollectionFormat(
          LocalApiClient.parameterToString, '', 'role', role));
    }

    final authNames = <String>['ApiKeyAuth'];
    final opt = options ?? Options();

    final contentTypes = [];

    if (contentTypes.isNotEmpty && headerParams['Content-Type'] == null) {
      headerParams['Content-Type'] = contentTypes[0];
    }
    if (postBody != null) {
      postBody = LocalApiClient.serialize(postBody);
    }

    opt.headers = headerParams;
    opt.method = 'GET';

    return await apiClient.invokeAPI(
        __path, queryParams, postBody, authNames, opt);
  }

  Future<List<User>> usersGet_decode(ApiResponse response) async {
    if (response.body != null) {
      return (LocalApiClient.deserializeFromString(
              await decodeBodyBytes(response), 'List<User>') as List)
          .map((item) => item as User)
          .toList();
    }

    return null;
  }

  Future<ApiResponse> usersIdDelete(String id, {Options options}) async {
    Object postBody;

    // verify required params are set
    if (id == null) {
      throw ApiException(400, 'Missing required param: id');
    }

    // create path and map variables
    final __path = '/users/{id}'.replaceAll('{' + 'id' + '}', id.toString());

    // query params
    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{}
      ..addAll(options?.headers?.cast<String, String>() ?? {});
    if (headerParams['Accept'] == null) {
      // we only want to accept this format as we can parse it
      headerParams['Accept'] = 'application/json';
    }

    final authNames = <String>['ApiKeyAuth'];
    final opt = options ?? Options();

    final contentTypes = [];

    if (contentTypes.isNotEmpty && headerParams['Content-Type'] == null) {
      headerParams['Content-Type'] = contentTypes[0];
    }
    if (postBody != null) {
      postBody = LocalApiClient.serialize(postBody);
    }

    opt.headers = headerParams;
    opt.method = 'DELETE';

    return await apiClient.invokeAPI(
        __path, queryParams, postBody, authNames, opt);
  }

  Future usersIdDelete_decode(ApiResponse response) async {
    if (response.body != null) {}

    return;
  }

  Future<ApiResponse> usersIdGet(String id, {Options options}) async {
    Object postBody;

    // verify required params are set
    if (id == null) {
      throw ApiException(400, 'Missing required param: id');
    }

    // create path and map variables
    final __path = '/users/{id}'.replaceAll('{' + 'id' + '}', id.toString());

    // query params
    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{}
      ..addAll(options?.headers?.cast<String, String>() ?? {});
    if (headerParams['Accept'] == null) {
      // we only want to accept this format as we can parse it
      headerParams['Accept'] = 'application/json';
    }

    final authNames = <String>['ApiKeyAuth'];
    final opt = options ?? Options();

    final contentTypes = [];

    if (contentTypes.isNotEmpty && headerParams['Content-Type'] == null) {
      headerParams['Content-Type'] = contentTypes[0];
    }
    if (postBody != null) {
      postBody = LocalApiClient.serialize(postBody);
    }

    opt.headers = headerParams;
    opt.method = 'GET';

    return await apiClient.invokeAPI(
        __path, queryParams, postBody, authNames, opt);
  }

  Future<User> usersIdGet_decode(ApiResponse response) async {
    if (response.body != null) {
      return LocalApiClient.deserializeFromString(
          await decodeBodyBytes(response), 'User') as User;
    }

    return null;
  }

  Future<ApiResponse> usersIdPatch(String id,
      {Options options, User user}) async {
    Object postBody = user;

    // verify required params are set
    if (id == null) {
      throw ApiException(400, 'Missing required param: id');
    }

    // create path and map variables
    final __path = '/users/{id}'.replaceAll('{' + 'id' + '}', id.toString());

    // query params
    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{}
      ..addAll(options?.headers?.cast<String, String>() ?? {});
    if (headerParams['Accept'] == null) {
      // we only want to accept this format as we can parse it
      headerParams['Accept'] = 'application/json';
    }

    final authNames = <String>['ApiKeyAuth'];
    final opt = options ?? Options();

    final contentTypes = ['application/json'];

    if (contentTypes.isNotEmpty && headerParams['Content-Type'] == null) {
      headerParams['Content-Type'] = contentTypes[0];
    }
    if (postBody != null) {
      postBody = LocalApiClient.serialize(postBody);
    }

    opt.headers = headerParams;
    opt.method = 'PATCH';

    return await apiClient.invokeAPI(
        __path, queryParams, postBody, authNames, opt);
  }

  Future<User> usersIdPatch_decode(ApiResponse response) async {
    if (response.body != null) {
      return LocalApiClient.deserializeFromString(
          await decodeBodyBytes(response), 'User') as User;
    }

    return null;
  }

  Future<ApiResponse> usersPost({Options options, User user}) async {
    Object postBody = user;

    // verify required params are set

    // create path and map variables
    final __path = '/users';

    // query params
    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{}
      ..addAll(options?.headers?.cast<String, String>() ?? {});
    if (headerParams['Accept'] == null) {
      // we only want to accept this format as we can parse it
      headerParams['Accept'] = 'application/json';
    }

    final authNames = <String>['ApiKeyAuth'];
    final opt = options ?? Options();

    final contentTypes = ['application/json'];

    if (contentTypes.isNotEmpty && headerParams['Content-Type'] == null) {
      headerParams['Content-Type'] = contentTypes[0];
    }
    if (postBody != null) {
      postBody = LocalApiClient.serialize(postBody);
    }

    opt.headers = headerParams;
    opt.method = 'POST';

    return await apiClient.invokeAPI(
        __path, queryParams, postBody, authNames, opt);
  }

  Future<User> usersPost_decode(ApiResponse response) async {
    if (response.body != null) {
      return LocalApiClient.deserializeFromString(
          await decodeBodyBytes(response), 'User') as User;
    }

    return null;
  }
}
