import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/style/app_decoration.dart';
import '../../../shared/extensions/_export.dart';
import '../../../shared/widgets/images/svg_image.dart';
import '../../../shared/widgets/text_widget.dart';

class BottomNavigatorBarWidget extends StatefulWidget {
  static final double height = 40.h;

  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;

  const BottomNavigatorBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onIndexChanged,
  });

  @override
  State<BottomNavigatorBarWidget> createState() =>
      _BottomNavigatorBarWidgetState();
}

class _BottomNavigatorBarWidgetState extends State<BottomNavigatorBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 48.w),
      decoration: AppDecoration.navBarDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildItem(
                BottomBarModel(
                  index: 0,
                  selected: widget.selectedIndex == 0,
                  icon: AppIcons.home,
                ),
                index: 0,
              ),
              _buildItem(
                BottomBarModel(
                  index: 1,
                  icon: AppIcons.category,
                  selected: widget.selectedIndex == 1,
                ),
                index: 1,
              ),
              _buildItem(
                BottomBarModel(
                  index: 1,
                  icon: AppIcons.chat,
                  selected: widget.selectedIndex == 2,
                ),
                index: 1,
              ),
              _buildItem(
                BottomBarModel(
                  index: 1,
                  icon: AppIcons.cart,
                  selected: widget.selectedIndex == 3,
                ),
                index: 2,
              ),
              _buildItem(
                BottomBarModel(
                  index: 1,
                  icon: AppIcons.profile,
                  selected: widget.selectedIndex == 4,
                ),
                index: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BottomBarModel item, {required int index}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => widget.onIndexChanged(index),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: animation, child: child),
          );
        },
        child: SvgAsset(
          height: 24.sp,
          width: 24.sp,
          key: ValueKey<bool>(item.selected),
          item.icon,
          color: item.selected ? AppColors.blackColor : AppColors.hintColors,
        ),
      ),
    );
  }
}

class BottomBarModel {
  final int index;
  final String icon;
  final bool selected;

  BottomBarModel({
    required this.index,
    required this.icon,
    required this.selected,
  });
}
