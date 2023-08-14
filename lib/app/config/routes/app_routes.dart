part of 'app_screens.dart';

abstract class Routes {
  Routes._();

  static const initial = _Paths.splash;
  static const home = _Paths.home;
  static const onBoarding = _Paths.onBoarding;
  static const auth = _Paths.auth;
  static const account = _Paths.account;
  static const main = _Paths.main;
  static const language = _Paths.language;
}

abstract class _Paths {
  static const String splash = '/';
  static const String home = '/home';
  static const String onBoarding = '/onboarding';
  static const String auth = '/auth';
  static const String account = '/account';
  static const String main = '/main';
  static const String language = '/language';
}