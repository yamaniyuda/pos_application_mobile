import 'package:get/get.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AccountBinding());
  }
}