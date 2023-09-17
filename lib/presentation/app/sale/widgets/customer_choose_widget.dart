import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_form_controller.dart';
import 'package:pos_application_mobile/presentation/app/sale/screens/customer_choose_screen.dart';
import 'package:pos_application_mobile/presentation/app/sale/screens/customer_search_screen.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';

class CustomerChooseWidget extends StatelessWidget {
  CustomerChooseWidget({super.key});

  final controller = Get.put(SaleFormController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PAMFormTextFieldWidget(
          screen: CustomerChooseScreen(),
          decoration: const BoxDecoration(),
          inputDecoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            isDense: true,
            border: const OutlineInputBorder(),
            filled: true,
            labelText: "${"search".tr} ${"customer type".tr}".toCapitalize(),
            alignLabelWithHint: false,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            fillColor: Colors.black.withOpacity(.05)
          ),
          // onSaved: (p0) => controller.customerTypePayload = p0!,
        ),

        Obx(() {
          if (!controller.isShowInputChooseCustomer(controller.customerTypePayload["label"] ?? "")) {
            return Container();
          }
          return Container(
            margin: const EdgeInsets.only(top: 10),
              child: PAMFormTextFieldWidget(
              decoration: const BoxDecoration(),
              screen: CustomerSearchScreen(),
              inputDecoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                isDense: true,
                border: const OutlineInputBorder(),
                filled: true,
                labelText: "${"search".tr} ${"customer".tr}".toCapitalize(),
                alignLabelWithHint: false,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                fillColor: Colors.black.withOpacity(.05)
              ),
            ),
          );
        }),

        const Divider(
          color: Colors.black54,
          height: 40,
        )
      ],
    );
  } 
}
