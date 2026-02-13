import 'package:flutter/material.dart';
import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';
import 'package:test_eccomarce/shared/widgets/images/svg_image.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

class SuccessOverlay {
  static OverlayEntry? _currentEntry;

  static void show(
    BuildContext context, {
    Duration duration = const Duration(seconds: 1),
  }) {
    if (_currentEntry != null) return;

    final overlay = Overlay.of(context);

    _currentEntry = OverlayEntry(
      builder: (_) =>
          _SuccessOverlayWidget(message: 'product added\n to the cart'),
    );

    overlay.insert(_currentEntry!);

    Future.delayed(duration, () {
      hide();
    });
  }

  static void hide() {
    _currentEntry?.remove();
    _currentEntry = null;
  }
}

class _SuccessOverlayWidget extends StatelessWidget {
  final String message;

  const _SuccessOverlayWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.blackColor.withValues(alpha: 0.40),
      child: Center(
        child: Container(
          width: 180.w,
          height: 180.w,
          decoration: BoxDecoration(
            color: AppColors.overLayBG,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15.sp),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.whiteColor),
                ),
                child: const Icon(Icons.check, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextWidget(
                message,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: AppTextStyle.s16W500.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
