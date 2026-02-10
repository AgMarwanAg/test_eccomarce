import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/widgets/text_widget.dart';
import '../style/app_colors.dart';

//Not Finished yet
class AppTheme {
  static final lightTheme = ThemeData(
    fontFamily: 'Inter',
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: AppTextStyle.textLabelStyle,
      hintStyle: AppTextStyle.textHintStyle,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.textFieldBorderColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.errorColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.errorColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.textFieldBorderColor,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.blackColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      // checkColor: WidgetStateProperty.all(AppColors.whiteColor),
      // fillColor: MaterialStateProperty.all(AppColors.primaryColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
    ),
  );
}

// extension CustomTheme on ThemeData {
//   Color get defult => brightness == Brightness.light ? AppColors.cardBGDark : AppColors.whiteColor;
// }
