import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/style/app_colors.dart';
import 'text_widget.dart';

/// A widget that requires a double back press to exit.
/// Displays a non-intrusive overlay message instead of a SnackBar.
class DoublePressBackWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onExit;
  final Duration exitThreshold;
  final String message;
  final Duration messageDuration;
  final Future<bool> Function()? onWillPop;

  const DoublePressBackWidget({
    super.key,
    required this.child,
    this.onExit,
    this.onWillPop,
    this.exitThreshold = const Duration(seconds: 2),
    this.message = 'press_again_to_exit',
    this.messageDuration = const Duration(seconds: 1),
  });

  @override
  State<DoublePressBackWidget> createState() => _DoublePressBackWidgetState();
}

class _DoublePressBackWidgetState extends State<DoublePressBackWidget> {
  DateTime? _lastBackPress;
  OverlayEntry? _overlayEntry;
  Timer? _overlayTimer;

  Future<bool> _handleWillPop() async {
    final now = DateTime.now();

    // If this is the first back press or exceeded threshold -> show message.
    if (_lastBackPress == null || now.difference(_lastBackPress!) > widget.exitThreshold) {
      _lastBackPress = now;
      _showOverlayMessage(widget.message);
      return false;
    }

    widget.onExit?.call();
    return true;
  }

  void _showOverlayMessage(String message) {
    _overlayEntry?.remove();
    _overlayTimer?.cancel();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 100.h,
        left: 24.w,
        right: 24.w,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: 1,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TextWidget(message, style: AppTextStyle.s14W600.copyWith(color: AppColors.whiteColor)),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    _overlayTimer = Timer(widget.messageDuration, () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.onWillPop ?? _handleWillPop,
      child: widget.child,
    );
  }
}
