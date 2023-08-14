import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_application_mobile/app/config/theme/theme_config.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/home/controllers/home_controller.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_badge/pam_badge.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  Widget _orderStatusList(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          width: Get.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "32 order".toCapitalize(),
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "3 menit".toCapitalize(),
                style: GoogleFonts.lato(
                  fontSize: 10.sp,
                  color: Theme.of(context).primaryColorDark.withOpacity(0.5)
                ),
              ),
              const SizedBox(height: 10),
              PamBadge(
                text: Text(
                  "paid off".tr.toCapitalize(),
                  style: GoogleFonts.lato(
                    color: Colors.white
                  ),
                ),
                color: const Color(0xff56D5A8)
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          width: Get.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "32 order".toCapitalize(),
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "3 menit".toCapitalize(),
                style: GoogleFonts.lato(
                  fontSize: 10.sp,
                  color: Theme.of(context).primaryColorDark.withOpacity(0.5)
                ),
              ),
              const SizedBox(height: 10),
              PamBadge(
                text: Text(
                  "stand".tr.toCapitalize(),
                  style: GoogleFonts.lato(
                      color: Colors.white
                  ),
                ),
                color: Theme.of(context).dangerColor
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          width: Get.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "32 order".toCapitalize(),
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "3 menit".toCapitalize(),
                style: GoogleFonts.lato(
                  fontSize: 10.sp,
                  color: Theme.of(context).primaryColorDark.withOpacity(0.5)
                ),
              ),
              const SizedBox(height: 10),
              PamBadge(
                text: Text(
                  "pending".tr.toCapitalize(),
                  style: GoogleFonts.lato(
                    color: Colors.white
                  ),
                ),
                color: Theme.of(context).warningColor
              )
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _headerBuild(BuildContext context) {
    return [
      SliverToBoxAdapter(
        child: Container(
          color: Theme.of(context).primaryColor,
          height: 40,
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            height: Get.height * 0.25,
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      "order list".tr.toCapitalize(),
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 16
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: Get.height * 0.12,
                  child: _orderStatusList(context),
                )
              ],
            )
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              CustomScrollView(
                controller: controller.scrollController,
                slivers: [
                  /* header wrap */
                  ..._headerBuild(context),

                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Get.height * 1.5,
                      child: const Center(
                        child: Text("hai"),
                      ),
                    ),
                  )
                ],
              ),
              PreferredSize(
                  preferredSize: Size(Get.width, 20),
                  child: _FadeAppBar()
              )
            ],
          ),
        )
    );
  }
}

class _FadeAppBar extends StatelessWidget {
  final controller = Get.find<HomeController>();

  _FadeAppBar({super.key });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Obx(() {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 50,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 24
            ),
            color: Theme.of(context).primaryColor,
            child: SafeArea(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 14.sp,
                    backgroundImage: const AssetImage(
                      "assets/images/account.png",
                    )
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${controller.authService.userEntity!.name} - ${controller.colorFadeOpacity}",
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        })
    );
  }
}

