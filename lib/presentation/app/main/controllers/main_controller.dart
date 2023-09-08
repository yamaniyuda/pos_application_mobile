import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/utils/system_utils.dart';

/// define child in stack screen bottom navigation bar [MainMenu]
enum ChildMenuMain {
  homeScreen, accountScreen, productScreen
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
      case ChildMenuMain.productScreen:
        changeTabIndex(3);
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

      if (index == 3) {
        _changeColorBar(Get.context!, ChildMenuMain.productScreen);
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
    late Color statusBarColor = Colors.transparent;
    late Brightness statusBarIconBrightness = Brightness.light;
    late Color systemNavigationBarColor = Colors.white;
    late Brightness systemNavigationBarIconBrightness = Brightness.dark;

    if (menu == ChildMenuMain.accountScreen) {
      statusBarColor = Colors.transparent;
      statusBarIconBrightness = Brightness.dark;
      systemNavigationBarColor = Colors.white;
    }

    if (menu == ChildMenuMain.productScreen) {
      statusBarColor = Colors.white;
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
    SystemUtils.changeStatusAndBottomBarColor(Get.context!,
      statusBarColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark
    );
    _currentIndex.value = index;
  }
}