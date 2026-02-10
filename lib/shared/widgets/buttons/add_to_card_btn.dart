import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddToCardBtn extends StatelessWidget {
  const AddToCardBtn({
    super.key,
    this.onTap,
    this.size,
  });
final Function()? onTap;
final double? size;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all((1.5).r),
        // decoration: ShapeDecoration(color: AppColors.tertiaryColor, shape: CircleBorder()),
        child: Center(
          child: Icon(
            Icons.add,
            // color: AppColors.whiteColor,
            size:size?? 16.r,
          ),
        ),
      ),
    );
  }
}
