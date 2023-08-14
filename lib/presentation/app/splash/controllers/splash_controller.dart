import 'package:get/get.dart';
import 'package:pos_application_mobile/app/config/routes/app_screens.dart';
import 'package:pos_application_mobile/app/services/auth_service.dart';
import 'package:pos_application_mobile/presentation/app/main/main.dart';

class SplashController extends GetxController {
  final AuthService authService = Get.find<AuthService>();

  @override
  void onReady() async {
    super.onReady();
    print("on ready  spalsh");
    print(authService.rememberMe);
    if (authService.rememberMe) {
      Get.offAllNamed(Routes.main, arguments: { "screen": ChildMenuMain.homeScreen });
    } else {
      Get.offAllNamed(Routes.onBoarding);
    }
  }
}