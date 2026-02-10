import 'package:flutter/material.dart';
import 'dart:async';

/// A widget that fades its [child] in when a [condition] is met.
///
/// The animation can be customized with a [duration] and a [delay].
/// The widget reacts to changes in the [condition], triggering the fade-in
/// animation when it becomes `true` and resetting (hiding the child)
/// when it becomes `false`.
class FadeInText extends StatefulWidget {
  const FadeInText({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.condition = true, // The new conditional parameter
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The duration of the fade-in animation.
  final Duration duration;

  /// The delay before the animation starts.
  final Duration delay;

  /// A boolean to control the animation. The fade-in animation is triggered
  /// only when this condition is `true`. Defaults to `true` for immediate animation.
  final bool condition;

  @override
  State<FadeInText> createState() => _FadeInTextState();
}

class _FadeInTextState extends State<FadeInText> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  Timer? _delayTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // If the initial condition is true, start the animation after the delay.
    if (widget.condition) {
      _startAnimation();
    }
  }

  /// This method is called whenever the widget's configuration changes.
  @override
  void didUpdateWidget(FadeInText oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if the condition has changed between widget updates.
    if (widget.condition != oldWidget.condition) {
      if (widget.condition) {
        // If the condition becomes true, trigger the fade-in.
        _startAnimation();
      } else {
        // If the condition becomes false, cancel any pending timer
        // and reset the controller to hide the widget.
        _delayTimer?.cancel();
        _controller.reset();
      }
    }
  }

  void _startAnimation() {
    // Cancel any existing timer to avoid multiple triggers.
    _delayTimer?.cancel();
    _delayTimer = Timer(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
