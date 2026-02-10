import 'package:flutter/material.dart';
/// A widget that wraps its child with a border.
///
/// This widget is useful when you want to conditionally add a border
/// to a widget, such as when it's disabled.
///
/// The border color, width, and radius can be customized.
///
/// If the [enabled] parameter is set to false, the widget won't
/// render a border.
///
/// The [borderRadius] parameter is optional. If it's not provided,
/// the widget will detect the radius of its child.
class BorderWrapper extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final bool enabled;

  const BorderWrapper({
    super.key,
    required this.child,
    this.borderColor = Colors.red,
    this.borderWidth = 1.0,
    this.borderRadius,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        borderRadius: borderRadius ?? _extractBorderRadius(child), // Detect child radius
      ),
      child: child,
    );
  }

  /// Attempts to extract `BorderRadius` from the child if it uses `BoxDecoration`.
  BorderRadius? _extractBorderRadius(Widget child) {
    if (child is Container && child.decoration is BoxDecoration) {
      final decoration = child.decoration as BoxDecoration;
      return decoration.borderRadius as BorderRadius?;
    }
    if (child is Card) {
      return child.shape is RoundedRectangleBorder
          ? (child.shape as RoundedRectangleBorder).borderRadius as BorderRadius?
          : null;
    }
    // Add cases for other widget types if needed.
    return null;
  }
}
enum BorderSide { top, right, bottom, left }

class GradientBorderPainter extends CustomPainter {
  final Gradient gradient;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final Set<BorderSide> sides;

  GradientBorderPainter({
    required this.gradient,
    required this.borderWidth,
    this.borderRadius,
    this.sides = const {BorderSide.top, BorderSide.right, BorderSide.bottom, BorderSide.left},
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final radius = borderRadius?.resolve(TextDirection.ltr).toRRect(rect) ??
        RRect.fromRectAndCorners(rect);

    final Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final Path path = Path();

    // Add top edge with top-left and top-right corners
    if (sides.contains(BorderSide.top)) {
      path.moveTo(radius.tlRadiusX, 0); // Start at top-left corner
      path.lineTo(size.width - radius.trRadiusX, 0); // Draw top edge
      path.arcToPoint(
        Offset(size.width, radius.trRadiusY), // Top-right corner curve
        radius: Radius.circular(radius.trRadiusX),
      );
    }

    // Add right edge with top-right and bottom-right corners
    if (sides.contains(BorderSide.right)) {
      path.moveTo(size.width, radius.trRadiusY); // Start at top-right corner
      path.lineTo(size.width, size.height - radius.brRadiusY); // Draw right edge
      path.arcToPoint(
        Offset(size.width - radius.brRadiusX, size.height), // Bottom-right corner curve
        radius: Radius.circular(radius.brRadiusX),
        clockwise: false,
      );
    }

    // Add bottom edge with bottom-right and bottom-left corners
    if (sides.contains(BorderSide.bottom)) {
      path.moveTo(size.width - radius.brRadiusX, size.height); // Start at bottom-right corner
      path.lineTo(radius.blRadiusX, size.height); // Draw bottom edge
      path.arcToPoint(
        Offset(0, size.height - radius.blRadiusY), // Bottom-left corner curve
        radius: Radius.circular(radius.blRadiusX),
        clockwise: false,
      );
    }

    // Add left edge with bottom-left and top-left corners
    if (sides.contains(BorderSide.left)) {
      path.moveTo(0, size.height - radius.blRadiusY); // Start at bottom-left corner
      path.lineTo(0, radius.tlRadiusY); // Draw left edge
      path.arcToPoint(
        Offset(radius.tlRadiusX, 0), // Top-left corner curve
        radius: Radius.circular(radius.tlRadiusX),
        clockwise: false,
      );
    }

    // Draw the path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant GradientBorderPainter oldDelegate) {
    return gradient != oldDelegate.gradient ||
        borderWidth != oldDelegate.borderWidth ||
        borderRadius != oldDelegate.borderRadius ||
        sides != oldDelegate.sides;
  }
}
