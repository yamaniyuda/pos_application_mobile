import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/account/account.dart';
import 'package:pos_application_mobile/presentation/app/home/home.dart';
import 'package:pos_application_mobile/presentation/app/main/controllers/main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.currentIndex,
            children: const [
              HomeScreen(),
              AccountScreen(),
            ],
          )
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex,
          onTap: controller.changeTabIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "home".tr.toCapitalize()
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: "account".tr.toCapitalize()
            )
          ],
        ),
      );
    });
  }
}
