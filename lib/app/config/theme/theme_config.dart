import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig {
  static ThemeData themeData() => ThemeData(
    primaryColor: const Color(0xff273773),
    primaryColorDark: const Color(0xff111111),
    scaffoldBackgroundColor: const Color(0xffF7F7F7),
    textTheme: GoogleFonts.latoTextTheme()
  );
}