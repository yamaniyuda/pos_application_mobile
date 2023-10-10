import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pos_application_mobile/domain/entities/cloth_entity.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_detail_controller.dart';

class ItemWidget extends StatelessWidget {
  ItemWidget({super.key});

  final controller = Get.find<SaleDetailController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: controller.dataDetail.cloths!.map<Widget>((e) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              child: _ItemChildWidget(clothEntity: e)
            );
          }).toList(),
        ),
      ]
    );
  }
}




class _ItemChildWidget extends StatelessWidget {
  _ItemChildWidget({
    required this.clothEntity
  });

  final ClothEntity clothEntity;
  final oCcy = NumberFormat("#,##0.00", "id_ID");

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(.5)
            ),
            child: Text(
              clothEntity.clothCategory?.name ?? "",
              style: GoogleFonts.lato(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: clothEntity.clothColors!.map<Widget>((f) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: f.clothSizes!.map<Widget>((g) {
                    return Row(
                      children: [
                        Text(
                          "${f.color!.name} - ${g.size!.name}"
                        ),
                        const Spacer(),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 60,
                          child: Text("${g.qty.toString()} pcs"),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 110,
                          child: Text("Rp ${oCcy.format(g.total)}"),
                        )
                      ],
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}