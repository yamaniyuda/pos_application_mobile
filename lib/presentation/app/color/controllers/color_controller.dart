// ignore_for_file: invalid_use_of_protected_member

import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/data/payloads/color_payload.dart';
import 'package:pos_application_mobile/domain/entities/color_entity.dart';
import 'package:pos_application_mobile/domain/use_cases/color/delete_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/color/fetch_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/color/store_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/color/update_data_use_case.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_alert.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_snackbar.dart';

/// Controller responsible for managing color-related operations.
class ColorController extends GetxController {
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

  @override
  void onInit() {
    fetchDataColor();
    super.onInit();
  }

  /// Sets the color selected in the color picker.
  void setColorPicker(Color color) {
    _colorPicker.value = color;
  }

  /// Fetches color data.
  Future<void> fetchDataColor() async {
    if (_currentPage.value == _totalPage.value) return;
    
    final Map<String, dynamic> queryParameter = {
      "order": "name",
      "ascending": 1,
      "page": _currentPage.value
    };

    _isLoading.value = true;
    List<ColorEntity> data = await fetchDataUseCaseColor.call(queryParameter);
    _dataColors.value.addAll(data);
    _isLoading.value = false;

    if (data.isNotEmpty) {
      _currentPage.value = _currentPage.value + 1;
    } else {
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
              codeHexa: _colorPicker.value.value.toRadixString(16).substring(2)));
      Get.back();
    } catch (e) {
      if (e is! DioException) {
        PAMSnackBarWidget.show(
            title: "failed",
            message: "gagal memproses data, silahkan coba lagi".tr.toCapitalize(),
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
    _dataColors.value.removeWhere((element) => element.id == id);
    await deleteDataUseCase.call(id);
    update(['color_list']);
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
            title: "failed",
            message: "gagal memproses data, silahkan coba lagi".tr.toCapitalize(),
            type: PAMSnackBarWidgetType.danger);
      }
    } finally {
      Get.back();
    }
  }
}
