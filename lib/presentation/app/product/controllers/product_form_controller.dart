// ignore_for_file: invalid_use_of_protected_member, prefer_final_fields3, library_prefixes
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
  final RxList<RxList<ClothSizePayload>> clothSizePayloads = [<ClothSizePayload>[].obs].obs;

  /// The `sizeChoose` is used to handle size choose.
  final RxList<SizeEntity> sizeChoose = <SizeEntity>[].obs;

  /// The `id` for cloth category.
  late RxString clothCategoryId = "".obs;

  /// Cloth price paylod for wrapping data price that will use in the payload later.
  final RxList<RxList<RxList<ClothPricePayload>>> clothPricePayloads = RxList<RxList<RxList<ClothPricePayload>>>.empty(growable: true);

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
              sku: '0',
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
  /// The `_wrapingPayload` is function for build [clothColorPayload], [clothSizePayload], 
  /// and [clothPricePayload] to one payload.
  /// 
  /// 
  void _wrapingPayload() {
    _payload.value = ClothPayload(clothCategoryId: clothCategoryId.value, clothColor: []);

    /// build cloth price type inside to cloth size.
    payload.clothColor.addAll(
      clothColorPayloads.value.asMap().entries.map(
        (i) {
          i.value.clothSize.clear();
          i.value.clothSize.addAll(
            clothSizePayloads[i.key].asMap().entries.map(
              (j) {
                j.value.clothPrice.clear();
                j.value.clothPrice.addAll(
                  clothPricePayloads[i.key][j.key]
                );
                return j.value;
              }
            )
          );
          return i.value;
        }
      )
    );
  }


  /// Store Cloth
  ///
  /// The `storeCloth` will handle the creating of data to
  /// remote api.
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
    updateClothSize(copySizeChoose);
  }


  /// Update Cloth Price Type.
  /// 
  /// The `updateClothPriceType` do add cloth price payload with dummy data.
  /// This function will generate empety data in [clothPricePayloads] which will be
  /// used for form when saved state.
  void updateClothPriceType() {
    final RxList<RxList<RxList<ClothPricePayload>>> generate = RxList<RxList<RxList<ClothPricePayload>>>.generate(
      clothColorPayloads.length,
      (i) => RxList<RxList<ClothPricePayload>>.generate(
        clothSizePayloads[i].length,
        (j) => RxList<ClothPricePayload>.generate(
          _dataClothPriceTypes.value.length,
          (k) => ClothPricePayload(
            clothPriceTypeId: _dataClothPriceTypes.value[k].id!,
            price: 0,
          ),
        ),
      ),
    );

    clothPricePayloads.value = generate;
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
    List<ClothSizePayload> payloads = List.from(sizeEntities
        .map((e) => ClothSizePayload(clothPrice: [], name: e.name!, sizeId: e.id!)));

    // cloth size choose handling
    sizeChoose.value.clear();
    sizeChoose.value.addAll([...sizeEntities]);

    // payload handling
    clothSizePayloads.clear();
    clothSizePayloads.addAll(List.generate(clothColorPayloads.length, (index) {
      return payloads.obs;
    }));

    // generate cloth price each size.
    updateClothPriceType();
  }
}
