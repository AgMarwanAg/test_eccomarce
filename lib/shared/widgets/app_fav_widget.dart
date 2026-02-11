import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/style/app_colors.dart';

class AppFavWidget extends StatelessWidget {
  final bool isFav;
  final ValueChanged<bool>? onChanged;
  final double? size;
  final Color? activeColor;
  final Color? inactiveColor;

  const AppFavWidget({
    super.key,
    required this.isFav,
    this.onChanged,
    this.size,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged?.call(!isFav),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.6, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
            ),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: Icon(
          isFav ? Icons.favorite : Icons.favorite_border_outlined,
          key: ValueKey(isFav),
          color: isFav
              ? (activeColor ?? AppColors.primaryColor)
              : (inactiveColor ?? AppColors.blackColor),
          size: size ?? 18.sp,
        ),
      ),
    );
  }
}
