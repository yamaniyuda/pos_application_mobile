import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingScreen extends GetView {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("booking".tr),
        ),
      ),
    );
  }
}