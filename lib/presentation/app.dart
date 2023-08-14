import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_application_mobile/app/config/localization/localization_controller.dart';
import 'package:pos_application_mobile/app/config/routes/app_screens.dart';
import 'package:pos_application_mobile/app/config/theme/theme_config.dart';
import 'package:pos_application_mobile/app/utils/messages.dart';

class App extends StatefulWidget {
  final Map<String, Map<String, String>> language;
  const App({Key? key, required this.language}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (LocalizationController localizationController) {
      return GetMaterialApp(
        initialRoute: AppScreens.initial,
        debugShowCheckedModeBanner: false,
        getPages: AppScreens.screens,
        theme: ThemeConfig.themeData(),
        locale: localizationController.locale,
        translations: Messages(language: widget.language),
      );
    });
  }
}