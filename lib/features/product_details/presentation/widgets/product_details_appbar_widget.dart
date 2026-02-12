import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_eccomarce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:test_eccomarce/features/cart/presentation/cart_screen.dart';
import 'package:test_eccomarce/shared/extensions/padding_ex.dart';
import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';
import 'package:test_eccomarce/shared/widgets/badge_widget.dart';
import 'package:test_eccomarce/shared/widgets/buttons/back_btn.dart';
import 'package:test_eccomarce/shared/widgets/images/svg_image.dart';

class ProductDetailsAppBarWidget extends StatelessWidget {
  const ProductDetailsAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackBtnWidget(withBorder: true),
        GestureDetector(
          onTap: () {
            CartScreen.push(context, isFullScreen: true);
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SvgAsset(AppIcons.cart),
              PositionedDirectional(
                top: -10,
                end: -10,
                child: BadgeWidget(
                  count: context.watch<CartBloc>().state.getCartItemCount(),
                ),
              ),
            ],
          ),
        ),
      ],
    ).paddingVertical(16.h);
  }
}
