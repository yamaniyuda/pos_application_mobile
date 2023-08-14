import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:flutter/material.dart';

class PAMAlertWidget {
  static showLoadingAlert(BuildContext context) {
    return Get.defaultDialog(
      title: "processed data".tr.toCapitalize(),
      titlePadding: const EdgeInsets.only(top: 40),
      barrierDismissible: false,
      content: LoadingAnimationWidget.waveDots(
        color: Theme.of(context).primaryColor,
        size: 50
      ),
    );
  }
}