part of 'dio_client.dart';

class DioCacheInterceptor extends Interceptor {
  DioCacheInterceptor();

  late final Map<Uri, Response> _cache = <Uri, Response>{};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _cache[response.requestOptions.uri] = response;
    handler.resolve(response);
  }

  @override
  dynamic onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.connectionTimeout || err.type == DioExceptionType.badResponse) {
      late Response? cacheResponse = _cache[err.requestOptions.uri];
      if (cacheResponse != null) {
        return cacheResponse;
      }
    }
    super.onError(err, handler);
  }
}