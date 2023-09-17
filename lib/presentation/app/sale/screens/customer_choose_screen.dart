import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/customer_choose_controller.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_form_controller.dart';
import 'package:pos_application_mobile/presentation/app/sale/widgets/customer_choose_item.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';

class CustomerChooseScreen extends StatelessWidget {
  CustomerChooseScreen({super.key});

  final controller = Get.put(CustomerChooseController());
  final saleFormController = Get.find<SaleFormController>();

  
  /// On Tab Handler.
  /// 
  /// This function is responsible for handling choose `customer category`
  /// and will do back with return data.
  /// 
  /// data: 
  /// - `value`: The value that will later be sent in the payload.
  /// - `label`: The value that will later be show in form input.
  void _onTabHandler () {
    saleFormController.changeCustomerTypePayload(
      controller.chooseValue,
      controller.chooseLabel,
    );
    
    Get.back(
      result: {
        "label": controller.chooseLabel,
        "value": controller.chooseValue
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${"choose".tr} ${"customer type".tr}".toCapitalize()),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() {
            if (controller.isLoading == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.dataCustomerType.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomerChooseItem(
                            index: index,
                          ),
                        ],
                      );
                    },
                  )
                ),
                PAMBottom(
                  borderRadius: BorderRadius.circular(10),
                  title: "choose".tr.toCapitalize(),
                  onTab: _onTabHandler,
                )
              ],
            );
          })
        ),
      )
    );
  }
}
