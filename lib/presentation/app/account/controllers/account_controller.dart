import 'package:get/get.dart';
import 'package:pos_application_mobile/app/services/auth_service.dart';

class AccountController extends GetxController {
  final authService = Get.find<AuthService>();

  @override
  void onReady() {
    super.onReady();
  }
}