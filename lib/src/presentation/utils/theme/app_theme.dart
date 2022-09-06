import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditamos/src/presentation/utils/theme/meditamos_dark_theme.dart';
import 'package:meditamos/src/presentation/utils/theme/meditamos_light_theme.dart';

//Meditamos theme data
class AppTheme {
  //Theme selected by the user. By default the theme mode is the system theme.
  final ThemeMode themeMode = ThemeMode.system;

  //--- Light Theme
  static ThemeData light() => MeditamosLightTheme.getTheme();

  //--- Dark Theme
  static ThemeData dark() => MeditamosDarkTheme.getTheme();

  //ThemeMode Provider
  static final StateProvider<ThemeMode> themeModeProvider =
      StateProvider<ThemeMode>((_) => AppTheme().themeMode);
}
