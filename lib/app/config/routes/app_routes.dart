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
  static const customerType = _Paths.customerType;
  static const customerTypeForm = _Paths.customerTypeForm;
  static const customer = _Paths.customer;
  static const customerForm = _Paths.customerForm;
  static const size = _Paths.size;
  static const sizeForm = _Paths.sizeForm;
  static const clothCategory = _Paths.clothCategory;
  static const clothCategoryForm = _Paths.clothCategoryForm;
  static const supplier = _Paths.supplier;
  static const supplierForm = _Paths.supplierForm;
  static const clothPriceType = _Paths.clothPriceType;
  static const clothPriceTypeForm = _Paths.clothPriceTypeForm;
  static const productForm = _Paths.productForm;
  static const productDetail = _Paths.productDetail;
  static const sale = _Paths.sale;
  static const saleForm = _Paths.saleForm;
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
  static const String customerType = '/customer-type';
  static const String customerTypeForm = '/customer-type-form';
  static const String customer = '/customer';
  static const String customerForm = '/customer-form';
  static const String size = '/size';
  static const String sizeForm = '/size-form';
  static const String clothCategory = '/cloth-category';
  static const String clothCategoryForm = '/cloth-category-form';
  static const String supplier = '/supplier';
  static const String supplierForm = '/supplier-form';
  static const String clothPriceType = '/cloth-price-type';
  static const String clothPriceTypeForm = '/cloth-price-type-form';
  static const String productForm = '/product-form';
  static const String productDetail = '/product-detail/:id';
  static const String sale = '/sale';
  static const String saleForm = '/sale-form';
}