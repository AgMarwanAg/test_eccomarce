import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';
import 'package:test_eccomarce/shared/widgets/horizontal_list.dart';
import 'package:test_eccomarce/shared/widgets/images/network_image.dart';
import 'package:test_eccomarce/shared/widgets/images/svg_image.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

class HomeSliderWidget extends StatelessWidget {
  final List<ProductModel> products;
  final bool isLoading;
  const HomeSliderWidget({super.key, required this.products,required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return HorizontalList(
      itemCount: products.length,
      spacing: 10.w,
      itemBuilder: (context, index) {
        final product = products[index];
        return Container(
          width: context.width * 0.75,
          height: 250.h,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.r),
            gradient:isLoading?null:  LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors:  index % 2 == 0
                  ? [AppColors.primaryColor, AppColors.textPrimary]
                  : [Color(0xFFAC9F97), Color(0xFFD4C5B9)],
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      product.brand,
                      style: AppTextStyle.s14W500.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    6.sizeH,
                    TextWidget(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.s20W700.copyWith(
                        color: Colors.black,
                        height: 0.9,
                      ),
                    ),
                    8.sizeH,
                    TextWidget(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.s13W400,
                    ),
                    16.sizeH,
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blackColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: TextWidget(
                        'BUY NOW',
                        style: AppTextStyle.s14W600.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              NetWorkImageWidget(
                url: product.thumbnail,
                height: 170.h,
                width: 110.w,
                fit: BoxFit.cover,
              ),
            ],
          ),
        );
      },
    );
  }
}
