import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/cubit/get_home_cubit.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/home_shimmer.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_app_bar_widget.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_blog_widget.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_categories_widget.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_slider_widget.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_new_arrivals_widget.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/widgets/slivers/sliver_pin_delegate.dart';
import 'package:test_eccomarce/shared/widgets/state_widgets/failure_widget.dart';

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
    return BlocBuilder<GetHomeCubit, GetHomeState>(
      builder: (context, state) {
        if (state is GetHomeLoading) {
          return HomeShimmer();
        }
        if (state is GetHomeSuccess) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<GetHomeCubit>().getHome();
            },
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
                    products: state.home.products,
                  ).paddingHorizontal(20.w),
                ),
                SliverToBoxAdapter(child: 32.sizeH),
                SliverToBoxAdapter(
                  child: HomeCategoriesWidget(
                    categories: state.home.categories,
                  ).paddingHorizontal(20.w),
                ),
                SliverToBoxAdapter(child: 32.sizeH),
                SliverToBoxAdapter(
                  child: HomeNewArrivalsWidget(
                    products: state.home.products,
                  ).paddingHorizontal(20.w),
                ),
                SliverToBoxAdapter(child: 32.sizeH),
                SliverToBoxAdapter(
                  child: HomeRecommendedWidget(
                    products: state.home.products,
                  ).paddingHorizontal(20.w),
                ),
                SliverToBoxAdapter(child: 32.sizeH),
                SliverToBoxAdapter(child: HomeBlogWidget(products: state.home.products)),
              ],
            ),
          );
        }
        if (state is GetHomeError) {
          return FailureWidget(
            exception: state.exception,
            onTap: () {
              context.read<GetHomeCubit>().getHome();
            },
          );
        }
        return SizedBox();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
