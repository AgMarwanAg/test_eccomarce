import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';
import 'package:test_eccomarce/config/style/app_decoration.dart';
import 'package:test_eccomarce/core/faker/dummy_network_image.dart';
import 'package:test_eccomarce/features/product_details/presentation/widgets/product_details_appbar_widget.dart';
import 'package:test_eccomarce/features/product_details/presentation/widgets/product_details_carousel.dart';
import 'package:test_eccomarce/features/product_details/presentation/widgets/product_details_description.dart';
import 'package:test_eccomarce/features/product_details/presentation/widgets/product_sizes_widget.dart';
import 'package:test_eccomarce/shared/extensions/size_ex.dart';
import 'package:test_eccomarce/shared/extensions/widget_ex.dart';
import 'package:test_eccomarce/shared/widgets/app_fav_widget.dart';
import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';
import 'package:test_eccomarce/shared/widgets/buttons/primary_btn.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int id;
  const ProductDetailsScreen({super.key, required this.id});
  static const String path = '/product_details';
  static void push(BuildContext context, {required int id}) {
    context.push(path, extra: id);
  }

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: 24.w,
      body: Column(
        children: [
          ProductDetailsAppBarWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductDetailsCarousel(
                    images: [
                      DummyImage.placeholderImage(),
                      DummyImage.placeholderImage(),
                      DummyImage.placeholderImage(),
                      DummyImage.placeholderImage(),
                    ],
                  ),
                  16.sizeH,
                  ProductDetailsDescription(),
                  24.sizeH,

                  ProductSizesWidget(sizes: ["size1", "size2"]),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(24.sp),
        decoration: AppDecoration.navBarDecoration.copyWith(
          color: AppColors.whiteColor.withValues(alpha: 0.80),
        ),
        child: Row(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.appDivider, width: 2),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: AppFavWidget(isFav: false),
            ),
            16.sizeW,
            PrimaryBtn(text: 'Add to Cart').expanded(),
          ],
        ),
      ),
    );
  }
}
