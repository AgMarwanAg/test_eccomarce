import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';
import 'package:test_eccomarce/config/style/app_decoration.dart';
import 'package:test_eccomarce/features/product_details/presentation/product_details_screen.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';
import 'package:test_eccomarce/shared/widgets/images/network_image.dart';
import 'package:test_eccomarce/shared/widgets/product_item_widget.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

import '../../../../../../shared/widgets/horizontal_list.dart';
import '../../../../../../shared/widgets/app_fav_widget.dart';

class HomeNewArrivalsWidget extends StatelessWidget {
  final List<ProductModel> products;
  const HomeNewArrivalsWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget('New arrivals', style: AppTextStyle.s18W700),
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
