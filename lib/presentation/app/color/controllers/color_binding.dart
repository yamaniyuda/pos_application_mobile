import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/app/color/controllers/color_controller.dart';

class ColorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ColorController());
  }
}