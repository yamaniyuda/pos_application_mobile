import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_application_mobile/app/config/routes/app_screens.dart';
import 'package:pos_application_mobile/app/config/theme/theme_config.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/utils/system_utils.dart';
import 'package:pos_application_mobile/presentation/app/home/controllers/home_controller.dart';
import 'package:pos_application_mobile/presentation/app/home/widgets/bar_chart_widget.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_badge/pam_badge.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom_icon.dart';

part 'header_home.g.dart';
part 'feature_home.g.dart';

/// Home screen
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  /// order status build
  /// this widget put inside header
  /// and show with horizontal
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

  /// header building
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
          height: Get.height * 0.22,
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
                  ),
                  const Spacer(),
                  Text(
                    "see all".tr.toCapitalize(),
                    style: GoogleFonts.lato(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 16
                    ),
                  ),
                  const SizedBox(width: 10),
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
      backgroundColor: Theme.of(context).primaryColor,
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

                /* content wrap */
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    height: Get.height,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _FeatureHome()
                      ],
                    )
                  ),
                ),
              ],
            ),

            /* nav header */
            PreferredSize(
              preferredSize: Size(Get.width, 20),
              child: _HeaderHome()
            )
          ],
        ),
      )
    );
  }
}