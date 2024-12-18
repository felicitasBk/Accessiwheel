import 'package:flutter/material.dart';
import 'package:wheelmap/common/constants/app_colors.dart';

final ThemeData amberTheme = ThemeData(
    textTheme: TextTheme(
      headlineLarge: TextStyle(
          color: AppColors.amberTitleTextColor,
          fontSize: 32,
          fontWeight: FontWeight.w700),
      headlineMedium: const TextStyle(
          color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
      titleLarge: TextStyle(
          color: AppColors.amberSubtitleTextColor,
          fontSize: 22,
          fontWeight: FontWeight.w700),
      titleMedium: const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
      labelLarge: TextStyle(
          color: AppColors.amberLabelTextColor,
          fontSize: 18,
          fontWeight: FontWeight.w500),
      labelMedium: TextStyle(color: AppColors.amberLabelTextColor),
      bodyLarge: TextStyle(
        color: AppColors.amberSubtitleTextColor,
      ),
      bodyMedium: TextStyle(
        color: AppColors.amberSubtitleTextColor,
      ),
    ),
    primarySwatch: AppColors.primaryColorSwatch,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      error: const Color(0xffb00020),
      onBackground: AppColors.amberSubtitleTextColor,
      onError: Colors.black,
      onPrimary: Colors.white,
      onSecondary: AppColors.amberSubtitleTextColor,
      onSurface: AppColors.amberSubtitleTextColor,
      surface: Colors.white,
      background: Colors.white,
      primary: AppColors.amberGradientFirstColor,
      secondary: AppColors.amberGradientSecondColor,
    )
    );

final ThemeData darkTheme = ThemeData(
  hoverColor: AppColors.hoverColorDark,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: AppColors.bodyTextColorDark,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
    ),
    displayLarge: TextStyle(
      color: Colors.black87,
    ),
    displaySmall: TextStyle(
      color: Colors.white,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkGreyBackgroundColor,
    unselectedItemColor: Colors.white,
  ),
  scaffoldBackgroundColor: AppColors.darkGreyBackgroundColor,
  backgroundColor: AppColors.darkGreyBackgroundColor,
  bottomAppBarTheme: BottomAppBarTheme(
    color: AppColors.greyBackgroundColor,
  ),
  appBarTheme: AppBarTheme(
    color: AppColors.darkGreyBackgroundColor,
  ),
);
