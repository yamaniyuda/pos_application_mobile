part of 'dio_client.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // final String token = await GetTokenUseCase().call();
    // options.headers["Authorization"] = token;
    super.onRequest(options, handler);
  }
}