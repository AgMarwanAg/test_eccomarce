import 'package:flutter/material.dart';
export '/config/const/app_images.dart';
class AssetImageWidget extends StatelessWidget {
  final String name;
  final double? height, width;
  final BoxFit? fit;
  final Color? color;
  final AlignmentGeometry alignment;
  final BorderRadiusGeometry? borderRadius;
  const AssetImageWidget(
    this.name, {
    super.key,
    this.height,
    this.width,
    this.fit,
    this.color,
    this.borderRadius,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.asset(
        name,
        width: width,
        height: height,
        fit: fit,
        color: color,
        alignment: alignment,
         
      ),
    );
  }
}
