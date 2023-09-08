// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemUtils {
  /// Changes the status bar and bottom navigation bar colors in the app.
  ///
  /// This function allows you to customize the appearance of the status bar and
  /// the navigation bar at the bottom of the screen.
  ///
  /// Parameters:
  ///   - [context]: The `BuildContext` of the current widget.
  ///   - [statusBarColor]: The color of the status bar. Defaults to white.
  ///   - [statusBarIconBrightness]: The brightness of the status bar icons (e.g., time and battery indicators).
  ///     Defaults to [Brightness.dark], which is suitable for dark status bars.
  ///   - [systemNavigationBarColor]: The color of the system navigation bar (e.g., Android's navigation buttons).
  ///     Defaults to white.
  ///   - [systemNavigationBarIconBrightness]: The brightness of the system navigation bar icons (e.g., back and home buttons).
  ///     Defaults to [Brightness.dark], which is suitable for dark navigation bars.
  ///
  /// Example usage:
  /// ```dart
  /// changeStatusAndBottomBarColor(context,
  ///   statusBarColor: Colors.blue,
  ///   statusBarIconBrightness: Brightness.light,
  ///   systemNavigationBarColor: Colors.blue,
  ///   systemNavigationBarIconBrightness: Brightness.light,
  /// );
  /// ```
  static void changeStatusAndBottomBarColor(BuildContext context,
      {Color statusBarColor = Colors.white,
      Brightness statusBarIconBrightness = Brightness.dark,
      Color systemNavigationBarColor = Colors.white,
      Brightness systemNavigationBarIconBrightness = Brightness.dark}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarIconBrightness: statusBarIconBrightness,
      systemNavigationBarColor: systemNavigationBarColor,
      systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
    ));
  }
  

  /// Validator Message.
  ///
  /// The `validatorMessage` function checks if the [value] parameter is empty or null.
  /// If [value] is a String and is empty, it returns the [message] as an error message.
  /// If [value] is null, it also returns the [message] as an error message.
  /// Otherwise, it returns null, indicating that there are no validation errors.
  ///
  /// Parameters:
  ///   - [value]: The value to be validated.
  ///   - [message]: The error message to be returned if validation fails.
  ///
  /// Returns:
  ///   - A [String] error message if validation fails; otherwise, it returns null.
  static String? validatorMessage<T>(T value, String message) {
    if (value is String) {
      if (value.isEmpty)
        return message;
      else
        return null;
    }

    if (value == null) return message;
    return null;
  }
}
