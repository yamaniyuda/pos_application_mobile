import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/cloth_controller.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_form_controller.dart';
import 'package:pos_application_mobile/presentation/app/sale/screens/cloth_screen.dart';

class ClothColorFormWidget extends StatelessWidget {
  ClothColorFormWidget({super.key});

  final controller = Get.find<SaleFormController>();
  final oCcy = NumberFormat("#,##0.00", "id_ID");

  void _addClothItemHandler() async {
    final result = await Get.to(
      () => ClothScreen(),
      binding: BindingsBuilder(() { 
        Get.put(ClothController(), permanent: true);
      })
    );
    
    if (result is Map) {
      controller.orderDetails(result);
      
      late int qyt = 0;
      late int price = 0;

      for (var element in controller.orderDetails.entries) {
        qyt += element.value["qyt"] as int;
        price += element.value["price"] * element.value["qyt"] as int;
      }
      
      controller.sumTotalItem.value = price;
      controller.sumTotalPcs.value = qyt;
      controller.finalTotalPrice.value = price.toDouble();

      controller.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {

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
                        onPressed: _addClothItemHandler, 
                        alignment: Alignment.center,
                        icon: const Icon(Icons.add, color: Colors.white)
                      )
                    ],
                  )
                ),


                /// ==================
                /// Body Content Form.
                /// ==================
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 20
                  ),
                  child: GetBuilder<SaleFormController>(builder: (controller) {
                    if (controller.orderDetails.isNotEmpty) {                      

                      /// ==========================
                      /// Build List Widget Items.
                      /// ==========================
                      List<Widget> itemCloths = controller.orderDetails.entries.map<Widget>(
                        (e) {
                          final int quantity = e.value["qyt"];
                          final int price = e.value["price"] * quantity;
                  
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.fiber_manual_record,
                                  size: 10,
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 100,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${e.value["name"]}",
                                        style: GoogleFonts.lato(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "des: ${e.value["color_name"]} - ${e.value["size_name"]}",
                                        style: GoogleFonts.lato(
                                          fontSize: 12
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 50,
                                  child:  Text(
                                    "${e.value["qyt"]} Pcs",
                                    style: GoogleFonts.lato(
                                      fontSize: 12
                                    ),
                                  )
                                ),
                                SizedBox(
                                  width: 110,
                                  child: Text(
                                    "Rp ${oCcy.format(price)}",
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      ).toList();


                      /// =====================
                      /// Show Items Details
                      /// =====================
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ...itemCloths,
                            const Icon(Icons.add, size: 14),
                            const Divider( 
                              color: Colors.black54,
                              thickness: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 50,
                                  child:  Text(
                                    "${controller.sumTotalPcs.value} pcs",
                                    style: GoogleFonts.lato(
                                      fontSize: 12
                                    ),
                                  )
                                ),
                                SizedBox(
                                  width: 110,
                                  child: Text(
                                    "Rp ${oCcy.format(controller.sumTotalItem.value)}",
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const Icon(Icons.shopping_cart_checkout_sharp, size: 70),
                        Text("add cloth items".tr.toCapitalize())
                      ],
                    );
                  },)
                ),
              ],
            )
          );
        },
      );
    });
  }
}
