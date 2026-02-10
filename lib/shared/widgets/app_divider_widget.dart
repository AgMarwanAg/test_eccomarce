import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/style/app_colors.dart';

class AppDividerWidget extends StatelessWidget {
  final double? height,width, paddingW, paddingH;
  final Color? color;
  const AppDividerWidget({super.key, this.height,this.width, this.paddingW, this.paddingH, this.color,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?? double.infinity,
      height: height ?? 1.h,
      margin: EdgeInsets.symmetric(horizontal: paddingW ?? 0, vertical: paddingH ?? 0),
      decoration: BoxDecoration(
        color: color ?? AppColors.appDivider,
      ),
    );
  }
}

class VerticalDividerWidget extends StatelessWidget {
  final double? height, width;
  final Color? color;
  const VerticalDividerWidget({super.key, this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? AppColors.appDivider,
      width: width ?? 1.w,
      height: height ?? 31.h,
    );
  }
}
