import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig {
  static ThemeData themeData() => ThemeData(
    primaryColor: const Color(0xff273773),
    primaryColorDark: const Color(0xff111111),
    scaffoldBackgroundColor: const Color(0xffF7F7F7),
    textTheme: GoogleFonts.latoTextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: const Color(0xff111111),
      ),
      centerTitle: true,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Color(0xff111111),
      )
    )
  );
}

extension CollorPallet on ThemeData {
  static const Color _dangerColor = Color(0xffff5b00);
  Color get dangerColor => _dangerColor;

  static const Color _warningColor = Color(0xffffcc00);
  Color get warningColor => _warningColor;
}