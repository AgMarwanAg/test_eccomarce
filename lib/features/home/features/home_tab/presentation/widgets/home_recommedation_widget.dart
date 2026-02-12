import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';
import 'package:test_eccomarce/shared/widgets/product_item_widget.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

import '../../../../../../shared/widgets/horizontal_list.dart';

class HomeRecommendedWidget extends StatelessWidget {
  final List<ProductModel> products;
  const HomeRecommendedWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget('Recommended for you', style: AppTextStyle.s18W700),
            TextWidget(
              'See all',
              style: AppTextStyle.s12W500.copyWith(
                color: AppColors.fontGreyColor,
              ),
            ),
          ],
        ),
        16.sizeH,
        HorizontalList(
          itemCount: products.length,
          spacing: 16.w,
          itemBuilder: (context, index) => ProductItemWidget(
            product: products[index],
            isFavorite: index % 2 == 0,
          ),
        ),
      ],
    );
  }
}
