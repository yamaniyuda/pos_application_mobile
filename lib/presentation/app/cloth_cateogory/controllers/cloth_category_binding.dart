import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/app/cloth_cateogory/cloth_category.dart';

class ClothCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClothCategoryController());
  }
}