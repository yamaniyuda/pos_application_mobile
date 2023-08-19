part of '../../config/api/dio_client.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final String token = await GetTokenUseCase().call();
    options.headers["Authorization"] = token;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {

    // handling snackbar show when request method post or patch cannot show
    // snackbar
    if (err.response != null && !['POST', 'PATCH'].contains(err.requestOptions.method) && err.requestOptions.path != "api/me") {
      PAMSnackBarWidget.show(
        title: "failed".tr.toCapitalize(),
        message: err.response!.data["message"],
        type: PAMSnackBarWidgetType.danger
      );

      if (err.response!.statusCode == 401) {
        Get.Get.offNamed(Routes.auth);
      }
    }
    handler.next(err);
  }
}