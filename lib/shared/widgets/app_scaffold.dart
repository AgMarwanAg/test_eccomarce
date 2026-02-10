import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/style/app_colors.dart';
import '../extensions/padding_ex.dart';
export 'package:go_router/go_router.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';

class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool centerTitle;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;
  final Color? backgroundColor;
  final Color? statusBarColor;
  final Widget? bottomSheet;
  final bool withSafeArea;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final PreferredSizeWidget? appBar;
  final double padding;
  const AppScaffold({
    super.key,
    this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.extendBody = false,
    this.centerTitle = true,
    this.resizeToAvoidBottomInset = true,
    this.backgroundColor,
    this.statusBarColor,
    this.withSafeArea = true,
    this.floatingActionButtonLocation,
    this.bottomSheet,
    this.appBar,
    this.padding = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(top: withSafeArea, child: body.paddingHorizontal(padding.w)),
      extendBody: extendBody,
      
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: SafeArea(child: bottomNavigationBar ?? SizedBox.shrink()),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor ?? AppColors.scaffoldBackgroundColor,
      bottomSheet: bottomSheet,
    );
  }
}
