import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/app/account/account.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AccountController());
  }
}