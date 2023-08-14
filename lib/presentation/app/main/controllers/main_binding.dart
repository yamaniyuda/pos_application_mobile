import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/app/account/account.dart';
import 'package:pos_application_mobile/presentation/app/home/controllers/home_controller.dart';
import 'package:pos_application_mobile/presentation/app/main/controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountController());
    Get.lazyPut(() => HomeController());
    Get.put(MainController(showScreen: Get.arguments['screen']));
  }
}