import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppColors {
  static Color primary = const Color(0xFFC83EE2);
  static Color secondary = const Color(0xFFF997A6);
}

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    textTheme: TextTheme(
      bodySmall: GoogleFonts.poppins(),
      bodyMedium: GoogleFonts.poppins(),
      bodyLarge: GoogleFonts.poppins(),
      headlineSmall: GoogleFonts.poppins(),
      headlineMedium: GoogleFonts.poppins(),
      headlineLarge: GoogleFonts.poppins(),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.secondary,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
    ),
  );
}
