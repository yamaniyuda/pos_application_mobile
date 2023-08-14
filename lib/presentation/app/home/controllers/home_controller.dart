import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/services/auth_service.dart';

class HomeController extends GetxController {
  final authService = Get.find<AuthService>();

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  final Rx<double> _scrollControllerOffset = 0.0.obs;
  double get scrollControllerOffset => _scrollControllerOffset.value;

  Rx<double> _colorFadeOpacity = 0.0.obs;
  double get colorFadeOpacity => _colorFadeOpacity.value;

  @override
  void onInit() {
    _scrollController.addListener(_scrollListener);
    super.onInit();
  }

  _scrollListener() {
    _scrollControllerOffset.value = _scrollController.offset;
    _colorFadeOpacity = (_scrollControllerOffset.value > 200 ? 1.0 : 0.0).obs;
  }
}