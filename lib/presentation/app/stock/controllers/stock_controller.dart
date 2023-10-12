import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/data/payloads/stock_adjustment_item_payload.dart';
import 'package:pos_application_mobile/data/payloads/stock_adjustment_payload.dart';
import 'package:pos_application_mobile/domain/entities/stock_entity.dart';
import 'dart:async';

import 'package:pos_application_mobile/domain/use_cases/stock/fetch_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/stock/stock_adjustment_use_case.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_alert.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_snackbar.dart';

class StockController extends GetxController {
  /// Fetch data use case instance for  data.
  late FetchDataUseCase fetchDataUseCase;
  late StockAdjustmentUseCase stockAdjustmentUseCase;

  /// List of fetched data.
  final RxList<StockEntity> _data = <StockEntity>[].obs;
  List<StockEntity> get data => _data;

  /// Loading indicator state.
  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  ///  current state for pagination
  final Rx<int> _currentPage = 1.obs;
  int get currentPage => _currentPage.value;

  ///  total pagination state
  final Rx<int> _totalPage =  0.obs;
  int get totalPage => _totalPage.value;

  /// Timer for handle debonce search 
  Timer? _debonce;

  /// show crud access
  final Rx<bool> _showSupperAccess = false.obs;
  bool get showSuperAccess => _showSupperAccess.value;

  @override
  void onInit() {
    fetchDataUseCase = FetchDataUseCase();
    stockAdjustmentUseCase = StockAdjustmentUseCase();
    fetchData();
    super.onInit();
  }

  @override
  void onClose() {
    _debonce?.cancel();
    super.onClose();
  }

  /// do clear data 
  void clearData() {
    _totalPage.value = 0;
    _currentPage.value = 1;
    _data.value = [];
  }



  /// Search data handler
  /// 
  /// This function do to handling search by input value and
  /// debonce for 500 milisecond
  /// 
  /// Usage example:
  /// ```dart
  /// TextFormField(onChanged: searchDataColor)
  /// ```
  void searchData(Map<String, dynamic> queryParameters) {
    if (_debonce?.isActive ?? false) _debonce!.cancel();
    _debonce = Timer(const Duration(milliseconds: 800), () {
      fetchData(
        refresh: true,
        queryParameters: queryParameters
      );
    });
  }


  Future<void> adjustmentStock({ required String stock, required String clothSizeId }) async {
    try {
      StockAdjustmentPayload payload = StockAdjustmentPayload(
        stockAdjustmentsPayload: [
          StockAdjustmentItemPayload(clothSizeId: clothSizeId, stock: int.parse(stock))
        ]
      );

      PAMAlertWidget.showLoadingAlert(Get.context!);
      await stockAdjustmentUseCase.call(payload);
      fetchData(refresh: true);
   } on DioException catch (e) {
      Get.back();
      
      PAMSnackBarWidget.show(
        title: "failed".tr.toCapitalize(),
        message: e.response?.data["message"] ?? e.response?.data["errors"],
        type: PAMSnackBarWidgetType.danger
      );
    } catch (e, f) {
      Get.back();
      PAMSnackBarWidget.show(
        title: "failed".tr.toCapitalize(),
        message: "failed to process data, please try again".tr.toCapitalize(),
        type: PAMSnackBarWidgetType.danger
      );
    }
  } 



  /// Fetches data from a remote data source.
  ///
  /// The `fetchData` function is responsible for fetching data from a remote
  /// data source. It updates several states such as [currentPage], [totalPage],
  /// [isLoading], and [data] to manage the pagination and loading of  data.
  ///
  /// If the `refresh` parameter is set to `true`, the existing data will be cleared.
  ///
  /// Parameters:
  /// - `refresh`: A boolean value indicating whether to refresh the data.
  /// - `queryParameters`: Optional map of query parameters to be included in the request.
  ///
  /// Throws an exception if an error occurs during data fetching.
  ///
  Future<void> fetchData({bool refresh = false, Map<String, dynamic>? queryParameters}) async {
    // Clear data if refreshing
    if (refresh) clearData();

    // Check if we have reached the total number of pages
    if (_currentPage.value == _totalPage.value) return;

    // Build query parameters for the request
    Map<String, dynamic> buildQueryParameters = {
      "ascending": 1,
      "page": _currentPage.value,
    };

    // Merge additional query parameters if provided
    if (queryParameters != null) {
      buildQueryParameters = {
        ...buildQueryParameters,
        ...queryParameters,
      };
    }

    // Set loading state
    _isLoading.value = true;

    // Fetch data using the  data use case
    List<StockEntity> data = await fetchDataUseCase.call(buildQueryParameters);

    // Update state with fetched data
    _data.addAll(data);
    _isLoading.value = false;

    // Increment current page if data is fetched successfully
    if (data.isNotEmpty) {
      _currentPage.value = _currentPage.value + 1;
    } else {
      // Set total page if no more data is available
      _totalPage.value = _currentPage.value;
    }
  }
}