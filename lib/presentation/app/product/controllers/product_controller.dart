// ignore_for_file: invalid_use_of_protected_member

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/services/auth_service.dart';
import 'package:pos_application_mobile/data/payloads/cloth_payload.dart';
import 'package:pos_application_mobile/domain/entities/cloth_entity.dart';
import 'package:pos_application_mobile/domain/use_cases/cloth/delete_data_use_case.dart';
import 'dart:async';

import 'package:pos_application_mobile/domain/use_cases/cloth/fetch_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/cloth/store_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/cloth/update_data_use_case.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_alert.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_snackbar.dart';

/// Controller responsible for managing -related operations.
class ProductController extends GetxController with GetSingleTickerProviderStateMixin {
  /// Get depedency from auth service
  final AuthService authService = Get.find<AuthService>();

  /// Fetch data use case instance for  data.
  final FetchDataUseCase fetchDataUseCase = Get.put(FetchDataUseCase(), tag: 'product-fetch-data-use-case');

  /// Store data use case instance for  data.
  final StoreDataUseCase storeDataUseCase = Get.put(StoreDataUseCase(), tag: 'product-store-data-use-case');

  /// Delete data use case instance for  data.
  final DeleteDataUseCase deleteDataUseCase = Get.put(DeleteDataUseCase(), tag: 'product-delete-data-use-case');

  /// Update data use case instance for  data.
  final UpdateDataUseCase updateDataUseCase = Get.put(UpdateDataUseCase(), tag: 'product-update-data-use-case');

  /// List of fetched data.
  final RxList<ClothEntity> _data = <ClothEntity>[].obs;
  List<ClothEntity> get data => _data.value;

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

  /// tab controller for tab in screen
  late TabController _tabController;
  TabController get tabController => _tabController;

  @override
  void onInit() {
    fetchData();
    _showSupperAccess.value = [AuthService.OWNER].contains(
      authService.userEntity?.role
    );
    _tabController = TabController(length: 2, vsync: this);
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

  /// Search data ustomer handler
  /// 
  /// This function do to handling search by input value and
  /// debonce for 500 milisecond
  /// 
  /// Usage example:
  /// ```dart
  /// TextFormField(onChanged: searchData)
  /// ```
  void searchData(String value) {
    if (_debonce?.isActive ?? false) _debonce!.cancel();
    _debonce = Timer(const Duration(milliseconds: 800), () {
      fetchData(
        refresh: true,
        queryParameters: {
          "name": value
        }
      );
    });
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

    // Fetch data using the  data use case
    List<ClothEntity> data = await fetchDataUseCase.call(buildQueryParameters);

    // Update state with fetched data

    print(data);
    _data.value.addAll(data);
    _isLoading.value = false;

    // Increment current page if data is fetched successfully
    if (data.isNotEmpty) {
      _currentPage.value = _currentPage.value + 1;
    } else {
      // Set total page if no more data is available
      _totalPage.value = _currentPage.value;
    }
  }

  /// Store data to remote data source.
  /// 
  /// The `storeData` will store data to remote API and 
  /// this function will auto update current state for listing prev
  /// data 
  /// 
  /// Parameters:
  /// - `paylaod`: A [ClothPayload] entity while will store to remote data source.
  /// 
  /// Usage example:
  /// ```dart
  /// storeData(payload(/*...*/))
  /// ```
  void storeData(ClothPayload paylaod) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      await storeDataUseCase.call(paylaod);

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

  /// Delete data handling
  /// 
  /// The `deleteData` will delete data from API and will remove
  /// local state list .
  /// 
  /// Parameters:
  /// - `id`: A string reprentation of uniquer identifier.
  /// 
  /// Usage example:
  /// ```dart
  /// deleteData(jslf293lf-32343fsaf-fsalfl3)
  /// ```
  void deleteData(String id) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      _data.value.removeWhere((element) => element.id == id);
      await deleteDataUseCase.call(id);

      List<ClothEntity> currentData = _data.value;
      _data.value = [];
      _data.value.addAll(currentData);

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

  /// Update data cloth price type handling
  /// 
  /// The `update Data` will update data from remote API and
  /// do refresh to current data and push new data will call `fetchData`.
  /// 
  /// Parameters:
  /// - `payload`: A [ClothPayload] payload to update data.
  /// 
  /// 
  /// Usage example:
  /// ```dart
  /// updateData(ClothPayload(/*...*/))
  /// ```
  void updateData(ClothPayload paylaod) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      _data.value.removeWhere((element) => element.id == paylaod.id);
      await updateDataUseCase.call(paylaod);
      await fetchData(refresh: true);
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
