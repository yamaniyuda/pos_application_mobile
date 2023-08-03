import 'package:flutter/material.dart';
import 'package:pos_application_mobile/presentation/app.dart';
import 'package:pos_application_mobile/app/config/localization/localization_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Map<String, String>> _language = await LocalizationService.init();
  runApp(App(language: _language));
}