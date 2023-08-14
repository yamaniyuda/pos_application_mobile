import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig {
  static ThemeData themeData() => ThemeData(
    primaryColor: const Color(0xff273773),
    primaryColorDark: const Color(0xff111111),
    scaffoldBackgroundColor: const Color(0xffF7F7F7),
    textTheme: GoogleFonts.latoTextTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff273773)
    )
  );
}

extension CollorPallet on ThemeData {
  static const Color _dangerColor = Color(0xffff5b00);
  Color get dangerColor => _dangerColor;

  static const Color _warningColor = Color(0xffffcc00);
  Color get warningColor => _warningColor;
}