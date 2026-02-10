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
  static ShapeDecoration get floatingButtonDecoration => ShapeDecoration(
    color: AppColors.primaryColor,
    shape: const CircleBorder(
      side: BorderSide(color: AppColors.navBarColor, width: 10),
    ),
  );
  //shadows

  static BoxDecoration get floatingButtonShadow => BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Color(0x7F613EEA),
        blurRadius: 20,
        offset: Offset(0, 10),
        spreadRadius: 7,
      ),
    ],
  );
  static List<BoxShadow> productBoxShadow = [
    BoxShadow(
      color: Color(0x3F000000),
      blurRadius: 10,
      offset: Offset(0, 4),
      spreadRadius: 1,
      blurStyle: BlurStyle.inner,
    ),
  ];

  static BoxShadow settingListTileShadow = BoxShadow(
    color: Color(0x3F000000),
    blurRadius: 3,
    offset: Offset(0, 6),
  );
  static ShapeDecoration shadowDecoration = ShapeDecoration(
    color: AppColors.whiteColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
    shadows: [
      BoxShadow(
        color: Color(0x3F000000),
        blurRadius: 4,
        offset: Offset(2, 2),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Color(0x3F000000),
        blurRadius: 4,
        offset: Offset(-2, 1),
        spreadRadius: 0,
      ),
    ],
  );
  static ShapeDecoration shadowDecoration2 = ShapeDecoration(
    color: AppColors.whiteColor,
    shape: CircleBorder(),
    shadows: [
      BoxShadow(
        color: Color(0x3F000000),
        blurRadius: 4,
        offset: Offset(0, 0),
        spreadRadius: 0,
      ),
    ],
  );
}
