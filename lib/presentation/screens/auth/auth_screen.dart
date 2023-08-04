import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/controllers/auth/auth_controller.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_logo/pam_logo.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  // final TabController _tabController = TabController(length: 1, vsync: );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const PAMLogo(),
            const SizedBox(height: 36),
            Text(
              "${"welcome you".tr}!".toCapitalize(),
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 22
              ),
            ),
            const SizedBox(height: 26),
            TabBar(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              controller: controller.tabController,
              labelColor: Theme.of(context).primaryColor,
              indicatorColor: Theme.of(context).primaryColor,
              tabs: [
                Tab(
                  child: Text(
                    "login".tr.toCapitalize(),
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                )
              ]
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              height: Get.height * 07,
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  Text('Login here')
                ]
              )
            )
          ],
        ),
      ),
    );
  }
}