import 'package:get/get.dart';
import 'package:pos_application_mobile/app/config/routes/middlewares/auth_guard_middleware.dart';
import 'package:pos_application_mobile/presentation/app/account/account.dart';
import 'package:pos_application_mobile/presentation/app/color/color.dart';
import 'package:pos_application_mobile/presentation/app/customer/customer.dart';
import 'package:pos_application_mobile/presentation/app/customer_type/customer_type.dart';
import 'package:pos_application_mobile/presentation/app/home/controllers/home_binding.dart';
import 'package:pos_application_mobile/presentation/app/main/main.dart';
import 'package:pos_application_mobile/presentation/app/product/controllers/product_binding.dart';
import 'package:pos_application_mobile/presentation/app/product/screens/product_screen.dart';
import 'package:pos_application_mobile/presentation/app/report/report.dart';
import 'package:pos_application_mobile/presentation/app/splash/controllers/splash_binding.dart';
import 'package:pos_application_mobile/presentation/app/auth/auth.dart';
import 'package:pos_application_mobile/presentation/app/home/home.dart';
import 'package:pos_application_mobile/presentation/app/on_boarding/on_boarding.dart';
import 'package:pos_application_mobile/presentation/app/splash/splash.dart';
import 'package:pos_application_mobile/presentation/app/stock/controllers/stock_binding.dart';
import 'package:pos_application_mobile/presentation/app/stock/screens/stock_screen.dart';
import 'package:pos_application_mobile/presentation/app/user/user.dart';

import '../../../presentation/app/auth/controllers/auth_binding.dart';

part 'app_routes.dart';

class AppScreens {
  AppScreens._();

  static const initial = Routes.initial;

  /* List screen init */
  static List<GetPage> screens = [
    GetPage(
      name: _Paths.splash,
      page: () => SplashScreen(),
      binding: SplashBinding()
    ),

    GetPage(
      name: _Paths.onBoarding,
      page: () => OnBoardingScreen(),
      middlewares: [
        AuthGuardMiddleware()
      ]
    ),

    GetPage(
      name: _Paths.auth,
      page: () => AuthScreen(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: _Paths.home,
      page: () => const HomeScreen(),
      binding: HomeBinding()
    ),

    GetPage(
      name: _Paths.account,
      page: () => AccountScreen(),
      binding: AccountBinding(),
      transition: Transition.downToUp
    ),

    GetPage(
      name: _Paths.main,
      page: () => const MainScreen(),
      binding: MainBinding()
    ),

    GetPage(
      name: _Paths.language,
      page: () => LanguageScreen(),
    ),

    GetPage(
      name: _Paths.product,
      page: () => const ProductScreen(),
      binding: ProductBinding()
    ),

    GetPage(
      name: _Paths.report,
      page: () => const ReportScreen(),
      binding: ReportBinding()
    ),

    GetPage(
      name: _Paths.stock,
      page: () => const StockScreen(),
      binding: StockBinding()
    ),

    GetPage(
      name: _Paths.color,
      page: () => const ColorScreen(),
      binding: ColorBinding()
    ),
    GetPage(
      name: _Paths.colorForm,
      page: () => ColorFormScreen(),
      binding: ColorBinding()
    ),

    GetPage(
      name: _Paths.user, 
      page: () => const UserScreen(),
      binding: UserBinding()
    ),
    GetPage(
      name: _Paths.userForm,
      page: () => UserFormScreen(),
      binding: UserBinding()
    ),

    GetPage(
      name: _Paths.customerType,
      page: () => const CustomerTypeScreen(),
      binding: CustomerTypeBinding()
    ),
    GetPage(
      name: _Paths.customerTypeForm, 
      page: () => CustomerTypeFormScreen(),
      binding: CustomerTypeBinding()
    ),

    GetPage(
      name: _Paths.customer,
      page: () => const CustomerScreen(),
      binding: CustomerBinding()
    ),
    GetPage(
      name: _Paths.customerForm,
      page: () => CustomerFormScreen(),
      binding: CustomerBinding()
    )
  ];
}