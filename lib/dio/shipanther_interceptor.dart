import 'package:dio/dio.dart';
import 'package:trober_sdk/trober_sdk.dart' as api;
import 'package:built_value/serializer.dart';

class ShipantherInterceptor extends Interceptor {
  ShipantherInterceptor(this._serializers);
  final Serializers _serializers;
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.followRedirects = false;
    // Only 2xx codes are expected responses
    options.validateStatus =
        (status) => (status != null && status >= 200 && status < 300);
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      var response = err.response!;
      api.Error responseData;
      try {
        responseData = _serializers.deserialize(
          response.data,
          specifiedType: const FullType(api.Error),
        ) as api.Error;
      } catch (e) {
        return super.onError(err, handler);
      }
      err.error = '${responseData.code}:${responseData.message}';
    }
    return super.onError(err, handler);
  }
}
