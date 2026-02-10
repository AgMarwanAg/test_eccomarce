import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../images/svg_image.dart';

class ImageBtn extends StatelessWidget {
  final String? image;
  final IconData? icon;
  final Color? color;
  final double? size;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;
  const ImageBtn({
    super.key,
    this.image,
    this.color,
    this.icon,
    this.size,
    this.onTap,
    this.width,
    this.height,
    this.backgroundColor,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        width: width ?? 34.w,
        height: height ?? 34.h,
        padding:padding,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Center(
          child: Builder(
            builder: (context) {
              if (image != null) {
                return SvgAsset(
                  image!,
                  height: size ?? 24.sp,
                  width: size ?? 24.sp,
                  color: color ?? AppColors.primaryColor,
                );
              }
              if (icon != null) {
                return Center(
                  child: Icon(
                    icon!,
                    color: color ?? AppColors.whiteColor,
                    size: size ?? 24.sp,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
