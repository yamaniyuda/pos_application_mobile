import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/booking/booking.dart';
import 'package:pos_application_mobile/presentation/app/home/home.dart';
import 'package:pos_application_mobile/presentation/app/main/controllers/main_controller.dart';
import 'package:pos_application_mobile/presentation/app/product/product.dart';
import 'package:pos_application_mobile/presentation/app/sale/screens/sale_screen.dart';
import 'package:pos_application_mobile/presentation/app/stock/screens/stock_screen.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: controller.currentIndex,
          children: [
            const HomeScreen(),
            SaleScreen(),
            const BookingScreen(),
            ProductScreen(),
            const StockScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: controller.currentIndex,
          onTap: controller.changeTabIndex,
          unselectedItemColor: Colors.black54,
          type: BottomNavigationBarType.fixed,
          unselectedLabelStyle: const TextStyle(color: Colors.black54),
          selectedItemColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.dashboard),
              label: "home".tr.toCapitalize()
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.sell),
              label: "sale".tr.toCapitalize()
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.receipt_long),
              label: "booking".tr.toCapitalize()
            ),
            BottomNavigationBarItem(
                icon: const Icon(Icons.checkroom_rounded),
                label: "product".tr.toCapitalize()
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.inventory),
              label: "stock".tr.toCapitalize()
            )
          ],
        ),
      );
    });
  }
}
