import 'dart:ui';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/config/localization/localization_constant.dart';
import 'package:pos_application_mobile/app/config/localization/localization_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// Localization Controller
/// For setting language
class LocalizationController extends GetxController implements GetxService {
  final FlutterSecureStorage storage;

  LocalizationController({ required this.storage }) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(LocalizationConstant.languages[1].languageCode, LocalizationConstant.languages[1].countryCode);
  Locale get locale => _locale;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  List<LocalizationModel> _languages = [];
  List<LocalizationModel> get languages => _languages;

  void loadCurrentLanguage() async {
    final String? languageCode = await storage.read(key: LocalizationConstant.LANGUAGE_CODE);
    final String? countryCode = await storage.read(key: LocalizationConstant.COUNTRY_CODE);

    _locale = Locale(
      languageCode ?? LocalizationConstant.languages[0].languageCode,
      countryCode ?? LocalizationConstant.languages[0].countryCode
    );

    for (int index = 0; index < LocalizationConstant.languages.length; index++) {
      if (LocalizationConstant.languages[index].languageCode == _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }

    _languages = [];
    _languages.addAll(LocalizationConstant.languages);
    update();
  }

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    saveLanguage(_locale);
    update();
  }

  void saveLanguage(Locale locale) {
    storage.write(
      key: LocalizationConstant.LANGUAGE_CODE,
      value: locale.languageCode
    );

    storage.write(
      key: LocalizationConstant.COUNTRY_CODE,
      value: locale.countryCode!
    );
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    update();
  }
}