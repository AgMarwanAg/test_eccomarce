import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/style/app_colors.dart';

// export 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.child,
    this.dontExpandChild = false,
    this.maxHeight,
    this.topPadding,
    this.backgroundColor,
    this.isDynamicHeight = false,
  });

  final Widget child;

  /// If true, the child will not be expanded.
  /// The default value is false.
  final bool dontExpandChild;

  /// The max height of the bottom sheet.
  final double? maxHeight;

  /// The top padding of the bottom sheet.
  final double? topPadding;

  /// The background color of the bottom sheet.
  /// The default value is [AppColors.whiteColor].
  final Color? backgroundColor;

  /// If true, the bottom sheet height will be dynamic based on content.
  /// The default value is false.
  final bool isDynamicHeight;

  /// The default of height of the bottom sheet.
  double get maxSheetHeight => 0.85.sh;

  /// The default of height of the bottom sheet when keyboard is open.
  double get maxSheetHeightWithKeyboard => 0.92.sh;

  /// Get the max height of the bottom sheet.
  double getMaxHeight(BuildContext context) {
    if (maxHeight != null) return maxHeight!;
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return keyboardIsOpen ? maxSheetHeightWithKeyboard : maxSheetHeight;
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    // debugModePrint('keyboardPadding = $keyboardIsOpen');

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            constraints: BoxConstraints(
              maxHeight: getMaxHeight(context),
              minHeight: isDynamicHeight
                  ? 0
                  : getMaxHeight(context) * 0.3, // Minimum 30% of max height
              minWidth: double.infinity,
            ),
            // padding: EdgeInsets.only(top: 20.h),
            decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            padding: EdgeInsets.only(
              bottom: keyboardIsOpen
                  ? MediaQuery.of(context).viewInsets.bottom
                  : 0.h,
            ),
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: topPadding ?? 20.h),
                  if (isDynamicHeight)
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: getMaxHeight(context) - (topPadding ?? 20.h),
                      ),
                      child: child,
                    )
                  else if (dontExpandChild)
                    child
                  else
                    Expanded(child: child),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Show the bottom sheet.
  ///
  /// [context] is the context of the widget.
  ///
  /// [builder] is the builder of the bottom sheet.
  ///
  /// [isScrollControlled] is if true, the bottom sheet will be scrollable.
  ///
  /// [backgroundColor] is the background color of the bottom sheet.
  ///
  /// [bodyBackgroundColor] is the background color of the body of the bottom sheet.
  ///
  /// [routeSettings] is the route settings of the bottom sheet.
  ///
  /// [dontExpandeChild] is if true, the child will not be expanded.
  ///
  /// [maxHeight] is the max height of the bottom sheet.
  ///
  /// [topPadding] is the top padding of the bottom sheet.
  ///
  /// [isDismissible] is if true, the bottom sheet will be dismissible.
  ///
  /// [canPop] is if true, the bottom sheet can be popped.
  ///
  /// [isDynamicHeight] is if true, the bottom sheet height will be dynamic based on content.
  ///
  /// Note: don't forget to add [ModalScrollController.of(context)] to the controller of the scrollable widget,
  /// if you want to pop the bottom sheet by scrolling.
  ///
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isScrollControlled = true,
    Color? backgroundColor,
    Color? bodyBackgroundColor,
    RouteSettings? routeSettings,
    bool dontExpandChild = true,
    double? maxHeight,
    double? topPadding,
    bool isDismissible = true,
    bool canPop = true,
    bool isDynamicHeight = false, // Add this parameter
  }) {
    // final BottomSheetThemeData sheetTheme = Theme.of(context).bottomSheetTheme;

    /// This is just to prevent the bottom sheet from being rebuilt
    /// after closing it by tapping back button on Android devices.
    Widget? child;

    // /// if context doesn't have navigator, use the navigator from NavigationService
    // if (Navigator.maybeOf(context) == null) {
    //   context = NavigationService.instance.navigationContext;
    // }

    return showModalBottomSheet<T>(
      context: context,
      enableDrag: isScrollControlled,
      backgroundColor: backgroundColor ?? Colors.transparent,
      isDismissible: isDismissible,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) {
        return child ??= WillPopScope(
          onWillPop: () async {
            if (canPop) {
              return true;
            }
            return false;
          },
          child: CustomBottomSheet(
            backgroundColor: bodyBackgroundColor,
            dontExpandChild: dontExpandChild,
            maxHeight: maxHeight,
            topPadding: topPadding,
            isDynamicHeight: isDynamicHeight, // Pass the parameter
            child: Builder(
              builder: (context) {
                // Wrap the builder with a Scrollbar and ensure proper scroll physics
                final widget = builder(context);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 35.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: AppColors.homeBlogBGColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    widget,
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
