import 'package:flutter/material.dart';

@immutable
class AppColors {
  const AppColors._();

  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF0F172A);
  static const Color primaryColor = Color(0xFFA3E635);
  static const Color primaryDisabledColor = Color(0xFFD6E8A3);
  static const Color scaffoldBackgroundColor = whiteColor;
  static const Color appDivider = Color(0xFFF1F5F9);
  static const Color transparent = Colors.transparent;
  static const Color errorColor = Color(0xFFEF5350);
  static const Color navBarColor = whiteColor;

  //Font colors
  static const Color primaryFontColor = Color(0xFF0F172A);
  static Color fontGreyColor = const Color(0xFF6B7280);
  static const Color hintColors = Color(0xFF94A3B8);
  //Button colors

  //shimmer colors
  static Color highlightColor = primaryColor.withValues(alpha: 0.1);
  static const Color baseColor = Color(0xFFFFFFFF);

  //other colors
  static const Color successColor = Color(0xF233A83F);
  static const Color redColor = Color(0xFFCC0000);

  //border colors
  static const Color textFieldBorderColor = primaryColor;

  static Color getPaleColor({required Color color, double alpha = 0.6}) {
    return Color.alphaBlend(Colors.white.withValues(alpha: alpha), color);
  }
}
