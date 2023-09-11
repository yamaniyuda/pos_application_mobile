import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/data/payloads/cloth_image_payload.dart';
import 'package:pos_application_mobile/domain/entities/cloth_entity.dart';
import 'package:pos_application_mobile/domain/entities/cloth_image_entity.dart';
import 'package:pos_application_mobile/domain/use_cases/cloth/fetch_detail_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/cloth_image/cloth_image.dart' as ClothImageUseCase;
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_alert.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_alert/pam_snackbar.dart';

class ProductDetailController extends GetxController {

  /// Get depedency for fetch detail use case.
  final FetchDetailDataUseCase fetchDetailUseCase = Get.put(FetchDetailDataUseCase(), tag: 'fetch-detail-product-detail');

  final ClothImageUseCase.FetchDataUseCase fetchImageUseCase = Get.put(ClothImageUseCase.FetchDataUseCase(), tag: 'fech-image-product-detal');
  final ClothImageUseCase.StoreDataUseCase storeImageUseCase = Get.put(ClothImageUseCase.StoreDataUseCase(), tag: 'store-image-product-detail');

  /// State handling loading.
  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  /// Data wraping detail from cloth remote API.
  late ClothEntity dataDetail; 

  /// Data wrapping for banner.
  late RxList<ClothImageEntity> imageData = <ClothImageEntity>[].obs;

  // final ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    // _listernerScrollTableHandler();
    await fetchDetailData();
  }

  /// Fetch Detail Data.
  /// 
  /// The `fetchDetailData` will fetching detail data from remote API.
  /// and will update state `_isLoading` for do anyhing calculate for 
  /// UI screen loading mode.
  Future<void> fetchDetailData() async {
    _isLoading.value = true;
    dataDetail = await fetchDetailUseCase.call(
      Get.parameters["id"]
    );
    fetchImageData();
    _isLoading.value = false;
  }

  Future<void> fetchImageData() async {
    imageData.clear();
    imageData.addAll(
      await fetchImageUseCase.call({ "cloth_id": dataDetail.id })
    );
  }


  /// Store Image Cloth.
  /// 
  /// This method is responsible for storing images of clothing items. It takes a list
  /// of [XFile] objects representing the image files to be stored. The images are
  /// associated with a specific cloth item identified by its unique ID. 
  ///
  /// The function first displays a loading alert using `PAMAlertWidget.showLoadingAlert`
  /// and then asynchronously stores each image using the `storeImageUseCase.call` method
  /// with the associated cloth ID and image file.
  ///
  /// After successfully storing all images, it closes the loading alert and shows
  /// a success message using `PAMSnackBarWidget.show`. Finally, it fetches updated
  /// detail data using `fetchDetailData`.
  ///
  /// If any errors occur during the process, it catches them and displays an error
  /// message using `PAMSnackBarWidget.show`.
  ///
  /// Parameters:
  ///   - files: A list of [XFile] objects representing the image files to be stored.
  ///
  /// Throws:
  ///   - Exception: If an error occurs during the image storage process.
  ///
  /// Example Usage:
  /// ```dart
  /// List<XFile> imageFiles = ... // Initialize with image files
  /// await storeImageCloth(imageFiles);
  /// ```
  ///
  /// Note: Make sure to initialize `dataDetail` and ensure that required dependencies
  /// like `storeImageUseCase` and `fetchDetailData` are properly configured before
  /// calling this function.
  Future<void> storeImageCloth(List<XFile> files) async {
    try {
      PAMAlertWidget.showLoadingAlert(Get.context!);
      await Future.wait(files.map((e) {
        return storeImageUseCase.call(
          ClothImagePayload(
            clothId: dataDetail.id!, 
            image: e
          )
        );
      }));

      // handling overlay widget to close
      Get.back();
      Get.back();
      Get.back();

      PAMSnackBarWidget.show(
        title: "success".tr.toCapitalize(), 
        message: "clothing image successfully added".tr.toCapitalize(), 
        type: PAMSnackBarWidgetType.success
      );

      /// Refetch data detail after add new image to remote storage.
      await fetchDetailData();
    } catch (e) {
      PAMSnackBarWidget.show(
        title: "failed".tr.toCapitalize(), 
        message: e.toString(), 
        type: PAMSnackBarWidgetType.danger
      );
    }
  }
}