import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    /* do redirect another page */
    Timer(
      const Duration(seconds: 3),
      () => Get.offNamed('/onboarding')
    );
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff273773),
      statusBarColor: Color(0xff273773)
    ));

    return Scaffold(
      backgroundColor: const Color(0xff273773),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("./assets/images/logo-circle.png"),
              const SizedBox(height: 20),
              Text(
                "Kaos Nyaman",
                style: GoogleFonts.lemon(
                  fontSize: 41,
                  color: Colors.white
                ),
              ),
              Text(
                "Online clothes shop",
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
