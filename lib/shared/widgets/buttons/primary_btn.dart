import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_spinner_widget.dart';
import '../images/svg_image.dart';
import '../text_widget.dart';

class PrimaryBtn extends StatefulWidget {
  final Color? color;
  final String? text;
  final BorderRadius? borderRadius;
  final void Function()? onPressed;
  final double? width;
  final double height;
  final Widget? child;
  final String? icon;
  final bool disabled, isLoading;
  final TextStyle? textStyle;
  const PrimaryBtn(
      {super.key,
      this.text,
      this.color,
      this.borderRadius,
      this.onPressed,
      this.width = double.infinity,
      this.height = 48,
      this.child,
      this.disabled = false,
      this.isLoading = false,
      this.icon,
      this.textStyle});

  @override
  State<PrimaryBtn> createState() => _PrimaryBtnState();
}

class _PrimaryBtnState extends State<PrimaryBtn> {
  @override
  Widget build(BuildContext context) {
    return (widget.disabled || widget.isLoading)
        ? _buildItem()
        : GestureDetector(
            onTap: widget.onPressed != null
                ? () {
                    widget.onPressed?.call();
                  }
                : null,
            child: _buildItem(),
          );
  }

  Widget _buildItem() {
    return Container(
        width: widget.width,
        height: widget.height.h,
        decoration: ShapeDecoration(
          color: widget.color ?? ((widget.disabled || widget.isLoading) ? AppColors.primaryDisabledColor : AppColors.primaryFontColor),
          shape: RoundedRectangleBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
          ),
        ),
        child: Builder(
          builder: (context) {
            if (widget.isLoading) {
              return const Center(
                child: AppSpinnerWidget(
                  color: AppColors.whiteColor,
                ),
              );
            }
            if (widget.icon != null) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.text != null)
                    TextWidget(
                      widget.text!,
                      textAlign: TextAlign.center,
                      style: widget.textStyle ?? AppTextStyle.s14W500.copyWith(color: AppColors.whiteColor),
                    ),
                  SvgAsset(
                    widget.icon!,
                  )
                ],
              );
            }
            if (widget.text != null) {
              return Center(
                child: TextWidget(
                  widget.text!,
                  textAlign: TextAlign.center,
                  style: widget.textStyle ?? AppTextStyle.primaryBtnTextStyle,
                ),
              );
            }
            return widget.child ?? const SizedBox.shrink();
          },
        ));
  }
}
