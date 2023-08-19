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
  static const product = _Paths.product;
  static const report = _Paths.report;
  static const stock = _Paths.stock;
  static const color = _Paths.color;
  static const colorForm = _Paths.colorForm;
  static const user = _Paths.user;
  static const userForm = _Paths.userForm;
}

abstract class _Paths {
  static const String splash = '/';
  static const String home = '/home';
  static const String onBoarding = '/onboarding';
  static const String auth = '/auth';
  static const String account = '/account';
  static const String main = '/main';
  static const String language = '/language';
  static const String product = '/product';
  static const String report = '/report';
  static const String stock = '/stock';
  static const String color = '/color';
  static const String colorForm = '/color-form';
  static const String user = '/user';
  static const String userForm = '/user-form';
}