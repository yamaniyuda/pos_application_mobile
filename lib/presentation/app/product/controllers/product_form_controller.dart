// ignore_for_file: invalid_use_of_protected_member, prefer_final_fields3, library_prefixes, prefer_final_fields


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/data/payloads/cloth_color_payload.dart';
import 'package:pos_application_mobile/data/payloads/cloth_payload.dart';
import 'package:pos_application_mobile/data/payloads/cloth_price_payload.dart';
import 'package:pos_application_mobile/data/payloads/cloth_size_payload.dart';
import 'package:pos_application_mobile/domain/entities/cloth_price_type_entity.dart';
import 'package:pos_application_mobile/domain/entities/color_entity.dart';
import 'package:pos_application_mobile/domain/entities/size_entity.dart';
import 'package:pos_application_mobile/domain/use_cases/cloth/store_data_use_case.dart' as cloth;
import 'package:pos_application_mobile/domain/use_cases/cloth/add_cloth_color_use_case.dart' as clothAdd;
import 'package:pos_application_mobile/domain/use_cases/cloth/add_cloth_size_use_case.dart' as clothSize;
import 'package:pos_application_mobile/domain/use_cases/color/fetch_data_use_case.dart' as color;
import 'package:pos_application_mobile/domain/use_cases/size/fetch_data_use_case.dart' as size;
import 'package:pos_application_mobile/domain/use_cases/cloth_price_type/fetch_data_use_case.dart' as priceType;
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_alert.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_snackbar.dart';


class ProductFormController extends GetxController {

  /// ============================
  /// Get all depedency will used.
  /// ============================
  final clothSize.AddClothSizeUseCase addClothSizeUseCase = clothSize.AddClothSizeUseCase();
  final color.FetchDataUseCase fetchColor = color.FetchDataUseCase();
  final size.FetchDataUseCase fetchSize = size.FetchDataUseCase();
  final priceType.FetchDataUseCase fetchClothPriceType = priceType.FetchDataUseCase();
  final cloth.StoreDataUseCase storeClothUseCase = cloth.StoreDataUseCase();
  final clothAdd.AddClothColorUseCase addClothColorUseCase = clothAdd.AddClothColorUseCase();



  /// state for trigger all data finish to use.
  late RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  /// The list data color.
  late RxList<ColorEntity> _dataColors = <ColorEntity>[].obs;
  List<ColorEntity> get dataColors => _dataColors.value;

  /// The list data size.
  late RxList<SizeEntity> _dataSizes = <SizeEntity>[].obs;
  List<SizeEntity> get dataSizes => _dataSizes.value;

  /// The list data cloth price type.
  late RxList<ClothPriceTypeEntity> _dataClothPriceTypes = <ClothPriceTypeEntity>[].obs;
  List<ClothPriceTypeEntity> get dataClothPriceTypes => _dataClothPriceTypes.value;

  /// color choose, this state will be used to add the several forms.
  late Rx<ClothPayload> _payload = ClothPayload(clothCategoryId: "", clothColor: []).obs;
  ClothPayload get payload => _payload.value;

  /// payload for cloth color by choose.
  final RxList<ClothColorPayload> clothColorPayloads = <ClothColorPayload>[].obs;

  /// The colorChoose usually use for handling state for choosing color.
  final RxList<ColorEntity> colorChoose = <ColorEntity>[].obs;

  /// cloth size payload for looping by choose color.
  /// The map will and must string integerest to represent
  final RxMap<String, ClothSizePayload> clothSizePayloads = <String, ClothSizePayload>{}.obs;

  /// The `sizeChoose` is used to handle size choose.
  final RxList<SizeEntity> sizeChoose = <SizeEntity>[].obs;

  /// The `id` for cloth category.
  late RxString clothCategoryId = "".obs;

  /// Cloth price paylod for wrapping data price that will use in the payload later.
  final RxMap<String, ClothPricePayload> clothPricePayloads = <String, ClothPricePayload>{}.obs;

