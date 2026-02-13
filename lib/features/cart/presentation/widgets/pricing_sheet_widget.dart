import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/config/style/app_decoration.dart';
import 'package:test_eccomarce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/widgets/buttons/primary_btn.dart';
import 'package:test_eccomarce/shared/widgets/images/svg_image.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

class PricingSheetWidget extends StatelessWidget {
  const PricingSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Container(
          decoration: AppDecoration.pricingSheet,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget('Total:', style: AppTextStyle.s18W700),
                  TextWidget(
                    "${state.getCartTotalAmount().toStringAsFixed(2)} USD",
                    style: AppTextStyle.s20W600,
                  ),
                ],
              ),
              7.sizeH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    'Order and get 34 points',
                    style: AppTextStyle.s12W400.copyWith(
                      color: AppColors.hintColors,
                    ),
                  ),
                  TextWidget(
                    'Free shipping',
                    style: AppTextStyle.s12W400.copyWith(
                      color: AppColors.hintColors,
                    ),
                  ),
                ],
              ),
              10.sizeH,
              PrimaryBtn(
                color: AppColors.blackColor,
                text: 'Proceed to Checkout',
                textStyle: AppTextStyle.primaryBtnTextStyle.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ).paddingSymmetric(h: 24.w, v: 16.h),
        );
      },
    );
  }
}
