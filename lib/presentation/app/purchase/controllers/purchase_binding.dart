import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/app/purchase/controllers/purchase_controller.dart';

class PurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PurchaseController());
  }
}