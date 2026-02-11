import 'package:flutter/material.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';
import 'package:test_eccomarce/config/style/app_decoration.dart';
import 'package:test_eccomarce/shared/extensions/size_ex.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';
import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

class ProductDetailsDescription extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsDescription({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          product.category,
          style: AppTextStyle.s12W700.copyWith(color: AppColors.fontGreyColor),
        ),
        TextWidget(product.title, style: AppTextStyle.s24W700),
        8.sizeH,
        Row(
          children: [
            Icon(Icons.star_rounded, color: AppColors.starColor, size: 14.sp),
            TextWidget(product.rating.toString(), style: AppTextStyle.s14W600),
            8.sizeW,
            TextWidget(
              '(${product.reviewsCount} Reviews)',
              style: AppTextStyle.s14W600.copyWith(
                color: AppColors.fontGreyColor,
              ),
            ),
          ],
        ),
        8.sizeH,
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${product.price} USD',
                style: AppTextStyle.s24W700,
              ),
              WidgetSpan(child: 6.sizeW),
              TextSpan(
                text: '${product.priceAfterDiscount} USD',
                style: AppTextStyle.s14W400.copyWith(
                  color: AppColors.textFontGreyColor,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              WidgetSpan(child: 8.sizeW),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: AppDecoration.discountCard,
                  child: TextWidget(
                    '-${product.discountPercentage}%',
                    style: AppTextStyle.s12W700.copyWith(
                      color: AppColors.primaryDarkColor,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ],
          ),
          maxLines: 1,
          overflow: TextOverflow.clip,
        ),
      ],
    );
  }
}
