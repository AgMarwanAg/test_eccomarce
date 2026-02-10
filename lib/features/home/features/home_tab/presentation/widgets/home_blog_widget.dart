import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';
import 'package:test_eccomarce/config/style/app_decoration.dart';
import 'package:test_eccomarce/core/faker/dummy_network_image.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';
import 'package:test_eccomarce/shared/widgets/images/network_image.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

import '../../../../../../shared/widgets/horizontal_list.dart';

class HomeBlogWidget extends StatelessWidget {
  const HomeBlogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.homeBlogBGColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget('Blog', style: AppTextStyle.s18W700),
              TextWidget(
                'See all',
                style: AppTextStyle.s12W500.copyWith(
                  color: AppColors.fontGreyColor,
                ),
              ),
            ],
          ),
          HorizontalList(
            itemCount: 2,
            spacing: 12.w,
            itemBuilder: (context, index) =>
                _BuildItem(product: ProductModel.fromDummyList()[index]),
          ),
        ],
      ),
    );
  }
}

class _BuildItem extends StatefulWidget {
  final ProductModel product;
  const _BuildItem({required this.product});

  @override
  State<_BuildItem> createState() => _BuildItemState();
}

class _BuildItemState extends State<_BuildItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NetWorkImageWidget(
            url: DummyImage.placeholderImage(),
            width: double.infinity,
            height: 180.w,
            alignment: Alignment.center,
            fit: BoxFit.fill,
          ).paddingSymmetric(h: 10.w, v: 8.h),
          TextWidget(
            widget.product.category,
            style: AppTextStyle.s10W500.copyWith(color: AppColors.hintColors),
          ),
          TextWidget(widget.product.title, style: AppTextStyle.s12W700),
        ],
      ),
    );
  }
}
