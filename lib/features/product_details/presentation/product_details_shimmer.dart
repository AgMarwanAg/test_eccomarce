import 'package:flutter/material.dart';
import 'package:test_eccomarce/features/product_details/presentation/widgets/product_details_appbar_widget.dart';
import 'package:test_eccomarce/features/product_details/presentation/widgets/product_details_carousel.dart';
import 'package:test_eccomarce/features/product_details/presentation/widgets/product_details_description.dart';
import 'package:test_eccomarce/features/product_details/presentation/widgets/product_sizes_widget.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';
import 'package:test_eccomarce/shared/widgets/shimmer/skeleton_widget.dart';

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonWidget(
      child: Column(
        children: [
          ProductDetailsAppBarWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductDetailsCarousel(images: ['']),
                  16.sizeH,
                  ProductDetailsDescription(
                    product: ProductModel.fromDummyList()[0],
                  ),
                  24.sizeH,

                  ProductSizesWidget(sizes: ['tag1', 'tag2', 'tag3', 'tag4']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
