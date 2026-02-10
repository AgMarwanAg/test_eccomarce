import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';
import 'package:test_eccomarce/config/style/app_decoration.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget('welcome back,', style: AppTextStyle.s12W500),
              TextWidget('Olivia', style: AppTextStyle.s20W700),
            ],
          ),
          Container(
            height: 40.h,
            width: 40.w,
            decoration: AppDecoration.whiteRounded,
            child: Center(child: Icon(Icons.search_rounded, size: 20.w)),
          ),
        ],
      ).paddingVertical(16.h),
    );
  }
}
