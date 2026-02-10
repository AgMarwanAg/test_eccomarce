import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/style/app_decoration.dart';
import '../../../shared/extensions/_export.dart';
import '../../../shared/widgets/images/svg_image.dart';

class BottomNavigatorBarWidget extends StatelessWidget {
  static final double height = 40.h;

  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;

  const BottomNavigatorBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onIndexChanged,
  });

  static const List<String> _icons = [
    AppIcons.home,
    AppIcons.category,
    AppIcons.chat,
    AppIcons.cart,
    AppIcons.profile,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 48.w),
      decoration: AppDecoration.navBarDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          _icons.length,
          (index) => _BottomNavItem(
            icon: _icons[index],
            selected: selectedIndex == index,
            onTap: () => onIndexChanged(index),
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final String icon;
  final bool selected;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 300),
        scale: selected ? 1.1 : 1.0,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: selected ? 1 : 0.6,
          child: SvgAsset(
            height: 24.sp,
            width: 24.sp,
            icon,
            color: selected ? AppColors.blackColor : AppColors.hintColors,
          ),
        ),
      ),
    );
  }
}
