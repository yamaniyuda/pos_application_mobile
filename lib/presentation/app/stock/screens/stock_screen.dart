import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/app/stock/controllers/stock_controller.dart';

class StockScreen extends GetView<StockController> {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("stock".tr),
        ),
      ),
    );
  }
}