import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/app/cloth_price_type/controller/cloth_price_type_controller.dart';

class ClothPriceTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClothPriceTypeController());
  }
}