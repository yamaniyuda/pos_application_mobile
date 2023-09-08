import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_application_mobile/domain/entities/cloth_entity.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.clothEntity,
  });

  final ClothEntity clothEntity;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return InkWell(
      onTap: () => Get.toNamed("/product-detail/${clothEntity.id}"),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clothEntity.clothCategory?.name ?? "",
                        style: GoogleFonts.lato(
                          fontSize: 16.sp
                        ),
                      ),
                      Text(
                        clothEntity.clothCategory?.name ?? "",
                        style: GoogleFonts.lato(
                          fontSize: 14.sp,
                          color: Colors.black54.withOpacity(.5)
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
