import 'package:get/get.dart';
import 'package:pos_application_mobile/domain/use_cases/cloth/fetch_data_use_case.dart';
import 'package:pos_application_mobile/domain/use_cases/cloth/store_data_use_case.dart';
import 'package:pos_application_mobile/presentation/app/product/controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FetchDataUseCase());
    Get.put(StoreDataUseCase());
    Get.put(ProductController());
  }
}