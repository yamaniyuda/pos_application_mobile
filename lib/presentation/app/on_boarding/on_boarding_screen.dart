// ignore_for_file: unrelated_type_equality_checks

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pos_application_mobile/app/config/routes/app_screens.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_logo/pam_logo.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});
  final CarouselController _carouselController = CarouselController();
  final RxInt _currentIndex = 0.obs;

  final List<Map<String, String>> _titles = [
    {
      "title": "goods management".tr,
      "subTitle": "manage your stock of goods and monitor anytime and anywhere".tr
    },
    {
      "title": "pos orientation".tr,
      "subTitle": "management of incoming and outgoing goods and management of payments".tr
    }
  ];

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
      statusBarIconBrightness: Brightness.dark
    ));

    Widget showGettingStarted(int currentIndex) {
      if ((_titles.length - 1) == currentIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: PAMBottom(
              title: "get started".tr,
              onTab: () => Get.offAllNamed(Routes.auth)
          ),
        );
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {},
            child: Text(
                "skip".tr.toUpperCase()
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _titles.asMap().entries.map((e) {
              return Obx(
                      () => GestureDetector(
                    onTap: () => _carouselController.animateToPage(e.key),
                    child: Container(
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor.withOpacity(
                              _currentIndex == e.key ? 0.9 : 0.4
                          )
                      ),
                    ),
                  )
              );
            }).toList(),
          ),
          GestureDetector(
            onTap: () => _carouselController.nextPage(),
            child: Text(
              "next".tr.toUpperCase(),
              style: GoogleFonts.lato(
                color: Theme.of(context).primaryColor
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PAMLogo(),
            const SizedBox(height: 46),
            Expanded(
              child: CarouselSlider(
                items: [
                  Image.asset("assets/images/onboarding_1.png"),
                  Image.asset("assets/images/onboarding_2.png")
                ],
                carouselController: _carouselController,
                options: CarouselOptions(
                  aspectRatio: 1,
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, _) {
                    _currentIndex.value = index;
                  }
                )
              ),
            ),
            const SizedBox(height: 74),
            SizedBox(
              child: Obx(
                () => Column(
                  children: [
                    Text(
                      _titles[_currentIndex.value]["title"]!.toCapitalize(),
                      style: GoogleFonts.lato(
                        fontSize: 22,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: Get.width * 0.8,
                      child: Text(
                        toBeginningOfSentenceCase(_titles[_currentIndex.value]["subTitle"])!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          color: Theme.of(context).primaryColorDark
                        ),
                      ),
                    )
                  ],
                ),
              )
            ),
            const SizedBox(height: 43),
            Container(
              height: 60,
              padding: const EdgeInsets.only(bottom: 10),
              child: Obx(
                () => showGettingStarted(_currentIndex.value)
              )
            ),
          ],
        ),
      )
    );
  }
}