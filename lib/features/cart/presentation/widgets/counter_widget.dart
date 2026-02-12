import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

class CounterWidget extends StatelessWidget {
  final num quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CounterWidget({
    super.key,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 35.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.hintColors),
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onRemove,
            child: Icon(Icons.remove, size: 14.sp),
          ),

          TextWidget(
            quantity.toString(),
            style: AppTextStyle.s14W500,
            textAlign: TextAlign.center,
            withLocale: false,
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onAdd,
            child: Icon(Icons.add, size: 14.sp),
          ),
        ],
      ),
    );
  }
}
