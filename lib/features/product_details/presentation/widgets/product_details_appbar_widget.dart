import 'package:flutter/material.dart';
import 'package:test_eccomarce/shared/extensions/padding_ex.dart';
import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';
import 'package:test_eccomarce/shared/widgets/buttons/back_btn.dart';
import 'package:test_eccomarce/shared/widgets/images/svg_image.dart';

class ProductDetailsAppBarWidget extends StatelessWidget {
  const ProductDetailsAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [BackBtnWidget(withBorder: true), SvgAsset(AppIcons.cart)],
    ).paddingVertical(16.h);
  }
}
