import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum PAMBottomSheetType {
  success, danger
}

class PAMBottomSheet {
  static showBottomSheet({
    required String title,
    required String desc,
    required PAMBottomSheetType type
  }) {
    Get.bottomSheet(
      Text(title)
    );
  }
}