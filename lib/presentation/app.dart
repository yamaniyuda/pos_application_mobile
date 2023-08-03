import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_application_mobile/app/config/localization/localization_controller.dart';
import 'package:pos_application_mobile/app/config/routes/routes.dart';
import 'package:pos_application_mobile/app/utils/messages.dart';
import 'package:pos_application_mobile/presentation/screens/splash/splash.dart';

class App extends StatelessWidget {
  final Map<String, Map<String, String>> language;
  const App({Key? key, required this.language}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (LocalizationController localizationController) {
      return GetMaterialApp(
        initialRoute: "/",
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        getPages: Routes.screens,
        locale: localizationController.locale,
        translations: Messages(language: language),
      );
    });
  }
}
