import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:flutter/material.dart';

class PAMAlertWidget {
  static showLoadingAlert(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 200,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: -9,
                      offset: Offset(0, 2)
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "${"load".tr}...".toCapitalize(),
                      style: GoogleFonts.lato(
                        color: const Color(0xff272829),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
