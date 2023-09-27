import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/customer_choose_controller.dart';

class CustomerChooseItem extends StatelessWidget {
  CustomerChooseItem({
    super.key,
    required this.index,
  });

  final int index;
  final controller = Get.find<CustomerChooseController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => RadioListTile(
          groupValue: controller.chooseValue,
          title: Text(controller.dataCustomerType[index].name!),
          value: controller.dataCustomerType[index].id,
          onChanged: (value) => controller.changeRadioSection(
            controller.dataCustomerType[index].id!,
            controller.dataCustomerType[index].name!
          )
        )),
      ],
    );
  }
}