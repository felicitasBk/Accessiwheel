import 'package:flutter/material.dart';

class AppColors {
  // Private constructor
  AppColors._();

  // ---------- (Amber) Light theme ----------
  static const MaterialColor primaryColorSwatch =
      MaterialColor(0xffffc637, <int, Color>{
    50: Color(0xffffc637),
    100: Color(0xffffc637),
    200: Color(0xffffc637),
    300: Color(0xffffc637),
    400: Color(0xffffc637),
    500: Color(0xffffc637),
    600: Color(0xffffc637),
    700: Color(0xffffc637),
    800: Color(0xffffc637),
    900: Color(0xffffc637),
  });
  static Color amberBackgroundColor = const Color.fromRGBO(255, 223, 127, .3);
  static Color amberPanelColor = const Color(0xfffff2cb);

  static Color amberTitleTextColor = const Color(0xff3d2c2e);
  static Color amberSubtitleTextColor = const Color(0xff3d2c00);
  static Color amberLabelTextColor = const Color(0xfff6ae2d);

  static Color amberGradientFirstColor = const Color(0xffffbf00);
  static Color amberGradientSecondColor = const Color(0xffffca28);

  static Color greyIconButtonBorderColor = const Color(0xffe0e0e0);
  
  // ---------- (Amber) Dark theme ----------
  static const hoverColorDark = Colors.black;
  static const bodyTextColorDark = Colors.black;
  static final darkGreyBackgroundColor = Colors.grey[800];
  static final greyBackgroundColor = Colors.grey[600];
}
