import 'package:flutter/material.dart';

import '../../shared/widgets/app_scaffold.dart';
import 'app_colors.dart';

class AppDecoration {
  AppDecoration._();
  static BoxDecoration get navBarDecoration => BoxDecoration(
    color: AppColors.navBarColor,
    border: BoxBorder.fromSTEB(
      top: BorderSide(color: AppColors.appDivider, width: 2.w),
    ),
  );
  static BoxDecoration get whiteRounded => BoxDecoration(
    color: AppColors.whiteColor,
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(60, 123, 123, 123),
        blurRadius: 1,
        offset: Offset(0, 4),
        spreadRadius: 0,
      ),
    ],
  );

  static BoxDecoration get categoryItem => BoxDecoration(
    borderRadius: BorderRadius.circular(16.r),
    border: Border.all(color: AppColors.appDivider),
  );
  static BoxDecoration get productCard => BoxDecoration(
    borderRadius: BorderRadius.circular(24.r),
    border: Border.all(color: AppColors.appDivider),
  );
  static ShapeDecoration get discountCard=>ShapeDecoration(
    color: AppColors.primaryDisabledColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(99.r),
    ),
  );
}
