// ignore_for_file: invalid_use_of_protected_member

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/services/auth_service.dart';
import 'package:pos_application_mobile/data/payloads/size_payload.dart';
import 'package:pos_application_mobile/domain/entities/size_entity.dart';
import 'package:pos_application_mobile/domain/use_cases/size/delete_data_use_case.dart';
import 'dart:async';

import 'package:pos_application_mobile/domain/use_cases/size/fetch_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/size/store_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/size/update_data_use_case.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_alert.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_snackbar.dart';

/// Controller responsible for managing Size related operations.
class SizeController extends GetxController {
  /// Get depedency from auth service
  final AuthService authService = Get.find<AuthService>();

  /// Fetch data use case instance for Size data.
  final FetchDataUseCase fetchDataUseCaseSize = Get.put(FetchDataUseCase());

  /// Store data use case instance for Size data.
  final StoreDataUseCase storeDataUseCaseSize = Get.put(StoreDataUseCase());

  /// Delete data use  case instance for Size data.
  final DeleteDataUseCase deleteDataUseCaseSize = Get.put(DeleteDataUseCase());

  /// Update data use case instance for Size data.
  final UpdateDataUseCase updateDataUseCaseSize = Get.put(UpdateDataUseCase());

  /// List of fetched Size data.
  final RxList<SizeEntity> _dataSize = <SizeEntity>[].obs;
  List<SizeEntity> get dataSize => _dataSize.value;

  /// Loading indicator state.
  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  /// Size current state for pagination
  final Rx<int> _currentPage = 1.obs;
  int get currentPage => _currentPage.value;

  /// Size total pagination state
  final Rx<int> _totalPage =  0.obs;
  int get totalPage => _totalPage.value;

  /// Timer for handle debonce search Size
  Timer? _debonce;

  /// show crud access
  final Rx<bool> _showSupperAccess = false.obs;
  bool get showSuperAccess => _showSupperAccess.value;

  @override
  void onInit() {
    fetchdataSize();
    _showSupperAccess.value = [AuthService.OWNER, AuthService.MANAGER].contains(
      authService.userEntity?.role
    );
    
    super.onInit();
  }

  @override
  void onClose() {
    _debonce?.cancel();
    super.onClose();
  }

  /// do clear data Size
  void cleardataSize() {
    _totalPage.value = 0;
    _currentPage.value = 1;
    _dataSize.value = [];
  }

  /// Search data Size handler
  /// 
  /// This function do to handling search by input value and
  /// debonce for 500 milisecond
  /// 
  /// Usage example:
  /// ```dart
  /// TextFormField(onChanged: searchdataSize)
  /// ```
  void searchdataSize(String value) {
    if (_debonce?.isActive ?? false) _debonce!.cancel();
    _debonce = Timer(const Duration(milliseconds: 800), () {
      fetchdataSize(
        refresh: true,
        queryParameters: {
          "name": value
        }
      );
    });
  }

  /// Fetches Size data from a remote data source.
  ///
  /// The `fetchdataSize` function is responsible for fetching data from a remote
  /// data source. It updates several states such as [currentPage], [totalPage],
  /// [isLoading], and [dataSizes] to manage the pagination and loading of Size data.
  ///
  /// If the `refresh` parameter is set to `true`, the existing data will be cleared.
  ///
  /// Parameters:
  /// - `refresh`: A boolean value indicating whether to refresh the data.
  /// - `queryParameters`: Optional map of query parameters to be included in the request.
  ///
  /// Throws an exception if an error occurs during data fetching.
  ///
  Future<void> fetchdataSize({bool refresh = false, Map<String, dynamic>? queryParameters}) async {
    // Clear data if refreshing
    if (refresh) cleardataSize();

    // Check if we have reached the total number of pages
    if (_currentPage.value == _totalPage.value) return;

    // Build query parameters for the request
    Map<String, dynamic> buildQueryParameters = {
      "order": "name",
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

    // Fetch data using the Size data use case
    List<SizeEntity> data = await fetchDataUseCaseSize.call(buildQueryParameters);

    // Update state with fetched data
    _dataSize.value.addAll(data);
    _isLoading.value = false;

    // Increment current page if data is fetched successfully
    if (data.isNotEmpty) {
      _currentPage.value = _currentPage.value + 1;
    } else {
      // Set total page if no more data is available
      _totalPage.value = _currentPage.value;
    }
  }

  /// Store Size data to remote data source.
  /// 
  /// The `SizeStore` will store data to remote API and 
  /// this function will auto update current state for listing prev
  /// data Size
  /// 
  /// Parameters:
  /// - `paylaod`: A [SizePaylaod] entity while will store to remote data source.
  /// 
  /// Usage example:
  /// ```dart
  /// SizeStore(payload(/*...*/))
  /// ```
  void sizeStore(SizePayload paylaod) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      await storeDataUseCaseSize.call(paylaod);

      // back from load screen
      Get.back();

      // back from form screen
      Get.back(result: "after store");
    } on DioException catch (e) {
      Get.back();
      PAMSnackBarWidget.show(
        title: "failed".tr.toCapitalize(),
        message: e.response!.data["message"] ?? e.response!.data["error"],
        type: PAMSnackBarWidgetType.danger
      );
    } catch (e) {
      Get.back();
      PAMSnackBarWidget.show(
        title: "failed".tr.toCapitalize(),
        message: "failed to process data, please try again".tr.toCapitalize(),
        type: PAMSnackBarWidgetType.danger
      );
    }
  }

  /// Delete data Size handling
  /// 
  /// The `SizeDelete` will delete data from API and will remove
  /// local state list Size.
  /// 
  /// Parameters:
  /// - `id`: A string reprentation of uniquer identifier.
  /// 
  /// Usage example:
  /// ```dart
  /// SizeDelete(jslf293lf-32343fsaf-fsalfl3)
  /// ```
  void sizeDelete(String id) async {
    try {
      _dataSize.value.removeWhere((element) => element.id == id);
      await deleteDataUseCaseSize.call(id);

      List<SizeEntity> currentData = _dataSize.value;
      _dataSize.value = [];
      _dataSize.value.addAll(currentData);

      PAMSnackBarWidget.show(
        title: "success".tr.toCapitalize(),
        message: "the Size has been removed successfully".tr.toCapitalize(),
        type: PAMSnackBarWidgetType.success
      );
    } catch (e) {
      if (e is! DioException) {
        PAMSnackBarWidget.show(
          title: "failed".tr.toCapitalize(),
          message: "failed to process data, please try again".tr.toCapitalize(),
          type: PAMSnackBarWidgetType.success
        );
      }
    }
  }

  /// Update data Size handling
  void sizeUpdate(SizePayload paylaod) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      _dataSize.value.removeWhere((element) => element.id == paylaod.id);
      final SizeEntity data = await updateDataUseCaseSize.call(paylaod);

      _dataSize.add(data);
      // back from load screen
      Get.back();

      // back from form screen
      Get.back();
    } on DioException catch (e) {
      Get.back();
      PAMSnackBarWidget.show(
        title: "failed".tr.toCapitalize(),
        message: e.response!.data["message"],
        type: PAMSnackBarWidgetType.danger
      );
    } catch (e) {
      PAMSnackBarWidget.show(
        title: "failed".tr.toCapitalize(),
        message: "failed to process data, please try again".tr.toCapitalize(),
        type: PAMSnackBarWidgetType.danger
      );
    }
  }
}
