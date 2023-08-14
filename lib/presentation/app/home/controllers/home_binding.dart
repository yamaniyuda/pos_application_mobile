import 'package:get/get.dart';
import 'package:pos_application_mobile/app/services/auth_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService());
  }
}