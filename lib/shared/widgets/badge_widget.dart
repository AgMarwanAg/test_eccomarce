import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/style/app_colors.dart';
import 'animations/zoom_in_animation.dart';
import 'text_widget.dart';

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({
    super.key,
    required this.count,
    this.radius = 10,
  });

  final String count;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: count != '0',
      child: ZoomIn(
        key: ValueKey(count),
        duration: const Duration(milliseconds: 300),
        child: CircleAvatar(
          radius: radius.r,
          backgroundColor: AppColors.errorColor,
          child: FittedBox(
            child: TextWidget(
              count,
              style: AppTextStyle.s12W600.copyWith(color: Colors.white, height: 1),
              withLocale: false,
            ),
          ),
        ),
      ),
    );
  }
}
