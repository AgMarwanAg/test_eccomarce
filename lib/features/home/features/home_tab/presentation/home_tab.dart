import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_app_bar_widget.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_categories_widget.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_slider_widget.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/new_arrivals_widget.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/widgets/slivers/sliver_pin_delegate.dart';

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
            child: HomeAppBarWidget(),
            minExtentValue: 89.h,
            maxExtentValue: 89.h,
          ),
        ),
        SliverToBoxAdapter(child: HomeSliderWidget()),
        SliverToBoxAdapter(child: 32.sizeH),
        SliverToBoxAdapter(child: HomeCategoriesWidget()),
        SliverToBoxAdapter(child: 32.sizeH),
        SliverToBoxAdapter(child: NewArrivalsWidget()),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
