import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/services/auth_service.dart';
import 'package:pos_application_mobile/app/utils/system_utils.dart';
import 'package:pos_application_mobile/data/payloads/sign_in_payload.dart';
import 'package:pos_application_mobile/domain/use_cases/auth/sign_in_use_case.dart';

class AuthController extends GetxController with GetSingleTickerProviderStateMixin {
  final signInUseCase = Get.find<SignInUseCase>();
  final authService = Get.find<AuthService>();
  late TabController tabController;
  Rx<bool> isLogin = false.obs;

  /* form */
  RxString username = "".obs;
  RxString password = "".obs;
  RxBool rememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
    SystemUtils.changeStatusAndBottomBarColor(
      Get.context!,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark
    );
    tabController = TabController(length: 1, vsync: this);
  }

  Future<void> signIn(SignInPayload payload) async {
    await authService.signIn(payload, rememberMe: rememberMe.value);
  }
}