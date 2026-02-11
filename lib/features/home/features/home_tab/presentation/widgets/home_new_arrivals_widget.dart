import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';
import 'package:test_eccomarce/config/style/app_decoration.dart';
import 'package:test_eccomarce/core/faker/dummy_network_image.dart';
import 'package:test_eccomarce/features/product_details/presentation/product_details_screen.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';
import 'package:test_eccomarce/shared/widgets/images/network_image.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

import '../../../../../../shared/widgets/horizontal_list.dart';
import '../../../../../../shared/widgets/app_fav_widget.dart';

class HomeNewArrivalsWidget extends StatelessWidget {
  const HomeNewArrivalsWidget({super.key});

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
          itemCount: 10,
          spacing: 16.w,
          itemBuilder: (context, index) => _BuildItem(
            product: ProductModel.fromDummyList()[index],
            isFavorate: index % 2 == 0,
          ),
        ),
      ],
    );
  }
}

class _BuildItem extends StatefulWidget {
  final ProductModel product;
  final bool isFavorate;
  const _BuildItem({required this.product, required this.isFavorate});

  @override
  State<_BuildItem> createState() => _BuildItemState();
}

class _BuildItemState extends State<_BuildItem> {
  late bool isFav = widget.isFavorate;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ProductDetailsScreen.push(context, id: widget.product.id);
      },
      child: Container(
        width: 155.w,
        padding: EdgeInsets.all(12.w),
        decoration: AppDecoration.productCard,
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NetWorkImageWidget(
                  url: DummyImage.placeholderImage(),
                  width: 112.w,
                  height: 112.w,
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                ).paddingSymmetric(h: 10.w, v: 8.h),
                12.sizeH,
                TextWidget(
                  widget.product.category,
                  style: AppTextStyle.s10W500.copyWith(
                    color: AppColors.hintColors,
                  ),
                ),
                TextWidget(widget.product.title, style: AppTextStyle.s12W700),
                Container(
                  padding: EdgeInsetsDirectional.only(
                    start: 6.w,
                    top: 6.h,
                    bottom: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.appDivider,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        "${widget.product.price} USD",
                        style: AppTextStyle.s12W700,
                      ),
                      Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.blackColor,
                        ),
                        child: Icon(
                          Icons.add,
                          color: AppColors.whiteColor,
                          size: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppFavWidget(
              isFav: isFav,
              onChanged: (value) => setState(() => isFav = value),
            ),
          ],
        ),
      ),
    );
  }
}
