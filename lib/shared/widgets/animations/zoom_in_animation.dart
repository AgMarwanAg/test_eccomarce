import 'package:flutter/material.dart';

class ZoomIn extends StatefulWidget {
  const ZoomIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.initialScale = 0.5,
    this.finalScale = 1.0,
    this.curve = Curves.fastOutSlowIn,
  });

  final Widget child;
  final Duration duration;
  final double initialScale;
  final double finalScale;
  final Curve curve;

  @override
  State<ZoomIn> createState() => _ZoomInState();
}

class _ZoomInState extends State<ZoomIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(
      begin: widget.initialScale,
      end: widget.finalScale,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}