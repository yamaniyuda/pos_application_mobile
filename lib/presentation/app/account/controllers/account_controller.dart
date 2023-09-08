import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/services/auth_service.dart';
import 'package:pos_application_mobile/app/utils/system_utils.dart';

class AccountController extends GetxController {
  final authService = Get.find<AuthService>();

  @override
  void onReady() {
    SystemUtils.changeStatusAndBottomBarColor(
      Get.context!,
      statusBarColor: Colors.white
    );
    super.onReady();
  }

  @override
  void onClose() {
    SystemUtils.changeStatusAndBottomBarColor(
      Get.context!,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
    );
    super.onClose();
  }
}