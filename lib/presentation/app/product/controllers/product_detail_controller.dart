import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/domain/entities/cloth_entity.dart';
import 'package:pos_application_mobile/domain/use_cases/cloth/fetch_detail_use_case.dart';

class ProductDetailController extends GetxController {

  /// Get depedency for fetch detail use case.
  final FetchDetailDataUseCase fetchDetailUseCase = Get.put(FetchDetailDataUseCase(), tag: 'fetch-detail-product-detail');

  /// State handling loading.
  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  /// Data wraping detail from cloth remote API.
  late ClothEntity dataDetail; 

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    // _listernerScrollTableHandler();
    await fetchDetailData();
  }

  // void _listernerScrollTableHandler() {
  //   scrollController.addListener(() {
  //     scrollController.jumpTo(
  //       scrollController.offset
  //     );
  //   });
  // }

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
    _isLoading.value = false;
  }
}