import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pos_application_mobile/app/config/localization/localization_constant.dart';
import 'package:pos_application_mobile/app/config/localization/localization_controller.dart';
import 'package:pos_application_mobile/app/config/localization/localization_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class LocalizationService {

  /// Do initial language from json arb file
  ///
  /// Returns Map<String, String> language
  static Future<Map<String, Map<String, String>>> init() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    Get.lazyPut(() => storage);
    Get.lazyPut(() => LocalizationController(storage: Get.find()));
    Map<String, Map<String, String>> language = {};

    /* do while to file arb */
    for (LocalizationModel model in LocalizationConstant.languages) {
      String jsonStringValue = await rootBundle.loadString("assets/localization/app_localization_${model.languageCode}.json");
      Map<String, dynamic> mappedJson = json.decode(jsonStringValue);

      Map<String, String> jsonLanguage = {};
      mappedJson.forEach((key, value) {
        jsonLanguage[key] = value.toString();
      });

      language["${model.languageCode}_${model.countryCode}"] = jsonLanguage;
    }

    return language;
  }
}