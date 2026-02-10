import 'package:flutter/material.dart';

class DisableWidget extends StatelessWidget {
  /// This widget is used to wrap a widget to disable it.
  /// It is used to disable a widget when a condition is true.
  ///
  /// It also can be used to wrap a widget to make it transparent when a condition is true.
  ///
  const DisableWidget({
    super.key,
    required this.child,
    this.condition = true,
    this.withOpacity = true,
    this.opacity = 0.6,
    this.opacityDuration = const Duration(milliseconds: 200),
  });

  final Widget child;

  /// If true, the widget will be disabled.
  final bool condition;

  /// If true, the widget will be transparent when [condition] is true.
  final bool withOpacity;

  /// The opacity value when [condition] is true.
  /// The default value is 0.6.
  /// Note: This value is only used when [withOpacity] is true.
  final double opacity;

  /// The opacity duration when [condition] is true, to animate the opacity.
  final Duration opacityDuration;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: condition,
      child: withOpacity
          ? AnimatedOpacity(
              duration: opacityDuration,
              opacity: !condition ? 1 : opacity,
              child: child,
            )
          : child,
    );
  }
}
