import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/app/customer_type/controllers/customer_type_controller.dart';

class CustomerTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CustomerTypeController());
  }
}