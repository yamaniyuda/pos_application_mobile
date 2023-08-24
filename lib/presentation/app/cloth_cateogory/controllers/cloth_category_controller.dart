// ignore_for_file: invalid_use_of_protected_member

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/services/auth_service.dart';
import 'package:pos_application_mobile/data/payloads/cloth_category_payload.dart';
import 'package:pos_application_mobile/domain/entities/cloth_category_entity.dart';
import 'package:pos_application_mobile/domain/use_cases/cloth_category/delete_data_use_case.dart';
import 'dart:async';

import 'package:pos_application_mobile/domain/use_cases/cloth_category/fetch_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/cloth_category/store_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/cloth_category/update_data_use_case.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_alert.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_snackbar.dart';

/// Controller responsible for managing ClothCategory related operations.
class ClothCategoryController extends GetxController {
  /// Get depedency from auth service
  final AuthService authService = Get.find<AuthService>();

  /// Fetch data use case instance for ClothCategory data.
  final FetchDataUseCase fetchDataUseCaseClothCategory = Get.put(FetchDataUseCase());

  /// Store data use case instance for ClothCategory data.
  final StoreDataUseCase storeDataUseCaseClothCategory = Get.put(StoreDataUseCase());

  /// Delete data use  case instance for ClothCategory data.
  final DeleteDataUseCase deleteDataUseCaseClothCategory = Get.put(DeleteDataUseCase());

  /// Update data use case instance for ClothCategory data.
  final UpdateDataUseCase updateDataUseCaseClothCategory = Get.put(UpdateDataUseCase());

  /// List of fetched ClothCategory data.
  final RxList<ClothCategoryEntity> _dataClothCategory = <ClothCategoryEntity>[].obs;
  List<ClothCategoryEntity> get dataClothCategory => _dataClothCategory.value;

  /// Loading indicator state.
  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  /// ClothCategory current state for pagination
  final Rx<int> _currentPage = 1.obs;
  int get currentPage => _currentPage.value;

  /// ClothCategory total pagination state
  final Rx<int> _totalPage =  0.obs;
  int get totalPage => _totalPage.value;

  /// Timer for handle debonce search ClothCategory
  Timer? _debonce;

  /// show crud access
  final Rx<bool> _showSupperAccess = false.obs;
  bool get showSuperAccess => _showSupperAccess.value;

  @override
  void onInit() {
    fetchdataClothCategory();
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

  /// do clear data ClothCategory
  void cleardataClothCategory() {
    _totalPage.value = 0;
    _currentPage.value = 1;
    _dataClothCategory.value = [];
  }

  /// Search data ClothCategory handler
  /// 
  /// This function do to handling search by input value and
  /// debonce for 500 milisecond
  /// 
  /// Usage example:
  /// ```dart
  /// TextFormField(onChanged: searchdataClothCategory)
  /// ```
  void searchdataClothCategory(String value) {
    if (_debonce?.isActive ?? false) _debonce!.cancel();
    _debonce = Timer(const Duration(milliseconds: 800), () {
      fetchdataClothCategory(
        refresh: true,
        queryParameters: {
          "name": value
        }
      );
    });
  }

  /// Fetches ClothCategory data from a remote data source.
  ///
  /// The `fetchdataClothCategory` function is responsible for fetching data from a remote
  /// data source. It updates several states such as [currentPage], [totalPage],
  /// [isLoading], and [dataClothCategorys] to manage the pagination and loading of ClothCategory data.
  ///
  /// If the `refresh` parameter is set to `true`, the existing data will be cleared.
  ///
  /// Parameters:
  /// - `refresh`: A boolean value indicating whether to refresh the data.
  /// - `queryParameters`: Optional map of query parameters to be included in the request.
  ///
  /// Throws an exception if an error occurs during data fetching.
  ///
  Future<void> fetchdataClothCategory({bool refresh = false, Map<String, dynamic>? queryParameters}) async {
    // Clear data if refreshing
    if (refresh) cleardataClothCategory();

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

    // Fetch data using the ClothCategory data use case
    List<ClothCategoryEntity> data = await fetchDataUseCaseClothCategory.call(buildQueryParameters);

    // Update state with fetched data
    _dataClothCategory.value.addAll(data);
    _isLoading.value = false;

    // Increment current page if data is fetched successfully
    if (data.isNotEmpty) {
      _currentPage.value = _currentPage.value + 1;
    } else {
      // Set total page if no more data is available
      _totalPage.value = _currentPage.value;
    }
  }

  /// Store ClothCategory data to remote data source.
  /// 
  /// The `clothCategoryStore` will store data to remote API and 
  /// this function will auto update current state for listing prev
  /// data ClothCategory
  /// 
  /// Parameters:
  /// - `paylaod`: A [ClothCategoryPaylaod] entity while will store to remote data source.
  /// 
  /// Usage example:
  /// ```dart
  /// clothCategoryStore(payload(/*...*/))
  /// ```
  void clothCategoryStore(ClothCategoryPayload paylaod) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      await storeDataUseCaseClothCategory.call(paylaod);

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

  /// Delete data ClothCategory handling
  /// 
  /// The `clothCategoryDelete` will delete data from API and will remove
  /// local state list ClothCategory.
  /// 
  /// Parameters:
  /// - `id`: A string reprentation of uniquer identifier.
  /// 
  /// Usage example:
  /// ```dart
  /// clothCategoryDelete(jslf293lf-32343fsaf-fsalfl3)
  /// ```
  void clothCategoryDelete(String id) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      _dataClothCategory.value.removeWhere((element) => element.id == id);
      await deleteDataUseCaseClothCategory.call(id);

      List<ClothCategoryEntity> currentData = _dataClothCategory.value;
      _dataClothCategory.value = [];
      _dataClothCategory.value.addAll(currentData);

      // remove dialog
      Get.back();

      PAMSnackBarWidget.show(
        title: "success".tr.toCapitalize(),
        message: "the ClothCategory has been removed successfully".tr.toCapitalize(),
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

  /// Update data ClothCategory handling
  void clothCategoryUpdate(ClothCategoryPayload paylaod) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      _dataClothCategory.value.removeWhere((element) => element.id == paylaod.id);
      await updateDataUseCaseClothCategory.call(paylaod);
      await fetchdataClothCategory(refresh: true);

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
