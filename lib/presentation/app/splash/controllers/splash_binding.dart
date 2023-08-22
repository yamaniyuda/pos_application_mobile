import 'package:get/instance_manager.dart';
import 'package:pos_application_mobile/presentation/app/splash/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}