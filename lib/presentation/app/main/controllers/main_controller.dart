import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// define child in stack screen bottom navigation bar [MainMenu]
enum ChildMenuMain {
  homeScreen, accountScreen
}

/// This controller manages the current index of the bottom
/// navigation bar, allowing you to switch between different screens.
class MainController extends GetxController {
  final RxInt _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;

  MainController({ ChildMenuMain showScreen = ChildMenuMain.homeScreen }) {
    switch (showScreen) {
      case ChildMenuMain.homeScreen:
        _changeColorBar(Get.context!, ChildMenuMain.homeScreen);
        changeTabIndex(0);
        break;
      case ChildMenuMain.accountScreen:
        changeTabIndex(1);
        break;
    }
  }

  @override
  void onInit() {
    _everInit();
    _changeColorBar(Get.context!, ChildMenuMain.homeScreen);
    super.onInit();
  }

  void _everInit() {
    ever(_currentIndex, (index) {
      /* handling status bar for home screen */
      if (index == 0) {
        _changeColorBar(Get.context!, ChildMenuMain.homeScreen);
      }

      /* handling status bar for account screen */
      if (index == 4) {
        _changeColorBar(Get.context!, ChildMenuMain.accountScreen);
      }
    });
  }

  /// this function use for change theme from
  /// status bar and bottom navigation bar
  void _changeColorBar(BuildContext context, ChildMenuMain menu) {
    late Color statusBarColor = Theme.of(context).primaryColor;
    late Brightness statusBarIconBrightness = Brightness.light;
    late Color systemNavigationBarColor = Colors.white;
    late Brightness systemNavigationBarIconBrightness = Brightness.dark;

    if (menu == ChildMenuMain.accountScreen) {
      statusBarColor = Colors.white;
      statusBarIconBrightness = Brightness.dark;
      systemNavigationBarColor = Colors.white;
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
        systemNavigationBarColor: systemNavigationBarColor,
        systemNavigationBarIconBrightness: systemNavigationBarIconBrightness
    ));
  }

  /// use for change current index from bottom
  /// navigation bar
  void changeTabIndex(int index) {
    _currentIndex.value = index;
  }
}