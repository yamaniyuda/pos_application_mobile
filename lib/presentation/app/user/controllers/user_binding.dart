import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/app/user/controllers/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
  }
}