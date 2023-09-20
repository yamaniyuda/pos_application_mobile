// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/utils/system_utils.dart';
import 'package:pos_application_mobile/presentation/app/product/controllers/product_form_controller.dart';

part 'size_form_widget.dart';

class ColorFormWidget extends StatelessWidget {
  ColorFormWidget({
    super.key,
    this.showSku = true,
    required this.index,
    required this.headerColor,
  });

  final Color headerColor;
  final int index;
  final bool showSku;
  final controller = Get.find<ProductFormController>();

  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(context);
    double luminance = headerColor.computeLuminance();
    Color textColor = luminance > 0.5 ? Colors.black : Colors.white;

    return Card(
      margin: const EdgeInsets.all(15),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 40,
              color: headerColor,
              alignment: Alignment.centerLeft,
              child: Text(
                "${"color".tr} - ${controller.clothColorPayloads[index].name}".toCapitalize(),
                style: GoogleFonts.lato(
                    fontSize: 16.sp,
                    color: textColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  if (showSku) TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      isDense: true,
                      border: const OutlineInputBorder(),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'SKU',
                      fillColor: Colors.black.withOpacity(.05),
                    ),
                    onChanged: (value) => controller.clothColorPayloads[index].sku = value,
                    initialValue: controller.clothColorPayloads[index].sku,
                    validator: (value) => SystemUtils.validatorMessage(value, "sku required"),
                    onSaved: (String? value) => controller.clothColorPayloads[index].sku = value!,
                  ),
                  if (showSku) const SizedBox(height: 10),
                  
                  ...controller.sizeChoose.asMap().entries.map<Widget>((element) {
                    return SizeFormWidget(
                      index: index,
                      indexSize: element.key
                    );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}