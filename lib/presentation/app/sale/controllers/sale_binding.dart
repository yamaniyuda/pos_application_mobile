import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_controller.dart';

class SaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SaleController());  
  }
}