part of '../api/dio_client.dart';

class DioCacheInterceptor extends Interceptor {

  DioCacheInterceptor();

  late final Map<Uri, Response> _cache = {};

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _cache[response.requestOptions.uri] = response;
    handler.resolve(response);
  }

  @override
  dynamic onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.connectionTimeout || err.type == DioExceptionType.badResponse) {
      late Response? cacheRespone = _cache[err.requestOptions.uri];
      if (cacheRespone != null) {
        return cacheRespone;
      }
      super.onError(err, handler);
    }
  }
}