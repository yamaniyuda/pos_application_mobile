// ignore_for_file: invalid_use_of_protected_member

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/data/payloads/user_payload.dart';
import 'package:pos_application_mobile/domain/entities/user_entity.dart';
import 'package:pos_application_mobile/domain/use_cases/user/delete_data_use_case.dart';
import 'dart:async';

import 'package:pos_application_mobile/domain/use_cases/user/fetch_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/user/store_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/user/update_data_use_case.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_alert.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_snackbar.dart';

/// Controller responsible for managing user-related operations.
class UserController extends GetxController {
  /// Fetch data use case instance for user data.
  final FetchDataUseCase fetchDataUseCaseUser = Get.put(FetchDataUseCase());

  /// Store data use case instance for user data.
  final StoreDataUseCase storeDataUseCaseUser = Get.put(StoreDataUseCase());

  /// Delete data use  case instance for user data.
  final DeleteDataUseCase deleteDataUseCaseUser = Get.put(DeleteDataUseCase());

  /// Update data use case instance for user data.
  final UpdateDataUseCase updateDataUseCaseUser = Get.put(UpdateDataUseCase());

  /// List of fetched user data.
  final RxList<UserEntity> _dataUser = <UserEntity>[].obs;
  List<UserEntity> get dataUser => _dataUser.value;

  /// Loading indicator state.
  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  /// User current state for pagination
  final Rx<int> _currentPage = 1.obs;
  int get currentPage => _currentPage.value;

  /// user total pagination state
  final Rx<int> _totalPage =  0.obs;
  int get totalPage => _totalPage.value;

  /// Timer for handle debonce search user
  Timer? _debonce;

  @override
  void onInit() {
    fetchDataUser();
    super.onInit();
  }

  @override
  void onClose() {
    _debonce?.cancel();
    super.onClose();
  }

  /// do clear data user
  void clearDataUser() {
    _totalPage.value = 0;
    _currentPage.value = 1;
    _dataUser.value = [];
  }

  /// Search data user handler
  /// 
  /// This function do to handling search by input value and
  /// debonce for 500 milisecond
  /// 
  /// Usage example:
  /// ```dart
  /// TextFormField(onChanged: searchDatauser)
  /// ```
  void searchDataUser(String value) {
    if (_debonce?.isActive ?? false) _debonce!.cancel();
    _debonce = Timer(const Duration(milliseconds: 800), () {
      fetchDataUser(
        refresh: true,
        queryParameters: {
          "name": value
        }
      );
    });
  }

  /// Fetches User data from a remote data source.
  ///
  /// The `fetchDataUser` function is responsible for fetching data from a remote
  /// data source. It updates several states such as [currentPage], [totalPage],
  /// [isLoading], and [datausers] to manage the pagination and loading of user data.
  ///
  /// If the `refresh` parameter is set to `true`, the existing data will be cleared.
  ///
  /// Parameters:
  /// - `refresh`: A boolean value indicating whether to refresh the data.
  /// - `queryParameters`: Optional map of query parameters to be included in the request.
  ///
  /// Throws an exception if an error occurs during data fetching.
  ///
  Future<void> fetchDataUser({bool refresh = false, Map<String, dynamic>? queryParameters}) async {
    // Clear data if refreshing
    if (refresh) clearDataUser();

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

    // Fetch data using the user data use case
    List<UserEntity> data = await fetchDataUseCaseUser.call(buildQueryParameters);

    // Update state with fetched data
    _dataUser.value.addAll(data);
    _isLoading.value = false;

    // Increment current page if data is fetched successfully
    if (data.isNotEmpty) {
      _currentPage.value = _currentPage.value + 1;
    } else {
      // Set total page if no more data is available
      _totalPage.value = _currentPage.value;
    }
  }

  /// Store user data to remote data source.
  /// 
  /// The `userStore` will store data to remote API and 
  /// this function will auto update current state for listing prev
  /// data user
  /// 
  /// Parameters:
  /// - `paylaod`: A [UserPaylaod] entity while will store to remote data source.
  /// 
  /// Usage example:
  /// ```dart
  /// userStore(payload(/*...*/))
  /// ```
  void userStore(UserPaylaod paylaod) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      await storeDataUseCaseUser.call(paylaod);

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

  /// Delete data user handling
  /// 
  /// The `userDelete` will delete data from API and will remove
  /// local state list user.
  /// 
  /// Parameters:
  /// - `id`: A string reprentation of uniquer identifier.
  /// 
  /// Usage example:
  /// ```dart
  /// userDelete(jslf293lf-32343fsaf-fsalfl3)
  /// ```
  void userDelete(String id) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      _dataUser.value.removeWhere((element) => element.id == id);
      await deleteDataUseCaseUser.call(id);

      List<UserEntity> currentData = _dataUser.value;
      _dataUser.value = [];
      _dataUser.value.addAll(currentData);

      // remove dialog
      Get.back();

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

      // remove  dialog
      Get.back();
    }
  }

  /// Update data user handling
  void userUpdate(UserPaylaod paylaod) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      _dataUser.value.removeWhere((element) => element.id == paylaod.id);
      final UserEntity data = await updateDataUseCaseUser.call(paylaod);

      _dataUser.add(data);
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
