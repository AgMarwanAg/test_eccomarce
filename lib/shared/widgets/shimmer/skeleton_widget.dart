import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../config/style/app_colors.dart';

class SkeletonWidget extends StatelessWidget {
  final Widget child;
  final bool enabled;
  const SkeletonWidget({super.key, required this.child, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enabled,
      ignorePointers: true,
      containersColor: AppColors.highlightColor,
      effect: ShimmerEffect(
        baseColor: AppColors.baseColor,
        highlightColor: AppColors.highlightColor,
      ),
      child: child,
    );
  }
}
