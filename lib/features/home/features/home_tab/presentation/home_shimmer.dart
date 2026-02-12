import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_app_bar_widget.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_blog_widget.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_categories_widget.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_new_arrivals_widget.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_recommedation_widget.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_slider_widget.dart';
import 'package:test_eccomarce/shared/models/category_model.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';
import 'package:test_eccomarce/shared/widgets/shimmer/skeleton_widget.dart';
import 'package:test_eccomarce/shared/widgets/slivers/sliver_pin_delegate.dart';

import '../../../../../shared/extensions/_export.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonWidget(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverPinnedDelegate(
              child: HomeAppBarWidget().paddingHorizontal(20.w),
              minExtentValue: 89.h,
              maxExtentValue: 89.h,
            ),
          ),
          SliverToBoxAdapter(child: 16.sizeH),
          SliverToBoxAdapter(
            child: HomeSliderWidget(
              ads: ProductModel.fromDummyList()
                  .map((e) => e.thumbnail)
                  .toList(),
            ).paddingHorizontal(20.w),
          ),
          SliverToBoxAdapter(child: 32.sizeH),
          SliverToBoxAdapter(
            child: HomeCategoriesWidget(
              categories: CategoryModel.fromDummyList(),
            ).paddingHorizontal(20.w),
          ),
          SliverToBoxAdapter(child: 32.sizeH),
          SliverToBoxAdapter(
            child: HomeNewArrivalsWidget(
              products: ProductModel.fromDummyList(),
            ).paddingHorizontal(20.w),
          ),
          SliverToBoxAdapter(child: 32.sizeH),
          SliverToBoxAdapter(
            child: HomeRecommendedWidget(
              products: ProductModel.fromDummyList(),
            ).paddingHorizontal(20.w),
          ),
          SliverToBoxAdapter(child: 32.sizeH),
          SliverToBoxAdapter(child: HomeBlogWidget()),
        ],
      ),
    );
  }
}
