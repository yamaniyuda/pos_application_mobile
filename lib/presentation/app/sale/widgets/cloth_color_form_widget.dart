import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/cloth_controller.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_form_controller.dart';
import 'package:pos_application_mobile/presentation/app/sale/screens/cloth_screen.dart';

class ClothColorFormWidget extends StatelessWidget {
  ClothColorFormWidget({super.key});

  final controller = Get.find<SaleFormController>();


  /// Add Cloth Item Handler.
  void _addClothItemHandler() {
    Get.to(
      () => ClothScreen(),
      binding: BindingsBuilder(() { 
        Get.put(ClothController(), permanent: true);
      })
    );
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
                  height: 200,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Icon(Icons.shopping_cart_checkout_sharp, size: 70),
                      Text("add cloth items".tr.toCapitalize())
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
