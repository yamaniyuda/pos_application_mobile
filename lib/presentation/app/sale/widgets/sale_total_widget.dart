import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';

class SaleTotalWidget extends StatelessWidget {
  const SaleTotalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      verticalDirection: VerticalDirection.up,
      children: [
        Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Text(
            "${"detail".tr} ${"sale".tr}".toCapitalize(),
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
    );
  }
}