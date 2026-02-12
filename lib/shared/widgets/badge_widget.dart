import 'package:flutter/material.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';
import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

class BadgeWidget extends StatelessWidget {
  final num count;

  const BadgeWidget({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      switchInCurve: Curves.easeOutBack,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: count > 0
          ? TweenAnimationBuilder<double>(
              key: ValueKey(count),
              duration: const Duration(seconds: 1),
              tween: Tween(begin: 0.7, end: 1),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(scale: value, child: child);
              },
              child: _Badge(count: count),
            )
          : const SizedBox.shrink(),
    );
  }
}

class _Badge extends StatelessWidget {
  final num count;

  const _Badge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 20.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.blackColor,
        border: Border.all(color: AppColors.whiteColor, width: 3),
      ),
      alignment: Alignment.center,
      child: FittedBox(
        child: TextWidget(
          count.toString(),
          style: AppTextStyle.s16W700.copyWith(color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
