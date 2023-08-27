// ignore_for_file: invalid_use_of_protected_member

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/services/auth_service.dart';
import 'package:pos_application_mobile/data/payloads/customer_type_payload.dart';
import 'package:pos_application_mobile/domain/entities/customer_type_entity.dart';
import 'package:pos_application_mobile/domain/use_cases/customer_type/delete_data_use_case.dart';
import 'dart:async';

import 'package:pos_application_mobile/domain/use_cases/customer_type/fetch_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/customer_type/store_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/customer_type/update_data_use_case.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_alert.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_snackbar.dart';

/// Controller responsible for managing CustomerType-related operations.
class CustomerTypeController extends GetxController {
  /// Get depedency from auth service
  final AuthService authService = Get.find<AuthService>();

  /// Fetch data use case instance for CustomerType data.
  final FetchDataUseCase fetchDataUseCaseCustomerType = Get.put(FetchDataUseCase());

  /// Store data use case instance for CustomerType data.
  final StoreDataUseCase storeDataUseCaseCustomerType = Get.put(StoreDataUseCase());

  /// Delete data use  case instance for CustomerType data.
  final DeleteDataUseCase deleteDataUseCaseCustomerType = Get.put(DeleteDataUseCase());

  /// Update data use case instance for CustomerType data.
  final UpdateDataUseCase updateDataUseCaseCustomerType = Get.put(UpdateDataUseCase());

  /// List of fetched CustomerType data.
  final RxList<CustomerTypeEntity> _dataCustomerType = <CustomerTypeEntity>[].obs;
  List<CustomerTypeEntity> get dataCustomerType => _dataCustomerType.value;

  /// Loading indicator state.
  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  /// CustomerType current state for pagination
  final Rx<int> _currentPage = 1.obs;
  int get currentPage => _currentPage.value;

  /// CustomerType total pagination state
  final Rx<int> _totalPage =  0.obs;
  int get totalPage => _totalPage.value;

  /// Timer for handle debonce search CustomerType
  Timer? _debonce;

  /// show crud access
  final Rx<bool> _showSupperAccess = false.obs;
  bool get showSuperAccess => _showSupperAccess.value;

  @override
  void onInit() {
    fetchDataCustomerType();
    _showSupperAccess.value = [AuthService.OWNER].contains(
      authService.userEntity?.role
    );
    
    super.onInit();
  }

  @override
  void onClose() {
    _debonce?.cancel();
    super.onClose();
  }

  /// do clear data CustomerType
  void clearDataCustomerType() {
    _totalPage.value = 0;
    _currentPage.value = 1;
    _dataCustomerType.value = [];
  }

  /// Search data CustomerType handler
  /// 
  /// This function do to handling search by input value and
  /// debonce for 500 milisecond
  /// 
  /// Usage example:
  /// ```dart
  /// TextFormField(onChanged: searchDataCustomerType)
  /// ```
  void searchDataCustomerType(String value) {
    if (_debonce?.isActive ?? false) _debonce!.cancel();
    _debonce = Timer(const Duration(milliseconds: 800), () {
      fetchDataCustomerType(
        refresh: true,
        queryParameters: {
          "name": value
        }
      );
    });
  }

  /// Fetches CustomerType data from a remote data source.
  ///
  /// The `fetchDataCustomerType` function is responsible for fetching data from a remote
  /// data source. It updates several states such as [currentPage], [totalPage],
  /// [isLoading], and [dataCustomerTypes] to manage the pagination and loading of CustomerType data.
  ///
  /// If the `refresh` parameter is set to `true`, the existing data will be cleared.
  ///
  /// Parameters:
  /// - `refresh`: A boolean value indicating whether to refresh the data.
  /// - `queryParameters`: Optional map of query parameters to be included in the request.
  ///
  /// Throws an exception if an error occurs during data fetching.
  ///
  Future<void> fetchDataCustomerType({bool refresh = false, Map<String, dynamic>? queryParameters}) async {
    // Clear data if refreshing
    if (refresh) clearDataCustomerType();

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

    // Fetch data using the CustomerType data use case
    List<CustomerTypeEntity> data = await fetchDataUseCaseCustomerType.call(buildQueryParameters);

    // Update state with fetched data
    _dataCustomerType.value.addAll(data);
    _isLoading.value = false;

    // Increment current page if data is fetched successfully
    if (data.isNotEmpty) {
      _currentPage.value = _currentPage.value + 1;
    } else {
      // Set total page if no more data is available
      _totalPage.value = _currentPage.value;
    }
  }

  /// Store CustomerType data to remote data source.
  /// 
  /// The `CustomerTypeStore` will store data to remote API and 
  /// this function will auto update current state for listing prev
  /// data CustomerType
  /// 
  /// Parameters:
  /// - `paylaod`: A [CustomerTypePaylaod] entity while will store to remote data source.
  /// 
  /// Usage example:
  /// ```dart
  /// CustomerTypeStore(payload(/*...*/))
  /// ```
  void customerTypeStore(CustomerTypePayload paylaod) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      await storeDataUseCaseCustomerType.call(paylaod);

      // back from load screen
      Get.back();

      // back from form screen
      Get.back(result: "after store");
    } on DioException catch (e) {
      Get.back();
      PAMSnackBarWidget.show(
        title: "failed".tr.toCapitalize(),
        message: e.response!.data["message"],
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

  /// Delete data CustomerType handling
  /// 
  /// The `CustomerTypeDelete` will delete data from API and will remove
  /// local state list CustomerType.
  /// 
  /// Parameters:
  /// - `id`: A string reprentation of uniquer identifier.
  /// 
  /// Usage example:
  /// ```dart
  /// CustomerTypeDelete(jslf293lf-32343fsaf-fsalfl3)
  /// ```
  void customerTypeDelete(String id) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      _dataCustomerType.value.removeWhere((element) => element.id == id);
      await deleteDataUseCaseCustomerType.call(id);

      List<CustomerTypeEntity> currentData = _dataCustomerType.value;
      _dataCustomerType.value = [];
      _dataCustomerType.value.addAll(currentData);

      if (Get.isSnackbarOpen) {
        Get.closeAllSnackbars();
      }

      // remove dialog
      Get.back(closeOverlays: true);

      PAMSnackBarWidget.show(
        title: "success".tr.toCapitalize(),
        message: "data deleted successfully".tr.toCapitalize(),
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

      // remove dialog
      Get.back();
    }
  }

  /// Update data CustomerType handling
  void customerTypeUpdate(CustomerTypePayload paylaod) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      _dataCustomerType.value.removeWhere((element) => element.id == paylaod.id);
      await updateDataUseCaseCustomerType.call(paylaod);
      await fetchDataCustomerType(refresh: true);

      // back from load screen
      Get.back();

      // back from form screen
      Get.back();
    } on DioException catch (e) {
      Get.back();
      PAMSnackBarWidget.show(
        title: "failed".tr.toCapitalize(),
        message: e.response!.data["message"] ?? e.response!.data["erros"],
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
