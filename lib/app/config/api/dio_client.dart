import 'package:dio/dio.dart';
import 'package:pos_application_mobile/app/config/constants.dart';
import 'package:pos_application_mobile/domain/use_cases/auth/get_token_use_case.dart';

part 'dio_cache_interceptor.dart';
part 'dio_interceptor.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

/// Dio client for setup dio
/// like base url , interceptor, and
/// for custom request
class DioClient {
  late Dio _dio;
  late String _baseUrl;

  Dio get dio => _dio;
  String get baseUrl => _baseUrl;

  DioClient.init([String baseUrl = Constants.baseUrl]) {
    _baseUrl = baseUrl;
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        responseType: ResponseType.json,
        followRedirects: true,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        }
      )
    );
    addInterceptor();
  }

  DioClient addInterceptor() {
    _dio.interceptors.add(DioInterceptor());
    return this;
  }

  DioClient addCacheInterceptor() {
    _dio.interceptors.add(DioCacheInterceptor());
    return this;
  }

  Future<T> getRequest<T>(String endpoint, {
    required ResponseConverter<T> converter,
    Map<String, dynamic>? queryParameters
  }) async {
    final Response response = await _dio.get(endpoint, queryParameters: queryParameters);
    return converter(response.data);
  }

  Future<T> postRequest<T>(String endpoint, {
    required ResponseConverter<T> converter,
    required Object payload
  }) async {
    final Response response = await _dio.post(endpoint, data: payload);
    return converter(response.data);
  }

  Future<T> patchRequest<T>(String endpoint, {
    required ResponseConverter<T> converter,
    required Object payload
  }) async {
    final Response response = await _dio.patch(endpoint, data: payload);
    return converter(response.data);
  }

  Future<T> deleteRequest<T>(String endpoint, {
    required ResponseConverter<T> converter,
    required String id,
  }) async {
    final Response response = await _dio.delete("$endpoint/$id");
    return converter(response.data);
  }
}