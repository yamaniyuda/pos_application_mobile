import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/screens/home/home.dart';
import 'package:pos_application_mobile/presentation/screens/on_boarding/on_boarding.dart';
import 'package:pos_application_mobile/presentation/screens/splash/splash.dart';

class Routes {
  /* list string navigate screen */
  static String splash = '/';
  static String home = '/home';
  static String onBoarding = '/onboarding';

  /* List screen init */
  static List<GetPage> screens = [
    GetPage(
      name: splash,
      page: () => const SplashScreen()
    ),

    GetPage(
      name: onBoarding,
      page: () => const OnBoardingScreen()
    ),

    GetPage(
      name: home,
      page: () => const HomeScreen()
    )
  ];
}