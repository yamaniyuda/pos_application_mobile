import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/data/payloads/sign_in_payload.dart';
import 'package:pos_application_mobile/domain/use_cases/auth/sign_in_use_case.dart';

class AuthController extends GetxController with GetSingleTickerProviderStateMixin, StateMixin {
  final signInUseCase = Get.find<SignInUseCase>();
  late TabController tabController;
  late RxBool isLogin;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 1, vsync: this);
    isLogin = false.obs;
  }

  Future<void> signIn(SignInPayload payload) async {
    try {
      change(null, status: RxStatus.loading());
      final bool response = await signInUseCase.call(payload);

      if (!response) throw Error();

      isLogin.value = response;
      change(null, status: RxStatus.success());
    } on DioException catch (e) {
      isLogin.value = false;
      change(null, status: RxStatus.error(e.response?.data["message"]));
    } catch (e, f) {
      isLogin.value = false;
      print(e);
      print(f);
      change(null, status: RxStatus.error("an error occurred please try again".tr));
    } finally {
      isLogin.refresh();
    }
  }
}