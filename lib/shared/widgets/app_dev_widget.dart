import 'package:flutter/material.dart';

import '../../config/style/app_colors.dart';
/// A widget that glows around the provided [child] widget.
///
/// Useful for visually distinguishing development builds from production builds.
///
/// The [glowColor] defaults to [AppColors.redColor].
/// The [glowRadius] defaults to 6.0 logical pixels.
/// The [duration] defaults to a duration of 3 seconds.
///
/// The glow effect is achieved using a [TweenAnimation] to animate the
/// opacity of a [Container] widget with a [DecoratedBox] that has a
/// [BoxDecoration] with a [BoxShadow] applied to it.
class AppDevWidget extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final double glowRadius;
  final Duration duration;

  const AppDevWidget({
    super.key,
    required this.child,
    this.glowColor = AppColors.redColor,
    this.glowRadius = 10,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<AppDevWidget> createState() => _AppDevWidgetState();
}

class _AppDevWidgetState extends State<AppDevWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withValues(alpha: _glowAnimation.value),
                blurRadius: widget.glowRadius,
                spreadRadius: _glowAnimation.value * 2,
              ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
