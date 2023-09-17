import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/app/account/account.dart';
import 'package:pos_application_mobile/presentation/app/booking/booking.dart';
import 'package:pos_application_mobile/presentation/app/home/controllers/home_controller.dart';
import 'package:pos_application_mobile/presentation/app/main/controllers/main_controller.dart';
import 'package:pos_application_mobile/presentation/app/product/product.dart';
import 'package:pos_application_mobile/presentation/app/sale/sale.dart';
import 'package:pos_application_mobile/presentation/app/stock/controllers/stock_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SaleController());
    Get.lazyPut(() => BookingController());
    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => StockController());
    Get.put(MainController(showScreen: Get.arguments['screen']));
  }
}