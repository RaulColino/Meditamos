import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditamos/src/presentation/utils/theme/meditamos_colors.dart';

class MeditamosLightTheme {
  //Return ThemeData generated easily from flex_color_scheme package
  static ThemeData getTheme() => FlexThemeData.light(
        useMaterial3: false,
        colorScheme: _flexSchemeLight,
        scaffoldBackground: MeditamosColors.whiteBackground,
        appBarBackground: MeditamosColors.whiteBackground,
        appBarElevation: 0,
        surface: MeditamosColors
            .white, //Color for cards. surface from colorScheme doesnt work only this works.
        //surfaceTint: MeditamosColors.grayDarker,
        useMaterial3ErrorColors: true,
        // Text with a color that contrasts with the card and canvas colors.
        textTheme: const TextTheme().copyWith(
          bodyMedium: const TextStyle(color: MeditamosColors.textGray),
          headlineSmall: const TextStyle(
            color: MeditamosColors.textGray,
          ),
          headlineMedium: const TextStyle(
            color: MeditamosColors.black,
            fontWeight: FontWeight.bold,
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
        primaryTextTheme: const TextTheme(
          headline6: TextStyle(
              color: MeditamosColors.red, fontWeight: FontWeight.w100),
        ),
      );

  static const ColorScheme _flexSchemeLight = ColorScheme(
    brightness: Brightness.light,
    primary: MeditamosColors.primaryLight,
    onPrimary: Color(0xffffffff),
    primaryContainer: Color(0xffeaddff),
    onPrimaryContainer: Color(0xff000000),
    secondary: Color(0xff625b71),
    onSecondary: Color(0xffffffff),
    secondaryContainer: Color(0xffe8def8),
    onSecondaryContainer: Color(0xff000000),
    tertiary: Color(0xff7d5260),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0xffffd8e4),
    onTertiaryContainer: Color(0xff000000),
    error: Color(0xffb00020),
    onError: Color(0xffffffff),
    errorContainer: Color(0xfffcd8df),
    onErrorContainer: Color(0xff000000),
    outline: Color.fromARGB(255, 240, 240, 240),
    background: Color.fromARGB(255, 255, 255, 255),
    onBackground: Color.fromARGB(255, 77, 77, 77),
    surface: Color(
        0xffffffff), //this doesnt work. To modify surface go to FlexThemeData.dark() and change surface parameter
    onSurface: Color.fromARGB(255, 136, 136, 136),
    surfaceVariant: Color(0xffffffff),
    onSurfaceVariant: Color(0xff000000),
    inverseSurface: Color(0xff121212),
    onInverseSurface: Color(0xffffffff),
    inversePrimary: Color(0xfff0e9ff),
    shadow: Color(0xff000000),
  );
}
