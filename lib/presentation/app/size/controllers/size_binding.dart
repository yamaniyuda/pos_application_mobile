import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/app/size/size.dart';

class SizeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SizeController());
  }
}