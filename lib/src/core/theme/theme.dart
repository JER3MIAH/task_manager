import 'package:flutter/material.dart';
import 'package:task_manager/src/core/theme/colors.dart';

const plusJakartaSans = 'Plus Jakarta Sans';

final lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: appColors.lightBg,
  textTheme: TextTheme().apply(fontFamily: plusJakartaSans),
  colorScheme: ColorScheme.light(
    surface: appColors.lightBg,
    onSurface: appColors.black,
    primary: appColors.mainPurple,
    onPrimary: appColors.white,
    primaryContainer: appColors.mainPurpleHover,
    secondary: appColors.mainPurple.withValues(alpha: .1),
    onSecondary: appColors.mainPurple,
    secondaryContainer: appColors.mainPurple.withValues(alpha: .25),
    outline: appColors.linesLight,
    inversePrimary: appColors.mediumGrey,
    tertiary: appColors.white,
    error: appColors.red,
    errorContainer: appColors.redHover,
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: appColors.darkBg,
  textTheme: TextTheme().apply(fontFamily: plusJakartaSans),
  colorScheme: ColorScheme.dark(
    surface: appColors.darkBg,
    onSurface: appColors.white,
    primary: appColors.mainPurple,
    onPrimary: appColors.white,
    primaryContainer: appColors.mainPurpleHover,
    secondary: appColors.white,
    onSecondary: appColors.mainPurple,
    secondaryContainer: appColors.white,
    outline: appColors.linesDark,
    tertiary: appColors.darkGrey,
    inversePrimary: appColors.mediumGrey,
    error: appColors.red,
    errorContainer: appColors.redHover,
  ),
);