  late dynamic arguments;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    arguments = Get.arguments;
    await _fetchColor();
    await _fetchSize();
    await _fetchClothPriceType();

    /// end loading
    _isLoading.value = false;
    super.onInit();
  }


  /// Fetch Color
  ///
  /// The `_fetchColor` will do fetching data from remote data, and will do
  /// updated list [dataColors] with data respone.
  Future<void> _fetchColor() async {
    List<ColorEntity> dataResponse = await fetchColor.call();
    _dataColors.value.addAll(dataResponse);
  }


  /// Fetch Size
  ///
  /// The `_fetchSize` will do fetching data from remote data source, and will
  /// do updated list [dataSizes] with data respone.
  Future<void> _fetchSize() async {
    List<SizeEntity> dataRespone = await fetchSize.call();
    _dataSizes.value.addAll(dataRespone);
  }


  /// Fetch Cloth Price Type.
  ///
  /// The `_fetchClothPriceType` will do fetching data from remote data source, and will
  /// do updated list [dataClothPriceTypes] with replace data respone.
  Future<void> _fetchClothPriceType() async {
    List<ClothPriceTypeEntity> dataRespone = await fetchClothPriceType.call();
    _dataClothPriceTypes.value.addAll(dataRespone);
  }


  /// Cloth Color Convert.
  ///
  /// The `_clothColorConvert` will converter data list from [SOURCE] to [TARGET]
  /// related to the cloth color process.
  /// 
  /// Available mappings:
  /// - `ColorEntityy` → `ClothColorPayload`.
  /// - `ClothColorPayload` → `ColorEntity`.
  List<TARGET> _clothColorConvert<SOURCE, TARGET>(List<SOURCE> target) {
    if (target is List<ColorEntity>) {
      List<ClothColorPayload> result = List.from((target as List<ColorEntity>)
          .map((e) => ClothColorPayload(
              name: e.name!,
              clothSize: [],
              colorId: e.id!,
              sku: '',
              color: e.codeHexa ?? 'ffffff')));
      return result as List<TARGET>;
    }

    if (target is List<ClothColorPayload>) {
      List<ColorEntity> result = List.from((target as List<ClothColorPayload>)
          .map((e) =>
              ColorEntity(name: e.name, codeHexa: e.color, id: e.colorId)));
      return result as List<TARGET>;
    }

    throw Exception("wrong type");
  }


  /// Wraping Payload.
  /// 
  /// The `_wrapingPayload` function constructs a unified [ClothPayload] object by combining 
  /// [clothColorPayload], [clothSizePayload], and [clothPricePayload]. This function optimally 
  /// iterates over these payloads and organizes them into a single payload structure.
  /// 
  /// This function performs the following steps:
  /// 1. Initializes the `_payload` value with a [ClothPayload] object containing the cloth category ID and an empty cloth color list.
  /// 2. Calculates the counts for colors, sizes, and prices based on the lengths of their respective payloads.
  /// 3. Iterates through color payloads, size payloads, and price payloads, combining them into the final payload structure.
  /// 
  /// This optimized version of `_wrapingPayload` reduces redundancy and minimizes the number of iterations, making the code more efficient and readable.
  void _wrapingPayload() {
    _payload.value = ClothPayload(clothCategoryId: clothCategoryId.value, clothColor: []);

    final int colorCount = clothColorPayloads.length;
    final int sizeCount = clothSizePayloads.length ~/ colorCount;
    final int priceCount = clothPricePayloads.length ~/ (colorCount * sizeCount);

    for (var i = 0; i < colorCount; i++) {
      final ClothColorPayload colorPayload = clothColorPayloads[i];
      for (var j = 0; j < sizeCount; j++) {
        final ClothSizePayload sizePayload = clothSizePayloads["$i$j"]!;
        for (var k = 0; k < priceCount; k++) {
          sizePayload.clothPrice.add(clothPricePayloads["$i$j$k"]!);
        }
        colorPayload.clothSize.add(sizePayload);
      }
      _payload.value.clothColor.add(colorPayload);
    }
  }


  /// Update Stock Value.
  /// 
  /// The `updateStockValue` function is responsible for updating the stock value for a specific size of a cloth in the [clothSizePayloads].
  /// 
  /// Params:
  /// - `index`: The index of the cloth color.
  /// - `indexSize`: The index of the cloth size within the color.
  /// - `stock`: The new stock value to be assigned.
  /// - `sizeId`: The unique identifier for the size.
  /// 
  /// This function performs the following steps:
  /// 1. Retrieves the cloth size payload from [clothSizePayloads] using a composite key constructed from `index` and `indexSize`.
  /// 2. Updates the stock value of the retrieved cloth size payload with the provided `stock` value.
  /// 
  /// Example usage:
  /// ```dart
  /// // Update stock value for cloth color at index 1, size index 2, with stock quantity 50.
  /// updateStockValue(1, 2, 50, "size123");
  /// ```
  void updateStockValue(int index, int indexSize, int stock, String sizeId) {
    clothSizePayloads["$index$indexSize"]?.stock = stock;
  }


  /// Store Cloth.
  /// 
  /// The `storeCloth` function handles the creation and storage of cloth data to
  /// a remote API.
  /// 
  /// This function performs the following steps:
  /// 1. Wraps the payload data.
  /// 2. Displays a loading alert using `PAMAlertWidget`.
  /// 3. Calls the `storeClothUseCase` to store the cloth data by passing the [payload].
  /// 4. Navigates back from the loading screen.
  /// 5. Navigates back from the current screen with a result of "after store" after successful data storage.
  /// 6. Handles DioException if it occurs, displaying a danger-themed snack bar with the error message.
  /// 7. Handles any other exceptions, displaying a danger-themed snack bar with a generic error message, but only if the exception is not a DioException.
  /// 
  /// Throws:
  /// - DioException: If a network request using Dio fails.
  /// - Other exceptions: If any other exceptions occur during the execution, and they are not of type DioException.
  Future<void> storeCloth() async {
    try {
      _wrapingPayload();

      PAMAlertWidget.showLoadingAlert(Get.context!);
      await storeClothUseCase.call(payload);

      // back from load screen.
      Get.back();

      /// back from screen.
      Get.back(result: "after store");
    } on DioException catch (e) {
      Get.back();
      PAMSnackBarWidget.show(
        title: "failed".tr.toCapitalize(),
        message: e.response!.data["message"],
        type: PAMSnackBarWidgetType.danger
      );
    } catch (e) {
      if (e is! DioException) {
        PAMSnackBarWidget.show(
          title: "failed".tr.toCapitalize(),
          message: "failed to process data, please try again".tr.toCapitalize(),
          type: PAMSnackBarWidgetType.danger
        );
      }
    } 
  }


 /// Update Cloth Add New Color.
  /// 
  /// The `updateClothAddNewColor` function is used for handling the storage of new 
  /// cloth data to a remote storage with a unique [id] for credential verification.
  /// 
  /// This function performs the following steps:
  /// 1. Wraps the payload data.
  /// 2. Displays a loading alert using `PAMAlertWidget`.
  /// 3. Calls the `addClothColorUseCase` to add a new cloth color, passing the [id] and [payload].
  /// 4. Navigates back from the loading screen.
  /// 5. Navigates back from the current screen with a result of "after store" after successful data storage.
  /// 6. Handles DioException if it occurs, displaying a danger-themed snack bar with the error message.
  /// 7. Handles any other exceptions, displaying a danger-themed snack bar with a generic error message.
  /// 
  /// Throws:
  /// - DioException: If a network request using Dio fails.
  /// - Other exceptions: If any other exceptions occur during the execution.
  Future<void> updateClothAddNewColor() async {
    try {
      _wrapingPayload();
      PAMAlertWidget.showLoadingAlert(Get.context!);
      await addClothColorUseCase.call(
        clothAdd.AddClothColorParams(
          id: arguments["id"]!,
          payload: payload
        )
      );

      // back from load screen.2
      Get.back();

      /// back from screen.
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


  /// Update Cloth Add New Size.
  /// 
  /// The `updateClothAddNewSize` will handling for update data cloth to
  /// remote data source. And will show notification [Snackbar] after finish
  /// do post data to remote API or failed data processing.
  /// 
  /// ```dart
  /// await updateClothAddNewSize();
  /// ```
  Future<void> updateClothAddNewSize() async {
    try {
      _wrapingPayload();

      PAMAlertWidget.showLoadingAlert(Get.context!);
      await addClothSizeUseCase.call(
        clothSize.AddClothSizeUseCaseParams(
          id: arguments["id"]!,
          colorId: arguments["cloth_color_id"]!,
          payload: payload.clothColor[0]
        )
      );

      // back from load screen.
      Get.back();

      /// back from screen.
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


  /// Update Cloth Color.
  ///
  /// The `updateClothColor` will handling for update [colorChoose] and [clothColorPayloads].
  ///
  /// Usage:
  /// ```dart
  /// updateClothColor([
  ///   ColorEntity(/*...*/),
  ///   ColorEntity(/*...*/)
  /// ])
  /// ```
  void updateClothColor(List<ColorEntity> colorEntities) {
    List<ClothColorPayload> clothColorPayload = _clothColorConvert<ColorEntity, ClothColorPayload>(colorEntities);

    // choose hanling
    colorChoose.clear();
    colorChoose.addAll([...colorEntities]);

    // payload handling
    for (var element in clothColorPayload) {
      if (clothColorPayloads.contains(element)) continue;

      if (!clothColorPayloads.value.contains(element)) {
        clothColorPayloads.add(element);
        continue;
      }
    }

    clothColorPayloads.removeWhere((element) => !clothColorPayload.contains(element));

    final copySizeChoose = List<SizeEntity>.from(
      sizeChoose.asMap().entries.map((e) => sizeChoose[e.key])
    );
    
    _payload.value.clothColor.clear();
    _payload.value.clothColor.addAll(clothColorPayload);

    // generate cloth size after update color.
    updateClothSize(copySizeChoose);
  }


  /// Update Cloth Price Type.
  /// 
  /// The `updateClothPriceType` do add cloth price payload with dummy data.
  /// This function will generate empety data in [clothPricePayloads] which will be
  /// used for form when saved state.
  void updateClothPriceType() {
    clothPricePayloads.clear();
    for (var i = 0; i < clothColorPayloads.length; i++) {
      for (var j = 0; j < sizeChoose.length; j++) {
        for (var k = 0; k < _dataClothPriceTypes.value.length; k++) {
          clothPricePayloads["$i$j$k"] = ClothPricePayload(
            clothPriceTypeId: _dataClothPriceTypes.value[k].id!,
            price: 0,
          );
        }
      }
    }
  }


  /// Update Cloth Size.
  ///
  /// The `updateClothSize`  will handling for update [sizeChoose] and [clothSizePayloads].
  ///
  /// Usage:
  /// ```dart
  /// updateClothSize([
  ///   SizeEntity(/*...*/),
  ///   SizeEntity(/*...*/)
  /// ])
  /// ```
  void updateClothSize(List<SizeEntity> sizeEntities) {
    sizeChoose.value.clear();
    sizeChoose.value.addAll([...sizeEntities]);
    clothSizePayloads.clear();

    for (var i = 0; i < clothColorPayloads.length; i++) {
      for (var j = 0; j < sizeChoose.length; j++) {
        clothSizePayloads["$i$j"] = ClothSizePayload(
          clothPrice: [], 
          name: sizeChoose[j].name!, 
          sizeId: sizeChoose[j].id!
        );
      }
    }

    // generate cloth price each size.
    updateClothPriceType();
  }
}
