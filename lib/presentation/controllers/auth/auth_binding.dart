import 'package:get/get.dart';
import 'package:pos_application_mobile/data/repositories/auth_repository_impl.dart';
import 'package:pos_application_mobile/domain/use_cases/auth/sign_in_use_case.dart';
import 'package:pos_application_mobile/presentation/controllers/auth/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInUseCase());
    Get.put(AuthController());
  }
}