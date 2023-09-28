import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/domain/entities/order_entity.dart';

class SaleWidget extends StatelessWidget {
  SaleWidget({
    super.key,
    required this.orderEntity,
  });

  final OrderEntity orderEntity;
  final oCcy = NumberFormat("#,##0.00", "id_ID");

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return InkWell(
      onTap: () => Get.toNamed("/sale-detail/${orderEntity.id}"),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black54.withOpacity(.2)
                    ),
                    child: const Icon(Icons.sell),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        orderEntity.customer!.name!.toCapitalize(),
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        orderEntity.customer!.customerType!.name!.toCapitalize(),
                        style: GoogleFonts.lato(
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    "${orderEntity.totalQty} pcs",
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),

              /// ==============
              /// Code Order
              /// ==============
              Row(
                children: [
                  Text(
                    "${"code".tr} ${"order".tr}".toCapitalize(),
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 12
                    ),
                  ),
                  const Spacer(),
                  Text(
                    orderEntity.orderNumber!.toCapitalize(),
                    style: GoogleFonts.lato(
                      fontSize: 12
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),


              /// ==============
              /// Status Order
              /// ==============
              Row(
                children: [
                  Text(
                    "status".tr.toCapitalize(),
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 12
                    ),
                  ),
                  const Spacer(),
                  Text(
                    orderEntity.status!.toCapitalize(),
                    style: GoogleFonts.lato(
                      fontSize: 12
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),


              /// ==============
              /// Payment Method
              /// ==============
              Row(
                children: [
                  Text(
                    "payment method".tr.toCapitalize(),
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 12
                    ),
                  ),
                  const Spacer(),
                  Text(
                    orderEntity.paymentMethod!.toCapitalize(),
                    style: GoogleFonts.lato(
                      fontSize: 12
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),


              /// ==============
              /// Payment Method
              /// ==============
              Row(
                children: [
                  Text(
                    "total".tr.toCapitalize(),
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 12
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Rp ${oCcy.format(orderEntity.total)}",
                    style: GoogleFonts.lato(
                      fontSize: 12
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
