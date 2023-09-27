// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/cloth_controller.dart';
import 'package:pos_application_mobile/presentation/app/sale/model/cloth_form_payload.dart';
import 'package:pos_application_mobile/presentation/app/sale/widgets/product_widget/product_add_widget.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_badge/pam_badge.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.clothFormPayload,
    required this.index
  });

  final int index;
  final ClothFormPayload clothFormPayload;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    void _onTabHandler() {
      Get.bottomSheet(ProductAddWidget(
        clothFormPayload: clothFormPayload,
        index: index,
      ));
    }

    return InkWell(
      onTap: _onTabHandler,
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
                    child: const Icon(Icons.checkroom_rounded),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          clothFormPayload.clothEntity.clothCategory?.name ?? "",
                          style: GoogleFonts.lato(
                            fontSize: 16.sp
                          ),
                        ),
                        Text(
                          clothFormPayload.clothEntity.clothCategory?.name ?? "",
                          style: GoogleFonts.lato(
                            fontSize: 14.sp,
                            color: Colors.black54.withOpacity(.5)
                          ),
                        )
                      ],
                    )
                  ),
                  GetBuilder<ClothController>(builder: (controller) {
                    if (clothFormPayload.items.isNotEmpty) {
                      return PamBadge(
                        text: Text(clothFormPayload.calculateTotalItem().toString()), 
                        color: Colors.yellow
                      );
                    }

                    return Container();
                  },)
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
