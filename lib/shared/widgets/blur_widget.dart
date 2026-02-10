import 'dart:ui';

import 'package:flutter/material.dart';

class BlurWidget extends StatelessWidget {
  final Widget child;
  final double blurRadius;
  const BlurWidget({super.key, required this.child, this.blurRadius = 5.0});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: blurRadius,
        sigmaY: blurRadius,
        tileMode: TileMode.decal,
      ),
      child: child,
    );
  }
}
