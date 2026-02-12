import 'package:flutter/material.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';
import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';
import 'package:test_eccomarce/shared/widgets/product_item_widget.dart';
import 'package:test_eccomarce/shared/widgets/shimmer/skeleton_widget.dart';

class SearchScreenShimmer extends StatelessWidget {
  const SearchScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonWidget(
      child: GridView.builder(
                        padding: EdgeInsets.only(bottom: 20.h),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 10.h,
                          crossAxisSpacing: 10.w,
                        ),
                        itemCount: ProductModel.fromDummyList().length,
                        itemBuilder: (context, index) {
                          return ProductItemWidget(
                            product: ProductModel.fromDummyList()[index],
                            isFavorite: false, // Update logic if needed
                          );
                        },
                      ),
    );
  }
}