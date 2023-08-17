import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/app/report/controllers/report_controller.dart';

class ReportScreen extends GetView<ReportController> {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("report".tr),
        ),
      ),
    );
  }
}