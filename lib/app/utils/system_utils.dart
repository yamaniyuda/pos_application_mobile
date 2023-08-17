import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemUtils {

  /// setting color for bottom navigate and status bar
  static void changeStatusAndBottomBarColor(BuildContext context, {
    Color statusBarColor = Colors.white,
    Brightness statusBarIconBrightness = Brightness.dark,
    Color systemNavigationBarColor = Colors.white,
    Brightness systemNavigationBarIconBrightness = Brightness.dark
  }) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarIconBrightness: statusBarIconBrightness,
      systemNavigationBarColor: systemNavigationBarColor,
      systemNavigationBarIconBrightness: systemNavigationBarIconBrightness
    ));
  }
}