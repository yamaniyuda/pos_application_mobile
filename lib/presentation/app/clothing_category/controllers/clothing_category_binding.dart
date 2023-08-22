import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/app/clothing_category/clothing_category.dart';

class ClothingCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClothingCategoryController());
  }
}