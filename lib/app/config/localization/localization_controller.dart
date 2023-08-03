import 'dart:ui';

import 'package:get/get.dart';
import 'package:pos_application_mobile/app/config/localization/localization_constant.dart';
import 'package:pos_application_mobile/app/config/localization/localization_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// Localization Controller
/// For setting language
class LocalizationController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  LocalizationController({ required this.sharedPreferences }) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(LocalizationConstant.languages[0].languageCode, LocalizationConstant.languages[0].countryCode);
  Locale get locale => _locale;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  List<LocalizationModel> _languages = [];
  List<LocalizationModel> get languages => _languages;

  void loadCurrentLanguage() {
    final String? languageCode = sharedPreferences.getString(LocalizationConstant.LANGUAGE_CODE);
    final String? countryCode = sharedPreferences.getString(LocalizationConstant.COUNTRY_CODE);

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
    sharedPreferences.setString(
      LocalizationConstant.LANGUAGE_CODE,
      locale.languageCode
    );

    sharedPreferences.setString(
      LocalizationConstant.COUNTRY_CODE,
      locale.countryCode!
    );
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    update();
  }
}