// ignore_for_file: unused_element, must_be_immutable, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/customer/controllers/option_customer_type_controller.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';

class SelectOptionCustomerTypeScreen extends StatelessWidget {
  final controller = Get.put(OptionCustomerTypeController());
  SelectOptionCustomerTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('choosee customer type'.tr.toCapitalize()),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "choosee customer category".tr.toCapitalize()
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.customerTypeDatas.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => controller.changeRadioSelection(
                        controller.customerTypeDatas[index].id!,
                        controller.customerTypeDatas[index].name!
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: index != (controller.customerTypeDatas.length - 1)
                                  ? Colors.black54
                                  : Colors.transparent
                            )
                          )
                        ),
                        child: Obx(() => Row(
                          children: [
                            Radio(
                              value: controller.customerTypeDatas[index].id as String,
                              groupValue: controller.chooseValue,
                              onChanged: (String? value) {
                                controller.changeRadioSelection(
                                  value!,
                                  controller.customerTypeDatas[index].name!
                                );
                              }
                            ),
                            Flexible(
                              child: Text(
                                controller.customerTypeDatas[index].name!,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ))
                      )
                    );
                  }
                )
              ),
              PAMBottom(
                title: "choosee customer type".tr.toCapitalize(),
                isLoading: false,
                borderRadius: BorderRadius.circular(10),
                onTab: () async {
                  Get.back(result: {
                    "label": controller.chooseLabel,
                    "value": controller.chooseValue
                  });
                },
              )
            ],
          ),
        )
      ),
    );
  }
}