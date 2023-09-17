import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/config/routes/app_screens.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_controller.dart';

class SaleScreen extends GetView<SaleController> {
  const SaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'floating-acction-button-sale',
        onPressed: () => Get.toNamed(Routes.saleForm),
        backgroundColor: Theme.of(Get.context!).primaryColor,
        child: const Icon(Icons.add),
      ),
    ); 
  }
}