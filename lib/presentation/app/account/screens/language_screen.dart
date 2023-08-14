import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/config/localization/localization_constant.dart';
import 'package:pos_application_mobile/app/config/localization/localization_model.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';

class LanguageScreen extends StatelessWidget {
  final List<LocalizationModel> languages = LocalizationConstant.languages;

  LanguageScreen({super.key});

  void _changeLanguageHandler(String countryCode, String languageCode) {
    Get.updateLocale(
      Locale(languageCode, countryCode)
    );
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "choose your choose".tr.toCapitalize()
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: languages.length,
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: index == (languages.length - 1)
                    ? Colors.transparent
                    : Theme.of(context).primaryColorDark
                )
              )
            ),
            child: ListTile(
              onTap: () => _changeLanguageHandler(
                languages[index].countryCode,
                languages[index].languageCode
              ),
              leading: const Icon(Icons.language),
              title: Text(languages[index].languageName)
            ),
          )
        )
      ),
    );
  }
}