import 'package:get/get.dart';
import 'package:pos_application_mobile/app/config/routes/middlewares/auth_guard_middleware.dart';
import 'package:pos_application_mobile/presentation/app/account/account.dart';
import 'package:pos_application_mobile/presentation/app/cloth_cateogory/cloth_category.dart';
import 'package:pos_application_mobile/presentation/app/cloth_price_type/cloth_price_type.dart';
import 'package:pos_application_mobile/presentation/app/color/color.dart';
import 'package:pos_application_mobile/presentation/app/customer/customer.dart';
import 'package:pos_application_mobile/presentation/app/customer_type/customer_type.dart';
import 'package:pos_application_mobile/presentation/app/home/home.dart';
import 'package:pos_application_mobile/presentation/app/main/main.dart';
import 'package:pos_application_mobile/presentation/app/product/controllers/product_detail_controller.dart';
import 'package:pos_application_mobile/presentation/app/product/product.dart';
import 'package:pos_application_mobile/presentation/app/product/screens/product_detail_screen.dart';
import 'package:pos_application_mobile/presentation/app/report/report.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_form_controller.dart';
import 'package:pos_application_mobile/presentation/app/sale/sale.dart';
import 'package:pos_application_mobile/presentation/app/sale/screens/sale_form_screen.dart';
import 'package:pos_application_mobile/presentation/app/size/size.dart';
import 'package:pos_application_mobile/presentation/app/auth/auth.dart';
import 'package:pos_application_mobile/presentation/app/on_boarding/on_boarding.dart';
import 'package:pos_application_mobile/presentation/app/splash/splash.dart';
import 'package:pos_application_mobile/presentation/app/stock/stock.dart';
import 'package:pos_application_mobile/presentation/app/supplier/supplier.dart';
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
      page: () => const SplashScreen(),
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
      page: () => ProductScreen(),
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



    /// ======================
    /// Color Screen
    /// ======================
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



    /// ======================
    /// User Screen
    /// ======================
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



    /// ======================
    /// Customer Type Screen
    /// ======================
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



    /// ======================
    /// Customer Screen
    /// ======================
    GetPage(
      name: _Paths.customer,
      page: () => const CustomerScreen(),
      binding: CustomerBinding()
    ),
    GetPage(
      name: _Paths.customerForm,
      page: () => CustomerFormScreen(),
      binding: CustomerBinding()
    ),



    /// ======================
    /// Size Screen
    /// ======================
    GetPage(
      name: _Paths.size,
      page: () => const SizeScreen(),
      binding: SizeBinding()
    ),
    GetPage(
      name: _Paths.sizeForm,
      page: () => SizeFormScreen(),
      binding: SizeBinding()
    ),



    /// ======================
    /// Cloth Category Screen
    /// ======================
    GetPage(
      name: _Paths.clothCategory,
      page: () => const ClothCategoryScreen(),
      binding: ClothCategoryBinding()
    ),
    GetPage(
      name: _Paths.clothCategoryForm,
      page: () => ClothCategoryFormScreen(),
      binding: ClothCategoryBinding()
    ),



    /// ======================
    /// Supplier Screen
    /// ======================
    GetPage(
      name: _Paths.supplier,
      page: () => const SupplierScreen(),
      binding: SupplierBinding()
    ),
    GetPage(
      name: _Paths.supplierForm,
      page: () => SupplierFormScreen(),
      binding: SupplierBinding()
    ),



    /// ======================
    /// Cloth Price Type Screen
    /// ======================
    GetPage(
      name: _Paths.clothPriceType,
      page: () => const ClothPriceTypeScreen(),
      binding: ClothPriceTypeBinding()
    ),
    GetPage(
      name: _Paths.clothPriceTypeForm,
      page: () => ClothPriceTypeFormScreen(),
      binding: ClothPriceTypeBinding()
    ),
    


    /// =====================
    /// Product Screen
    /// =====================
    GetPage(
      name: _Paths.productForm,
      page: () => ProductFormScreen(),
      binding: BindingsBuilder(() {
        Get.put(ProductFormController());
      })
    ),
    GetPage(
      name: _Paths.productDetail,
      page: () => const ProductDetailScreen(),
      binding: BindingsBuilder(() {
        Get.put(ProductDetailController());
      })
    ),


    /// =====================
    /// Sale Screen
    /// =====================
    GetPage(
      name: _Paths.sale,
      page: () => SaleScreen(),
      binding: SaleBinding()
    ),
    GetPage(
      name: _Paths.saleForm,
      page: () => SaleFormScreen(),
      binding: BindingsBuilder(() {
        Get.put(SaleFormController());
        Get.put(CustomerChooseController());
      })
    ),
    GetPage(
      name: _Paths.saleDetail,
      page: () => const SaleDetailScreen(),
      binding: BindingsBuilder(() {
        Get.put(SaleDetailController());
      })
    )

  ];
}