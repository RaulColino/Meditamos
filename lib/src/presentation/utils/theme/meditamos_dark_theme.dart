import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditamos/src/presentation/utils/theme/meditamos_colors.dart';

class MeditamosDarkTheme {
  //Return ThemeData generated easily from flex_color_scheme package
  static ThemeData getTheme() => FlexThemeData.dark(
        useMaterial3: false,
        colorScheme: _flexSchemeDark,
        scaffoldBackground: MeditamosColors.charcoal,
        appBarBackground: MeditamosColors.charcoal,
        appBarElevation: 0,
        surface: MeditamosColors.surfaceGray, //Color for cards. surface from colorScheme doesnt work only this works.
        //surfaceTint: MeditamosColors.grayDarker,
        useMaterial3ErrorColors: true,
        
        // Text with a color that contrasts with the card and canvas colors.
        // Modify Normal Text Theme colors here
        textTheme: const TextTheme().copyWith(
          bodyMedium: const TextStyle(color: MeditamosColors.textGray),
          headlineSmall: const TextStyle(
            color: MeditamosColors.textGrayLighter,
          ),
          headlineMedium: const TextStyle(
            color: MeditamosColors.white,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: const TextStyle(
            color: MeditamosColors.red,
          ),
          // labelSmall: const TextStyle(
          //   color: MeditamosColors.textGray,
          // ),
          // labelMedium: const TextStyle(
          //   color: MeditamosColors.textGray,
          // ),
          // labelLarge: const TextStyle(
          //   color: MeditamosColors.textGray,
          // ),
        ),
        fontFamily: GoogleFonts.inter().fontFamily,
        
        // A text theme that contrasts with the primary color.
        // Modify Text colors over primary color here
        primaryTextTheme: const TextTheme(
          //Equivalent to title large
          headline6: TextStyle(color: MeditamosColors.green),
        ),
      );

  static const ColorScheme _flexSchemeDark = ColorScheme(
    brightness: Brightness.dark,
    primary: MeditamosColors.primaryDark,
    onPrimary: Color(0xff000000),
    primaryContainer: Color(0xff4f378b),
    onPrimaryContainer: Color(0xffffffff),
    secondary: Color(0xffccc2dc),
    onSecondary: Color(0xff000000),
    secondaryContainer: Color(0xff4a4458),
    onSecondaryContainer: Color(0xffffffff),
    tertiary: Color(0xffefb8c8),
    onTertiary: Color(0xff000000),
    tertiaryContainer: Color(0xff633b48),
    onTertiaryContainer: Color(0xffffffff),
    error: Color(0xffcf6679),
    onError: Color(0xff000000),
    errorContainer: Color(0xffb1384e),
    onErrorContainer: Color(0xffffffff),
    outline: Color.fromARGB(255, 87, 87, 87),
    background: Color.fromARGB(255, 35, 36, 37),
    onBackground: Color(0xffffffff),
    surface: Color(
        0xff121212), //this doesnt work. To modify surface go to FlexThemeData.dark() and change surface parameter
    onSurface: Color(0xffffffff),
    surfaceVariant: Color(0xff121212),
    onSurfaceVariant: Color(0xffffffff),
    inverseSurface: Color(0xffffffff),
    onInverseSurface: Color(0xff000000),
    inversePrimary: Color(0xff635b70),
    shadow: Color.fromARGB(255, 255, 255, 255),
  );
}
