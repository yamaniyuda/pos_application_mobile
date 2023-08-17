import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pos_application_mobile/app/config/localization/localization_constant.dart';
import 'package:pos_application_mobile/app/config/localization/localization_controller.dart';
import 'package:pos_application_mobile/app/config/localization/localization_model.dart';
import 'package:get/get.dart';

class LocalizationService {
  /// Initializes localization data and resources.
  ///
  /// This static method initializes the localization resources by loading
  /// JSON localization files for each supported language from the assets.
  ///
  /// The localization data is returned as a map where the keys are language
  /// codes combined with country codes (e.g., "en_US") and the values are maps
  /// containing key-value pairs for localized strings.
  ///
  /// The method performs the following steps:
  /// 1. Initializes FlutterSecureStorage for secure storage.
  /// 2. Initializes the LocalizationController using the storage instance.
  /// 3. Loads localization JSON files for each supported language.
  /// 4. Parses the JSON content and creates localized string maps.
  /// 5. Constructs the final language map with keys in the format "languageCode_countryCode".
  ///
  /// Returns:
  /// A map containing localized strings for each supported language, with keys
  /// in the format "languageCode_countryCode" (e.g., "en_US").
  ///
  /// Usage example:
  /// ```dart
  /// Map<String, Map<String, String>> localizationData = await LocalizationController.init();
  /// ```
  static Future<Map<String, Map<String, String>>> init() async {
    // Initialize secure storage
    const FlutterSecureStorage storage = FlutterSecureStorage();
    Get.lazyPut(() => storage);

    // Initialize LocalizationController using storage
    Get.lazyPut(() => LocalizationController(storage: Get.find()));

    // Initialize the map to store language data
    Map<String, Map<String, String>> language = {};

    // Iterate over supported languages and load localization files
    for (LocalizationModel model in LocalizationConstant.languages) {
      // Load JSON content from localization file
      String jsonStringValue = await rootBundle.loadString("assets/localization/app_localization_${model.languageCode}.json");
      Map<String, dynamic> mappedJson = json.decode(jsonStringValue);

      // Convert dynamic JSON data to localized string map
      Map<String, String> jsonLanguage = {};
      mappedJson.forEach((key, value) {
        jsonLanguage[key] = value.toString();
      });

      // Add localized string map to the language map
      language["${model.languageCode}_${model.countryCode}"] = jsonLanguage;
    }

    // Return the final language map
    return language;
  }
}
