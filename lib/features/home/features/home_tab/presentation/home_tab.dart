import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_app_bar_widget.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_blog_widget.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_categories_widget.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_slider_widget.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_new_arrivals_widget.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/widgets/slivers/sliver_pin_delegate.dart';

import 'widgets/home_recommedation_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverPinnedDelegate(
            child: HomeAppBarWidget().paddingHorizontal(20.w),
            minExtentValue: 89.h,
            maxExtentValue: 89.h,
          ),
        ),
        SliverToBoxAdapter(child: HomeSliderWidget().paddingHorizontal(20.w)),
        SliverToBoxAdapter(child: 32.sizeH),
        SliverToBoxAdapter(
          child: HomeCategoriesWidget().paddingHorizontal(20.w),
        ),
        SliverToBoxAdapter(child: 32.sizeH),
        SliverToBoxAdapter(
          child: HomeNewArrivalsWidget().paddingHorizontal(20.w),
        ),
        SliverToBoxAdapter(child: 32.sizeH),
        SliverToBoxAdapter(
          child: HomeRecommendedWidget().paddingHorizontal(20.w),
        ),
        SliverToBoxAdapter(child: 32.sizeH),
        SliverToBoxAdapter(child: HomeBlogWidget()),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
