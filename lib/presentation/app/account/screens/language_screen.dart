import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/config/localization/localization_constant.dart';
import 'package:pos_application_mobile/app/config/localization/localization_model.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/utils/system_utils.dart';

class LanguageScreen extends StatefulWidget {

  LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final List<LocalizationModel> languages = LocalizationConstant.languages;

  void _changeLanguageHandler(String countryCode, String languageCode) {
    Get.updateLocale(
      Locale(languageCode, countryCode)
    );
    Get.back();
  }

  @override
  void dispose() {
    SystemUtils.changeStatusAndBottomBarColor(context,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    SystemUtils.changeStatusAndBottomBarColor(context,
      statusBarColor: Theme.of(context).primaryColor,
      statusBarIconBrightness: Brightness.light
    );

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