import 'package:flutter/material.dart';
 
import '../../../config/style/app_decoration.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/badge_widget.dart';
import '../../../shared/widgets/images/svg_image.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({super.key, required this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          fit: StackFit.passthrough,
          children: [
            Container(
              padding: EdgeInsets.all(16.sp),
              decoration: AppDecoration.floatingButtonDecoration,
              child: DecoratedBox(
                decoration: AppDecoration.floatingButtonShadow,
                child: SvgAsset(AppIcons.cart),
              ),
            ),
            BadgeWidget(count: '11')
          ],
        ),
      ),
    );
  }
}
