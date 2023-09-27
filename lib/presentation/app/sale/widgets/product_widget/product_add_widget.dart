// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/domain/entities/cloth_color_entity.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/cloth_controller.dart';
import 'package:pos_application_mobile/presentation/app/sale/model/cloth_form_payload.dart';
import 'package:pos_application_mobile/presentation/app/sale/widgets/product_widget/product_add_action_widget.dart';

class ProductAddWidget extends StatelessWidget {
  ProductAddWidget({
    super.key,
    required this.clothFormPayload,
    required this.index
  });

  final ClothFormPayload clothFormPayload;
  final int index;
  final controller = Get.find<ClothController>();
  late Rx<ClothColorEntity> colorObjek = clothFormPayload.clothEntity.clothColors![0].obs;
  late RxString color = jsonEncode({ "name": colorObjek.value.color!.name!, "id": colorObjek.value.id! }).obs;


  void setColorObjek(String color) {
    final String id = jsonDecode(color)["id"];
    late int index;

    clothFormPayload.clothEntity.clothColors?.asMap().entries.forEach((element) { 
      if (element.value.id == id) {
        index = element.key;
      }
    });

    colorObjek.value = clothFormPayload.clothEntity.clothColors![index];
    controller.update();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        )
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${"add".tr} ${"item".tr}".toCapitalize(),
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),

          Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    clothFormPayload.clothEntity.clothCategory!.name!.toCapitalize(),
                  ),
                  const Spacer(),
                  Obx(() => DropdownButton(
                    items: clothFormPayload.clothEntity.clothColors!.map<DropdownMenuItem>(
                      (e) => DropdownMenuItem(
                        value: jsonEncode({ "name": e.color!.name, "id": e.id }), 
                        child: Text(e.color!.name!.toCapitalize())
                      )
                    ).toList(),
                    value: color.value,
                    onChanged:  (value) {
                      color.value = value;
                      setColorObjek(value);
                    },
                  ))
                ],
              ),
              GetBuilder<ClothController>(builder: (controller) {

                return SizedBox(
                  height: 300,
                  child: ListView(
                    children: colorObjek.value.clothSizes!.map<Widget>(
                      (e) {
                 

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 50,
                                child: Text(e.size!.name!.toCapitalize()),
                              ),

                              Container(
                                alignment: Alignment.center,
                                width: 50,
                                child: Text(e.stock.toString()),
                              ),


                              const Spacer(),

                              ProductAddActionWidget(
                                key: Key(e.id!),
                                clothColorId: jsonDecode(color.value)["id"], 
                                clothFormPayload: clothFormPayload, 
                                clothSizeId: e.id!, 
                                clothSizePriceId: e.price!.id!, 
                                value: (clothFormPayload.items[e.id]?['qyt'] ?? 0).toString(),
                              )
                            ],
                          ),
                        );
                      }
                    ).toList(),
                  ),
                );
              }),
            ],
          )
        ],
      ),
    );
  }
}