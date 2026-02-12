import 'package:flutter/material.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';

class DottedDivider extends StatelessWidget {
  final double rectangleWidth;
  final double rectangleHeight;
  final double spaceBetweenRectangles;
  final Color? color;
  final double dividerWidth;
  final double dividerHeight;

  const DottedDivider({
    super.key,
    this.rectangleWidth = 8.0, // Width of each rectangle
    this.rectangleHeight = 2.0, // Height of each rectangle
    this.spaceBetweenRectangles = 8.0, // Space between rectangles
    this.color,
    this.dividerWidth = double.infinity, // Total width of the divider
    this.dividerHeight = 2.0, // Total height (thickness) of the divider
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(dividerWidth, dividerHeight),
      painter: _DottedRectPainter(
        rectangleWidth,
        rectangleHeight,
        spaceBetweenRectangles,
        color ?? AppColors.appDivider,
      ),
    );
  }
}

class _DottedRectPainter extends CustomPainter {
  final double rectangleWidth;
  final double rectangleHeight;
  final double spaceBetweenRectangles;
  final Color color;

  _DottedRectPainter(
    this.rectangleWidth,
    this.rectangleHeight,
    this.spaceBetweenRectangles,
    this.color,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double startX = 0.0;

    // Draw rectangles until we reach the end of the available width
    while (startX + rectangleWidth <= size.width) {
      canvas.drawRect(
        Rect.fromLTWH(
          startX,
          (size.height - rectangleHeight) / 2,
          rectangleWidth,
          rectangleHeight,
        ),
        paint,
      );
      startX +=
          rectangleWidth +
          spaceBetweenRectangles; // Move to the next rectangle position
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
