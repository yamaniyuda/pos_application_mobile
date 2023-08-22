// ignore_for_file: invalid_use_of_protected_member

import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/services/auth_service.dart';
import 'package:pos_application_mobile/data/payloads/color_payload.dart';
import 'package:pos_application_mobile/domain/entities/color_entity.dart';
import 'dart:async';
import 'package:pos_application_mobile/domain/use_cases/color/delete_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/color/fetch_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/color/store_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/color/update_data_use_case.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_alert.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_snackbar.dart';

/// Controller responsible for managing color-related operations.
class ColorController extends GetxController {
   /// Get depedency from auth service
  final AuthService authService = Get.find<AuthService>();
  
  /// Fetch data use case instance for color data.
  final FetchDataUseCase fetchDataUseCaseColor = Get.put(FetchDataUseCase());

  /// Store data use case instance for color data.
  final StoreDataUseCase storeDataUseCaseColor = Get.put(StoreDataUseCase());

  /// Delete data use  case instance for color data.
  final DeleteDataUseCase deleteDataUseCase = Get.put(DeleteDataUseCase());

  /// Update data use case instance for color data.
  final UpdateDataUseCase updateDataUseCase = Get.put(UpdateDataUseCase());

  /// List of fetched color data.
  final RxList<ColorEntity> _dataColors = <ColorEntity>[].obs;
  List<ColorEntity> get dataColors => _dataColors.value;

  /// The color selected in the color picker.
  final Rx<Color> _colorPicker = const Color(0x0ff0f0f0).obs;
  Color get colorPicker => _colorPicker.value;

  /// Color name for new color addition.
  final Rx<String> _colorName = ''.obs;
  String get colorName => _colorName.value;
  set setColorName(String colorName) => _colorName.value = colorName;

  /// Color description for new color addition.
  final Rx<String> _colorDescription = ''.obs;
  String get colorDescription => _colorDescription.value;
  set setColorDescription(String colorDescription) =>
      _colorDescription.value = colorDescription;

  /// Loading indicator state.
  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  /// Color current state for pagination
  final Rx<int> _currentPage = 1.obs;
  int get currentPage => _currentPage.value;

  /// Color total pagination state
  final Rx<int> _totalPage =  0.obs;
  int get totalPage => _totalPage.value;

  /// Timer for handle debonce search color
  Timer? _debonce;

  /// show crud access
  final Rx<bool> _showSupperAccess = false.obs;
  bool get showSuperAccess => _showSupperAccess.value;

  @override
  void onInit() {
    fetchDataColor();
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

  /// Sets the color selected in the color picker.
  void setColorPicker(Color color) {
    _colorPicker.value = color;
  }

  /// do clear data color
  void clearDataColor() {
    _totalPage.value = 0;
    _currentPage.value = 1;
    _dataColors.value = [];
  }

  /// Search data color handler
  /// 
  /// This function do to handling search by input value and
  /// debonce for 500 milisecond
  /// 
  /// Usage example:
  /// ```dart
  /// TextFormField(onChanged: searchDataColor)
  /// ```
  void searchDataColor(String value) {
    if (_debonce?.isActive ?? false) _debonce!.cancel();
    _debonce = Timer(const Duration(milliseconds: 800), () {
      fetchDataColor(
        refresh: true,
        queryParameters: {
          "name": value
        }
      );
    });
  }

  /// Fetches color data from a remote data source.
  ///
  /// The `fetchDataColor` function is responsible for fetching data from a remote
  /// data source. It updates several states such as [currentPage], [totalPage],
  /// [isLoading], and [dataColors] to manage the pagination and loading of color data.
  ///
  /// If the `refresh` parameter is set to `true`, the existing data will be cleared.
  ///
  /// Parameters:
  /// - `refresh`: A boolean value indicating whether to refresh the data.
  /// - `queryParameters`: Optional map of query parameters to be included in the request.
  ///
  /// Throws an exception if an error occurs during data fetching.
  ///
  Future<void> fetchDataColor({bool refresh = false, Map<String, dynamic>? queryParameters}) async {
    // Clear data if refreshing
    if (refresh) clearDataColor();

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

    // Fetch data using the color data use case
    List<ColorEntity> data = await fetchDataUseCaseColor.call(buildQueryParameters);

    // Update state with fetched data
    _dataColors.value.addAll(data);
    _isLoading.value = false;

    // Increment current page if data is fetched successfully
    if (data.isNotEmpty) {
      _currentPage.value = _currentPage.value + 1;
    } else {
      // Set total page if no more data is available
      _totalPage.value = _currentPage.value;
    }
  }

  /// Stores a new color.
  void colorStore() async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      await storeDataUseCaseColor.call(
        ColorPayload(
          name: _colorName.value,
          description: _colorDescription.value,
          codeHexa: _colorPicker.value.value.toRadixString(16).substring(2)
        )
      );
      Get.back();
    } catch (e) {
      if (e is! DioException) {
        PAMSnackBarWidget.show(
            title: "failed".tr.toCapitalize(),
            message: "failed to process data, please try again".tr.toCapitalize(),
            type: PAMSnackBarWidgetType.danger);
      }
    } finally {
      Get.back(result: "after store");
    }
  }

  /// Delete data color handling
  /// 
  /// This function required [id] is paramas
  void colorDelete(String id) async {
    try {
      _dataColors.value.removeWhere((element) => element.id == id);
      await deleteDataUseCase.call(id);

      List<ColorEntity> currentData = _dataColors.value;
      _dataColors.value = [];
      _dataColors.value.addAll(currentData);

      PAMSnackBarWidget.show(
        title: "success".tr.toCapitalize(),
        message: "the user has been removed successfully".tr.toCapitalize(),
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

  /// Update data color handling
  void colorUpdate(String id) async {
    try {
      final ColorPayload payload = ColorPayload(
        name: _colorName.value, 
        codeHexa: _colorPicker.value.value.toRadixString(16).substring(2),
        description: _colorDescription.value,
        id: id
      );

      PAMAlertWidget.showLoadingAlert(Get.context!);
      _dataColors.value.removeWhere((element) => element.id == payload.id);
      final ColorEntity data = await updateDataUseCase.call(payload);

      _dataColors.add(data);
      Get.back();
    } catch (e) {
      if (e is! DioException) {
        PAMSnackBarWidget.show(
          title: "failed".tr.toCapitalize(),
          message: "failed to process data, please try again".tr.toCapitalize(),
          type: PAMSnackBarWidgetType.danger
        );
      }
    } finally {
      Get.back();
    }
  }
}
