// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/domain/repositories/order_repository.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_detail_controller.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_badge/pam_badge.dart';
import 'package:pos_application_mobile/presentation/widgets/sparator/sparator_widget.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({super.key});

  final controller = Get.find<SaleDetailController>();
  final oCcy = NumberFormat("#,##0.00", "id_ID");

  Color _getColorBadge(String status) {
    if (status.toLowerCase() == "lunas") return Colors.green[200]!;
    if (status.toLowerCase() == "batal") return Colors.red[200]!;
    if (status.toLowerCase() == "pending") return Colors.yellow[200]!;
    return Colors.grey[200]!;
  }

  
  String getCreatedValue() {
    final DateFormat dateFormat = DateFormat('dd MM yyyy');
    final DateTime dateTime = DateTime.parse(controller.dataDetail.createdAt ?? "") ;
    final String createdBy = controller.dataDetail.createdBy?.name ?? '-';
    
    return "${dateFormat.format(dateTime)} ( $createdBy )";
  }


  String getUpdatedValue() {
    final DateFormat dateFormat = DateFormat('dd MM yyyy');
    final DateTime dateTime = DateTime.parse(controller.dataDetail.updatedAt!);
    final String updatedBy = controller.dataDetail.updatedBy?.name ?? '-';
    
    return "${dateFormat.format(dateTime)} ( $updatedBy )";
  }


  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10)
                      ),
                      color: Colors.black54.withOpacity(.2)
                    ),
                    child: const Icon(Icons.sell, size: 30),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 200,
                    child: Align(
                      alignment: Alignment.bottomLeft, // Align text to the bottom left
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (controller.dataDetail.customer?.name ?? "").toCapitalize(),
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(controller.dataDetail.customer?.customerType?.name ?? "")
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  PamBadge(
                    text: Text(
                      controller.dataDetail.status ?? "",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold
                      ),
                    ), 
                    color: _getColorBadge(controller.dataDetail.status ?? "")
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            /// ============
            /// Description 
            /// ============
            _DescriptionItemWidget(label: "order number".tr, value: controller.dataDetail.orderNumber!),
            _DescriptionItemWidget(label: "payment method".tr, value: controller.dataDetail.paymentMethod ?? ""),
            _DescriptionItemWidget(label: "${"created".tr} ${"date".tr}", value: getCreatedValue()),
            _DescriptionItemWidget(label: "${"updated".tr} ${"date".tr}", value: getUpdatedValue()),

            
            const SizedBox(height: 20),
            CustomPaint(
              painter: SparatorWidget(),
              size: const Size(double.infinity, 10)
            ),
            const SizedBox(height: 10),

            if (controller.dataDetail.paymentMethod == OrderRepository.downPayment) _DescriptionItemWidget(
              label: "amount down payment".tr, 
              value: "Rp ${oCcy.format(controller.dataDetail.amountDownPayment)}"
            ),
            _DescriptionItemWidget(label: "quantity".tr, value: controller.dataDetail.totalQty.toString()),
            _DescriptionItemWidget(label: "total", value: "Rp ${oCcy.format(controller.dataDetail.total)}")
          ],
        ),
      )
    );
  }
}



class _DescriptionItemWidget extends StatelessWidget {
  const _DescriptionItemWidget({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label.toCapitalize()),
        const Spacer(),
        Text(
          value.toCapitalize(),
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }
}