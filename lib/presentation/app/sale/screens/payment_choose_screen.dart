import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_form_controller.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';

class PaymentChooseScreen extends GetView {
  PaymentChooseScreen({super.key});

  @override
  final controller = Get.find<SaleFormController>();

  final RxMap _chooseOptions = {"label": "", "value": ""}.obs;


  /// On Tab Handler.
  /// 
  /// This function usaged for handling data choosing and will return
  /// back to prev screen and setting to input value.
  void _onTabHandler() {
    controller.changePaymentMethod(_chooseOptions["value"]);
    /// This usage for setting input show value choosing.
    Get.back(
      result: {
        "label": _chooseOptions["label"],
        "value": _chooseOptions["value"]
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${"choose".tr} ${"payment method".tr}".toCapitalize()),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: SaleFormController.paymentMethodOptions.length,
                  itemBuilder: (context, index) {
                    return Obx(() => RadioListTile(
                      value: SaleFormController.paymentMethodOptions[index],
                      groupValue: _chooseOptions["value"],
                      title: Text(SaleFormController.paymentMethodOptions[index].toCapitalize()),
                      onChanged: (value) {
                        _chooseOptions["label"] = (value as String).toCapitalize();
                        _chooseOptions["value"] = value;
                      },
                    ));
                  },
                )
              ),
              PAMBottom(
                borderRadius: BorderRadius.circular(10),
                title: "choose".tr.toCapitalize(),
                onTab: _onTabHandler,
              )
            ],
          )
        ),
      )
    );
  }
}