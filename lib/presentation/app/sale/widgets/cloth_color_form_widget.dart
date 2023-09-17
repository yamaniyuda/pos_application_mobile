import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/domain/entities/cloth_size_entity.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_form_controller.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';

class ClothColorFormWidget extends StatelessWidget {
  ClothColorFormWidget({super.key});

  final controller = Get.find<SaleFormController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {

      if (controller.clothColorPayload.isEmpty) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(30),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "there are no clothes yet. add clothes list".tr.toCapitalize(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  PAMBottom(
                    borderRadius: BorderRadius.circular(10),
                    title: "${"add".tr} ${"cloth".tr}".toCapitalize(),
                    onTab: () => controller.addClothColorPayload(),
                  )
                ],
              ),
            ),
          ),
        );
      }

      return SliverList.builder(
        itemCount: controller.clothColorPayload.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            elevation: 2,
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// ================
                /// Header.
                /// ================
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    children: [
                      Text(
                        "cloth".tr.toCapitalize(),
                        style: GoogleFonts.lato(
                          color: Colors.white
                        ),
                      ),

                      const Spacer(),

                      IconButton(
                        onPressed: () {}, 
                        alignment: Alignment.center,
                        icon: const Icon(Icons.delete, color: Colors.white)
                      )
                    ],
                  )
                ),


                /// =================
                /// Body Content Form.
                /// =================
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 20),
                      PAMFormTextFieldWidget(
                        decoration: const BoxDecoration(),
                        inputDecoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            isDense: true,
                            border: const OutlineInputBorder(),
                            filled: true,
                            labelText: "SKU",
                            alignLabelWithHint: false,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            fillColor: Colors.black.withOpacity(.05)
                          ),
                        onChanged: (value) => controller.searchClothColorBySku(value, index),
                        // onSaved: (p0) => controller.customerTypePayload = p0!,
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        thickness: 2,
                        color: Colors.black54,
                      ),
                      Container(
                        width: 100,
                        height: 3,
                        margin: const EdgeInsets.only(bottom: 10),
                        alignment: Alignment.centerRight,
                        child: const Divider(
                          thickness: 2,
                          color: Colors.black54,
                        ),
                      ),

                      Obx(() {
                        if (controller.clothColorPayload[index].clothSizes != null) {
                          final List<ClothSizeEntity> clothSize = controller.clothColorPayload[index].clothSizes!;

                          return Column(
                            children: clothSize.asMap().entries.map<Widget>((e) => Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.black54.withOpacity(.3),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Text(e.value.size!.name!),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    child: Text("stock".tr.toCapitalize()),
                                                  ),
                                                  const Text(":"),
                                                  const SizedBox(width: 5),
                                                  Text(e.value.stock.toString())
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    child: Text("price".tr.toCapitalize()),
                                                  ),
                                                  const Text(":"),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    NumberFormat.simpleCurrency(locale: "id-ID").format(e.value.price!.price)
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 10),
                                  PAMFormTextFieldWidget(
                                    decoration: const BoxDecoration(),
                                    onChanged: (value) => controller.changeQuantity(
                                      int.parse(value), index, e.key
                                    ),
                                    inputDecoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(10),
                                      isDense: true,
                                      border: const OutlineInputBorder(),
                                      filled: true,
                                      labelText: "quantity".tr.toCapitalize(),
                                      alignLabelWithHint: false,
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      fillColor: Colors.black.withOpacity(.05)
                                    ),
                                  ),
                                ],
                              ),
                            )).toList(),
                          );
                        }

                        return Container();
                      })
                    ],
                  ),
                ),
              ],
            )
          );
        },
      );
    });
  }
}
