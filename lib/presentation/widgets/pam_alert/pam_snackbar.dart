import 'package:get/get.dart';
import 'package:flutter/material.dart';

enum PAMSnackBarWidgetType {
  notification,
  success,
  danger
}

class PAMSnackBarWidget {
  static show({ required String title, required String message, required PAMSnackBarWidgetType type }) {
    late Icon icon;

    if (type == PAMSnackBarWidgetType.success) {
      icon = const Icon(Icons.check, color: Color(0xff56D5A8));
    } else if (type == PAMSnackBarWidgetType.danger) {
      icon = const Icon(Icons.close, color: Color(0xFFff0505));
    }

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      icon: icon
    );
  }
}