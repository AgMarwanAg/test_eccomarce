import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
export '../../../config/style/app_colors.dart';
export '../../../config/const/app_icons.dart';
class SvgAsset extends StatelessWidget {
  const SvgAsset(
    this.path, {
    this.width,
    this.height,
    this.color,
    this.fit,
    this.size,
    super.key,
  });
  final String path;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: size?? width,
      height:size?? height,
      //ignore: deprecated_member_use
      color: color,
      fit: fit ?? BoxFit.contain,
      
    );
  }
}
