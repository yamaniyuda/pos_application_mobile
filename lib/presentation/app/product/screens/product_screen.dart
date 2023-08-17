import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/app/product/controllers/product_controller.dart';

class ProductScreen extends GetView<ProductController> {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("product".tr),
        ),
      ),
    );
  }
}
