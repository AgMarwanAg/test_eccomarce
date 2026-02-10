import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Size get size => MediaQuery.sizeOf(this);
  double get mediaQueryShortestSide => size.shortestSide;

  double get keyboardBottomPadding => MediaQuery.of(this).viewInsets.bottom;

  bool get isKeyboardOpen => keyboardBottomPadding > 0;

  double get height => size.height;

  double get width => size.width;

  bool get isPhone => (mediaQueryShortestSide < 600);
  bool get isSmallTablet => (mediaQueryShortestSide >= 600);
  bool get isLargeTablet => (mediaQueryShortestSide >= 720);
  bool get isTablet => isSmallTablet || isLargeTablet;

  double get statusBarHeight => MediaQuery.of(this).padding.top;
  ScaffoldState get scaffoldState => Scaffold.of(this);
  double get bottomPadding => MediaQuery.of(this).viewInsets.bottom + MediaQuery.of(this).padding.bottom;

  void requestFocus(FocusNode focus) {
    FocusScope.of(this).requestFocus(focus);
  }

  void unFocus(FocusNode focus) {
    focus.unfocus();
  }

  bool ensureVisible({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.ease,
    double alignment = 0,
  }) {
    try {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (Scrollable.maybeOf(this) == null || findRenderObject() == null) {
          throw Exception('EnsureVisible: context is not scrollable');
        }
        Scrollable.of(this).position.ensureVisible(
              findRenderObject()!,
              duration: duration,
              curve: curve,
              alignment:alignment,
            );
      });
    } catch (e) {
      return false;
    }

    return true;
  }
}
