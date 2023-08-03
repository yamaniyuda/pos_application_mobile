// ignore_for_file: constant_identifier_names

import 'package:pos_application_mobile/app/config/localization/localization_model.dart';

class LocalizationConstant {
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  static List<LocalizationModel> languages = [
    LocalizationModel(imageUrl: "🇮🇩", languageName: "Indonesia", countryCode: "ID", languageCode: "id"),
    LocalizationModel(imageUrl: "🇺🇸", languageName: "English", countryCode: "US", languageCode: "en"),
  ];
}