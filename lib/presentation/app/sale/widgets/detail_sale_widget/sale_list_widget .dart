import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_detail_controller.dart';

class SaleListWidget extends StatelessWidget {
  SaleListWidget({super.key});

  final controller = Get.find<SaleDetailController>();
  final oCcy = NumberFormat("#,##0.00", "id_ID");

  String _getDateFormat(String data) {
    final DateFormat dateFormat = DateFormat('dd MM yyyy');
    final DateTime dateTime = DateTime.parse(data);

    return dateFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return ListView( 
      padding: const EdgeInsets.all(20),
      children: controller.dataDetail.orderHistoryLog!.map<Widget>((e) {
        return Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                color: Theme.of(context).primaryColor.withOpacity(.5),
                child: Text(
                  "${"created".tr} ${"date".tr} ${_getDateFormat(e.createdAt!)}".toCapitalize(),
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text("created by".tr.toCapitalize()),
                    const Spacer(),
                    Text(
                      e.createdBy!.name!,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text("note".tr.toCapitalize()), 
                    const Spacer(),
                    Text(
                      e.note ?? "-",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      }).toList()
    );
  }
}