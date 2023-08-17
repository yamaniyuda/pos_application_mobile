import 'package:flutter/material.dart';
import 'package:pos_application_mobile/app/services/auth_service.dart';
import 'package:pos_application_mobile/presentation/app.dart';
import 'package:pos_application_mobile/app/config/localization/localization_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

/// The main entry point of the application.
///
/// This function initializes various services and configurations before running the app.
/// It performs the following steps:
/// 1. Ensures Flutter widgets are properly initialized.
/// 2. Loads environment variables from the ".env" file.
/// 3. Initializes the app's localization resources.
/// 4. Initializes application services using the [initService] function.
/// 5. Runs the [App] widget to start the application.
void main() async {
  // Ensure Flutter widgets are initialized
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // preserving the native splash  untikk the init app finished
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Load environment variables from ".env" file
  await dotenv.load(fileName: ".env");

  // Initialize localization resources
  Map<String, Map<String, String>> language = await LocalizationService.init();

  // Initialize services and run the app
  await initService();

  FlutterNativeSplash.remove();
  runApp(App(language: language));
}

/// Initializes application services.
///
/// This asynchronous function initializes various services needed for the application.
/// In this case, it uses [AuthService] to initialize authentication-related services.
///
/// Usage example:
/// ```dart
/// await initService();
/// ```
Future<void> initService() async {
  // Initialize AuthService asynchronously and register it using Get.putAsync
  await Get.putAsync(() => AuthService().init());
}
