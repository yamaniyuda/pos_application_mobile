// ignore_for_file: invalid_use_of_protected_member

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/services/auth_service.dart';
import 'package:pos_application_mobile/data/payloads/customer_payload.dart';
import 'package:pos_application_mobile/domain/entities/customer_entity.dart';
import 'package:pos_application_mobile/domain/use_cases/customer/delete_data_use_case.dart';
import 'dart:async';

import 'package:pos_application_mobile/domain/use_cases/customer/fetch_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/customer/store_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/customer/update_data_use_case.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_alert.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_snackbar.dart';

/// Controller responsible for managing Customer-related operations.
class CustomerController extends GetxController {
  /// Get depedency from auth service
  final AuthService authService = Get.find<AuthService>();

  /// Fetch data use case instance for Customer data.
  final FetchDataUseCase fetchDataUseCaseCustomer = Get.put(FetchDataUseCase());

  /// Store data use case instance for Customer data.
  final StoreDataUseCase storeDataUseCaseCustomer = Get.put(StoreDataUseCase());

  /// Delete data use  case instance for Customer data.
  final DeleteDataUseCase deleteDataUseCaseCustomer = Get.put(DeleteDataUseCase());

  /// Update data use case instance for Customer data.
  final UpdateDataUseCase updateDataUseCaseCustomer = Get.put(UpdateDataUseCase());

  /// List of fetched Customer data.
  final RxList<CustomerEntity> _dataCustomer = <CustomerEntity>[].obs;
  List<CustomerEntity> get dataCustomer => _dataCustomer.value;

  /// Loading indicator state.
  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  /// Customer current state for pagination
  final Rx<int> _currentPage = 1.obs;
  int get currentPage => _currentPage.value;

  /// Customer total pagination state
  final Rx<int> _totalPage =  0.obs;
  int get totalPage => _totalPage.value;

  /// Timer for handle debonce search Customer
  Timer? _debonce;

  /// show crud access
  final Rx<bool> _showSupperAccess = false.obs;
  bool get showSuperAccess => _showSupperAccess.value;

  @override
  void onInit() {
    fetchDataCustomer();
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

  /// do clear data Customer
  void clearDataCustomer() {
    _totalPage.value = 0;
    _currentPage.value = 1;
    _dataCustomer.value = [];
  }

  /// Search data ustomer handler
  /// 
  /// This function do to handling search by input value and
  /// debonce for 500 milisecond
  /// 
  /// Usage example:
  /// ```dart
  /// TextFormField(onChanged: searchDataCustomer)
  /// ```
  void searchDataCustomer(String value) {
    if (_debonce?.isActive ?? false) _debonce!.cancel();
    _debonce = Timer(const Duration(milliseconds: 800), () {
      fetchDataCustomer(
        refresh: true,
        queryParameters: {
          "name": value
        }
      );
    });
  }

  /// Fetches Customer data from a remote data source.
  ///
  /// The `fetchDataCustomer` function is responsible for fetching data from a remote
  /// data source. It updates several states such as [currentPage], [totalPage],
  /// [isLoading], and [dataCustomers] to manage the pagination and loading of Customer data.
  ///
  /// If the `refresh` parameter is set to `true`, the existing data will be cleared.
  ///
  /// Parameters:
  /// - `refresh`: A boolean value indicating whether to refresh the data.
  /// - `queryParameters`: Optional map of query parameters to be included in the request.
  ///
  /// Throws an exception if an error occurs during data fetching.
  ///
  Future<void> fetchDataCustomer({bool refresh = false, Map<String, dynamic>? queryParameters}) async {
    // Clear data if refreshing
    if (refresh) clearDataCustomer();

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

    // Fetch data using the Customer data use case
    List<CustomerEntity> data = await fetchDataUseCaseCustomer.call(buildQueryParameters);

    // Update state with fetched data
    _dataCustomer.value.addAll(data);
    _isLoading.value = false;

    // Increment current page if data is fetched successfully
    if (data.isNotEmpty) {
      _currentPage.value = _currentPage.value + 1;
    } else {
      // Set total page if no more data is available
      _totalPage.value = _currentPage.value;
    }
  }

  /// Store Customer data to remote data source.
  /// 
  /// The `CustomerStore` will store data to remote API and 
  /// this function will auto update current state for listing prev
  /// data Customer
  /// 
  /// Parameters:
  /// - `paylaod`: A [CustomerPaylaod] entity while will store to remote data source.
  /// 
  /// Usage example:
  /// ```dart
  /// CustomerStore(payload(/*...*/))
  /// ```
  void customerStore(CustomerPayload paylaod) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      await storeDataUseCaseCustomer.call(paylaod);

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

  /// Delete data Customer handling
  /// 
  /// The `CustomerDelete` will delete data from API and will remove
  /// local state list Customer.
  /// 
  /// Parameters:
  /// - `id`: A string reprentation of uniquer identifier.
  /// 
  /// Usage example:
  /// ```dart
  /// CustomerDelete(jslf293lf-32343fsaf-fsalfl3)
  /// ```
  void customerDelete(String id) async {
    try {
      _dataCustomer.value.removeWhere((element) => element.id == id);
      await deleteDataUseCaseCustomer.call(id);

      List<CustomerEntity> currentData = _dataCustomer.value;
      _dataCustomer.value = [];
      _dataCustomer.value.addAll(currentData);

      PAMSnackBarWidget.show(
        title: "success".tr.toCapitalize(),
        message: "the customer has been removed successfully".tr.toCapitalize(),
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

  /// Update data customer handling
  void customerUpdate(CustomerPayload paylaod) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      _dataCustomer.value.removeWhere((element) => element.id == paylaod.id);
      final CustomerEntity data = await updateDataUseCaseCustomer.call(paylaod);

      _dataCustomer.add(data);
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
