import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_form_controller.dart';
import 'package:pos_application_mobile/presentation/app/sale/screens/payment_choose_screen.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';

class PaymentMethodWidget extends GetView {
  PaymentMethodWidget({super.key});

  @override
  final controller = Get.find<SaleFormController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PAMFormTextFieldWidget(
          screen: PaymentChooseScreen(),
          decoration: const BoxDecoration(),
          inputDecoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            isDense: true,
            border: const OutlineInputBorder(),
            filled: true,
            labelText: "${"payment".tr} ${"method".tr}".toCapitalize(),
            alignLabelWithHint: false,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            fillColor: Colors.black.withOpacity(.05)
          ),
          // onSaved: (p0) => controller.clothCategoryId.value = p0!,
        ),

        Obx(() {
          if (controller.paymentMethod == "down payment") {
            return Container(
              margin: const EdgeInsets.only(top: 10),
              child: PAMFormTextFieldWidget(
                decoration: const BoxDecoration(),
                inputDecoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  isDense: true,
                  border: const OutlineInputBorder(),
                  filled: true,
                  labelText: "nommin".toCapitalize(),
                  alignLabelWithHint: false,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  fillColor: Colors.black.withOpacity(.05)
                ),
                // onSaved: (p0) => controller.clothCategoryId.value = p0!,
              ),
            );
          } 

          return Container();
        },)
      ],
    );
  } 
}