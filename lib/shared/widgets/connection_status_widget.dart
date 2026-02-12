import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

class ConnectionStatusWidget extends StatelessWidget {
  final bool isOnline;
  const ConnectionStatusWidget({super.key, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.sp),
      decoration: BoxDecoration(
        color: isOnline ? AppColors.successColor : AppColors.errorColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        children: [
          Icon(
            isOnline ? Icons.wifi : Icons.wifi_off,
            color: AppColors.whiteColor,
            size: 20.w,
          ),
          5.sizeW,
          TextWidget(
            isOnline ? 'online' : 'offline',
            style: AppTextStyle.s12W500.copyWith(color: AppColors.whiteColor),
          ),
        ],
      ),
    );
  }
}
