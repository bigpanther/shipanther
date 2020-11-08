library trober_api.api;

/// OpenAPI API client

import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:openapi_dart_common/openapi.dart';
import 'package:collection/collection.dart';

part 'api_client.dart';

part 'api/default_api.dart';

part 'model/carrier.dart';
part 'model/carrier_type.dart';
part 'model/container.dart';
part 'model/container_size.dart';
part 'model/container_status.dart';
part 'model/container_type.dart';
part 'model/customer.dart';
part 'model/error.dart';
part 'model/order.dart';
part 'model/order_status.dart';
part 'model/tenant.dart';
part 'model/tenant_type.dart';
part 'model/terminal.dart';
part 'model/terminal_type.dart';
part 'model/user.dart';
part 'model/user_role.dart';
part 'model/yard.dart';
