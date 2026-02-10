import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/style/app_colors.dart';

class AppSpinnerWidget extends StatefulWidget {
  final Color? color;
  final double? size;

  const AppSpinnerWidget({
    super.key,
    this.color,
    this.size,
  });

  @override
  AppSpinnerWidgetState createState() => AppSpinnerWidgetState();
}

class AppSpinnerWidgetState extends State<AppSpinnerWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _animations = [];

  // Defines the vertical distance the dots will travel.
  final double _bounceHeight = 10.0;

  // Defines the number of dots to display.
  final int _dotCount = 3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    // The TweenSequence creates the up-and-down bounce effect for a single dot.
    final TweenSequence<double> bounceTween = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: -_bounceHeight),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -_bounceHeight, end: 0.0),
        weight: 50,
      ),
    ]);

    // Create a staggered animation for each dot.
    for (int i = 0; i < _dotCount; i++) {
      _animations.add(
        bounceTween.animate(
          CurvedAnimation(
            parent: _controller,
            // The Interval creates the "wave" effect by delaying each subsequent dot's animation.
            curve: Interval(
              i * 0.1, // Start delay
              0.5 + i * 0.1, // End time
              curve: Curves.easeInOut,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_dotCount, (index) {
            // Add spacing between dots, but not for the last one.
            return index == _dotCount - 1 ? _buildDot(index) : Row(children: [_buildDot(index), SizedBox(width: 5.w)]);
          }),
        );
      },
    );
  }

  /// Builds a single animated dot.
  Widget _buildDot(int index) {
    return Transform.translate(
      // The animation value is used to vertically shift the dot.
      offset: Offset(0, _animations[index].value),
      child: Container(
        width: widget.size ?? 12.sp,
        height: widget.size ?? 12.sp,
        decoration: BoxDecoration(
          color: widget.color ?? AppColors.primaryColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
