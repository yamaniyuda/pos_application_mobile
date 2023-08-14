import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_application_mobile/app/config/routes/app_screens.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/account/account.dart';

class AccountScreen extends GetView<AccountController> {
  const AccountScreen({Key? key}) : super(key: key);

  void _changeColorBar(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark
    ));
  }

  Widget _buildProfile(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        height: Get.height * 0.40,
        padding: EdgeInsets.symmetric(vertical: 5.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Profile",
              style: GoogleFonts.lato(fontSize: 16.sp),
            ),
            SizedBox(height: 20.sp),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: Get.width * 0.12,
              backgroundImage: const AssetImage(
                "assets/images/account.png",
              )
            ),
            Text(
              controller.authService.userEntity?.name ?? "",
              style: GoogleFonts.lato(
                fontSize: 20.sp
              ),
            ),
            Text(
              controller.authService.userEntity?.email ?? "",
              style: GoogleFonts.lato(
                fontSize: 12.sp,
                color: Theme.of(context).primaryColorDark.withOpacity(0.5)
              ),
            ),
            SizedBox(height: 7.sp),
            Text(
              controller.authService.userEntity?.phoneNumber ?? "",
              style: GoogleFonts.lato(
                  fontSize: 12.sp,
                  color: Theme.of(context).primaryColorDark.withOpacity(0.5)
              ),
            ),
            SizedBox(height: 15.sp),
            Text(
              "Edit ${"profile".tr}".toCapitalize(),
              style: GoogleFonts.lato(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: Theme.of(context).primaryColor
              ),
            )
          ],
        )
      );
    });
  }

  Widget _buildMenuSetting(BuildContext context) {
    final List<Map<String, dynamic>> menuSetting = [
      { "title": "order".tr, "screenRouter": "", "icon": const Icon(Icons.add_card_sharp, color: Colors.white), "color": const Color(0xFFE50A0A) },
      { "title": "address".tr, "screenRouter": "" , "icon": const Icon(Icons.location_on, color: Colors.white), "color": const Color(0xFF2CADE9) },
      { "title": "language".tr, "screenRouter": Routes.language, "icon": const Icon(Icons.language, color: Colors.white), "color": Theme.of(context).primaryColor },
      { "title": "logout".tr, "screenRouter": "" , "icon": const Icon(Icons.logout, color: Colors.white), "color": const Color(0xFF4AD7C9)},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: menuSetting.map((e) => ListTile(
          title: Text(
            "${e["title"]}".toCapitalize(),
            style: GoogleFonts.lato(
              color: Theme.of(context).primaryColorDark.withOpacity(0.5)
            ),
          ),
          leading: Container(
            padding: EdgeInsets.all(6.sp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: e["color"]
            ),
            child: e["icon"],
          ),
          onTap: () {
            if (e["screenRouter"] != "") {
              Get.toNamed(e["screenRouter"]);
            }
          },
          trailing: const Icon(Icons.keyboard_arrow_right),
        )).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    _changeColorBar(context);
    return Scaffold(
      body: SafeArea(
          child: ListView(
            children: [
              _buildProfile(context),
              SizedBox(height: 20.sp),
              _buildMenuSetting(context)
            ],
          )
      ),
    );
  }
}
