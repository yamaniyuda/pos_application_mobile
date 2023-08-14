import 'package:flutter/material.dart';
import 'package:pos_application_mobile/app/services/auth_service.dart';
import 'package:pos_application_mobile/presentation/app.dart';
import 'package:pos_application_mobile/app/config/localization/localization_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

void main() async {
  /* binding widgets flutter */
  WidgetsFlutterBinding.ensureInitialized();

  /* load file env */
  await dotenv.load(fileName: ".env");

  /* configuration locale */
  Map<String, Map<String, String>> language = await LocalizationService.init();

  await initService();

  /* run app */
  runApp(App(language: language));
}

/// register all service to init for apps
Future<void> initService() async {
  await Get.putAsync(() => AuthService().init());
}