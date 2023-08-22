// ignore_for_file: invalid_use_of_protected_member

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/services/auth_service.dart';
import 'package:pos_application_mobile/data/payloads/supplier_payload.dart';
import 'package:pos_application_mobile/domain/entities/supplier_entity.dart';
import 'package:pos_application_mobile/domain/use_cases/supplier/delete_data_use_case.dart';
import 'dart:async';

import 'package:pos_application_mobile/domain/use_cases/supplier/fetch_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/supplier/store_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/supplier/update_data_use_case.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_alert.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_snackbar.dart';

/// Controller responsible for managing Supplier-related operations.
class SupplierController extends GetxController {
  /// Get depedency from auth service
  final AuthService authService = Get.find<AuthService>();

  /// Fetch data use case instance for Supplier data.
  final FetchDataUseCase fetchDataUseCaseSupplier = Get.put(FetchDataUseCase());

  /// Store data use case instance for Supplier data.
  final StoreDataUseCase storeDataUseCaseSupplier = Get.put(StoreDataUseCase());

  /// Delete data use  case instance for Supplier data.
  final DeleteDataUseCase deleteDataUseCaseSupplier = Get.put(DeleteDataUseCase());

  /// Update data use case instance for Supplier data.
  final UpdateDataUseCase updateDataUseCaseSupplier = Get.put(UpdateDataUseCase());

  /// List of fetched Supplier data.
  final RxList<SupplierEntity> _dataSupplier = <SupplierEntity>[].obs;
  List<SupplierEntity> get dataSupplier => _dataSupplier.value;

  /// Loading indicator state.
  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  /// Supplier current state for pagination
  final Rx<int> _currentPage = 1.obs;
  int get currentPage => _currentPage.value;

  /// Supplier total pagination state
  final Rx<int> _totalPage =  0.obs;
  int get totalPage => _totalPage.value;

  /// Timer for handle debonce search Supplier
  Timer? _debonce;

  /// show crud access
  final Rx<bool> _showSupperAccess = false.obs;
  bool get showSuperAccess => _showSupperAccess.value;

  @override
  void onInit() {
    fetchDataSupplier();
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

  /// do clear data Supplier
  void clearDataSupplier() {
    _totalPage.value = 0;
    _currentPage.value = 1;
    _dataSupplier.value = [];
  }

  /// Search data ustomer handler
  /// 
  /// This function do to handling search by input value and
  /// debonce for 500 milisecond
  /// 
  /// Usage example:
  /// ```dart
  /// TextFormField(onChanged: searchDataSupplier)
  /// ```
  void searchDataSupplier(String value) {
    if (_debonce?.isActive ?? false) _debonce!.cancel();
    _debonce = Timer(const Duration(milliseconds: 800), () {
      fetchDataSupplier(
        refresh: true,
        queryParameters: {
          "name": value
        }
      );
    });
  }

  /// Fetches Supplier data from a remote data source.
  ///
  /// The `fetchDataSupplier` function is responsible for fetching data from a remote
  /// data source. It updates several states such as [currentPage], [totalPage],
  /// [isLoading], and [dataSuppliers] to manage the pagination and loading of Supplier data.
  ///
  /// If the `refresh` parameter is set to `true`, the existing data will be cleared.
  ///
  /// Parameters:
  /// - `refresh`: A boolean value indicating whether to refresh the data.
  /// - `queryParameters`: Optional map of query parameters to be included in the request.
  ///
  /// Throws an exception if an error occurs during data fetching.
  ///
  Future<void> fetchDataSupplier({bool refresh = false, Map<String, dynamic>? queryParameters}) async {
    // Clear data if refreshing
    if (refresh) clearDataSupplier();

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

    // Fetch data using the Supplier data use case
    List<SupplierEntity> data = await fetchDataUseCaseSupplier.call(buildQueryParameters);

    // Update state with fetched data
    _dataSupplier.value.addAll(data);
    _isLoading.value = false;

    // Increment current page if data is fetched successfully
    if (data.isNotEmpty) {
      _currentPage.value = _currentPage.value + 1;
    } else {
      // Set total page if no more data is available
      _totalPage.value = _currentPage.value;
    }
  }

  /// Store Supplier data to remote data source.
  /// 
  /// The `SupplierStore` will store data to remote API and 
  /// this function will auto update current state for listing prev
  /// data Supplier
  /// 
  /// Parameters:
  /// - `paylaod`: A [SupplierPaylaod] entity while will store to remote data source.
  /// 
  /// Usage example:
  /// ```dart
  /// supplierStore(payload(/*...*/))
  /// ```
  void supplierStore(SupplierPayload paylaod) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      await storeDataUseCaseSupplier.call(paylaod);

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

  /// Delete data Supplier handling
  /// 
  /// The `SupplierDelete` will delete data from API and will remove
  /// local state list Supplier.
  /// 
  /// Parameters:
  /// - `id`: A string reprentation of uniquer identifier.
  /// 
  /// Usage example:
  /// ```dart
  /// supplierDelete(jslf293lf-32343fsaf-fsalfl3)
  /// ```
  void supplierDelete(String id) async {
    try {
      _dataSupplier.value.removeWhere((element) => element.id == id);
      await deleteDataUseCaseSupplier.call(id);

      List<SupplierEntity> currentData = _dataSupplier.value;
      _dataSupplier.value = [];
      _dataSupplier.value.addAll(currentData);

      PAMSnackBarWidget.show(
        title: "success".tr.toCapitalize(),
        message: "the Supplier has been removed successfully".tr.toCapitalize(),
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

  /// Update data Supplier handling
  void supplierUpdate(SupplierPayload paylaod) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      _dataSupplier.value.removeWhere((element) => element.id == paylaod.id);
      final SupplierEntity data = await updateDataUseCaseSupplier.call(paylaod);

      _dataSupplier.add(data);
      // back from load screen
      Get.back();

      // back from form screen
      Get.back();
    } on DioException catch (e) {
      Get.back();
      PAMSnackBarWidget.show(
        title: "failed".tr.toCapitalize(),
        message: e.response!.data["message"] ?? e.response!.data["errors"],
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
