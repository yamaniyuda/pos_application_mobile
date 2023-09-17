import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_application_mobile/app/config/routes/app_screens.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/services/auth_service.dart';
import 'package:pos_application_mobile/presentation/app/account/account.dart';

class AccountScreen extends GetView<AccountController> {
  const AccountScreen({Key? key}) : super(key: key);

  Widget _buildProfile(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        height: Get.height * 0.30,
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
          ],
        )
      );
    });
  }

  bool _isShowMenuItem(Map<String, dynamic> data) {
    return data["guards"] != null && !data["guards"]?.contains(controller.authService.userEntity?.role);
  }

  Widget _buildMenuItem(Map<String, dynamic> data) {
    if (_isShowMenuItem(data)) {
      return Container();
    }

    return ListTile(
      title: Text(
        "${data["title"]}".toCapitalize(),
        style: GoogleFonts.lato(
            color: Theme.of(Get.context!).primaryColorDark.withOpacity(0.5)
        ),
      ),
      leading: Container(
        padding: EdgeInsets.all(6.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: data["color"]
        ),
        child: data["icon"],
      ),
      onTap: () async {
        if (data["screenRouter"] != "") {
          Get.toNamed(data["screenRouter"]);
        }

        if (data["isLogout"] != null) {
          await controller.authService.logout();
        }
      },
      trailing: const Icon(Icons.keyboard_arrow_right),
    );
  }

  Widget _buildMenuSetting(BuildContext context) {

    final List<Map<String, dynamic>> menuActivity = [
      { "title": "user".tr, "screenRouter": Routes.user, "icon": const Icon(Icons.person_add_alt_1_rounded, color: Colors.white,), "color": Theme.of(Get.context!).primaryColor, "guards": [AuthService.OWNER] },
      { "title": "customer".tr, "screenRouter": Routes.customer, "icon": const Icon(Icons.lock_person_sharp, color: Colors.white,), "color": Theme.of(Get.context!).primaryColor },
      { "title": "customer type".tr, "screenRouter": Routes.customerType, "icon": const Icon(Icons.manage_accounts, color: Colors.white,), "color": Theme.of(context).primaryColor },
      { "title": "supplier".tr, "screenRouter": Routes.supplier, "icon": const Icon(Icons.support_outlined, color: Colors.white,), "color": Theme.of(context).primaryColor },
      { "title": "color".tr, "screenRouter": Routes.color, "icon": const Icon(Icons.color_lens, color: Colors.white,), "color": Theme.of(Get.context!).primaryColor },
      { "title": "size".tr, "screenRouter": Routes.size, "icon": const Icon(Icons.photo_size_select_large, color: Colors.white,), "color": Theme.of(Get.context!).primaryColor },
      { "title": "cloth category".tr, "screenRouter": Routes.clothCategory, "icon": const Icon(Icons.loyalty, color: Colors.white,), "color": Theme.of(Get.context!).primaryColor },
      { "title": "cloth price type".tr, "screenRouter": Routes.clothPriceType, "icon": const Icon(Icons.discount_rounded, color: Colors.white,), "color": Theme.of(Get.context!).primaryColor },
    ];

    final List<Map<String, dynamic>> menuSetting = [
      // { "title": "address".tr, "screenRouter": "" , "icon": const Icon(Icons.location_on, color: Colors.white), "color": const Color(0xFF2CADE9) },
      { "title": "language".tr, "screenRouter": Routes.language, "icon": const Icon(Icons.language, color: Colors.white), "color": Theme.of(Get.context!).primaryColor },
      { "title": "password".tr, "screenRouter": "", "icon": const Icon(Icons.password, color: Colors.white), "color": Theme.of(Get.context!).primaryColor },
      { "title": "logout".tr, "screenRouter": "" , "icon": const Icon(Icons.logout, color: Colors.white), "color":const Color(0xFFE50A0A), "isLogout": true },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* activity menu list */
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              "my activity".tr.toCapitalize(),
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          ...menuActivity.map((e) => _buildMenuItem(e)).toList(),

          /* setting menu list */
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.only(bottom: 10, top: 10),
            child: Text(
              "setting".tr.toCapitalize(),
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          ...menuSetting.map((e) => _buildMenuItem(e)).toList()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
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
