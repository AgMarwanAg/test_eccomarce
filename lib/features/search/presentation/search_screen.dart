import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';
import 'package:test_eccomarce/core/utls/debounce.dart';
import 'package:test_eccomarce/features/search/presentation/cubit/search_cubit.dart';
import 'package:test_eccomarce/features/search/presentation/search_screen_shimmer.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';

import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';
import 'package:test_eccomarce/shared/widgets/buttons/back_btn.dart';
import 'package:test_eccomarce/shared/widgets/product_item_widget.dart';
import 'package:test_eccomarce/shared/widgets/shimmer/skeleton_widget.dart';
import 'package:test_eccomarce/shared/widgets/state_widgets/failure_widget.dart';
import 'package:test_eccomarce/shared/widgets/state_widgets/no_data_widget.dart';
import 'package:test_eccomarce/shared/widgets/text_field/text_field_widget.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

class SearchScreen extends StatefulWidget {
  static const String path = '/search';
  const SearchScreen({super.key});
  static void push(BuildContext context) {
    context.push(path);
  }

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Debounce _debounce = Debounce(delay: const Duration(milliseconds: 500));
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SearchCubit>().search(null);
  }

  @override
  void dispose() {
    _debounce.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        spacing: 15.h,
        children: [
          Row(
            children: [
              BackBtnWidget(),
              Expanded(
                child: Center(
                  child: TextWidget('Search', style: AppTextStyle.s16W700),
                ),
              ),
              SizedBox(width: 35.w),
            ],
          ),
          TextFieldWidget(
            controller: _searchController,
            hintText: 'Search for Product',
            prefixIcon: const Icon(Icons.search),
            onChanged: (val) {
              _debounce(() {
                context.read<SearchCubit>().search(val);
              });
            },
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                switch (state) {
                  case SearchLoading():
                    return const SearchScreenShimmer();

                  case SearchFailure():
                    return Center(
                      child: FailureWidget(
                        exception: state.error,
                        onTap: () {
                          context.read<SearchCubit>().search(
                            _searchController.text,
                          );
                        },
                      ),
                    );

                  case SearchSuccess():
                    if (state.products.isEmpty) {
                      return const Center(child: NoDataWidget());
                    }

                    return NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.pixels >=
                            notification.metrics.maxScrollExtent * 0.9) {
                          context.read<SearchCubit>().loadMore();
                        }
                        return false;
                      },
                      child: GridView.builder(
                        padding: EdgeInsets.only(bottom: 20.h),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 10.h,
                          crossAxisSpacing: 10.w,
                        ),
                        itemCount: state.hasReachedMax
                            ? state.products.length
                            : state.products.length +
                                  (state.products.length % 2 == 0 ? 2 : 3),
                        itemBuilder: (context, index) {
                          if (index >= state.products.length) {
                            return SkeletonWidget(
                              child: ProductItemWidget(
                                product: ProductModel.fromDummyList().first,
                                isFavorite: false,
                              ),
                            );
                          }
                          return ProductItemWidget(
                            product: state.products[index],
                            isFavorite: false,
                          );
                        },
                      ),
                    );

                  default:
                    return Center(
                      child: TextWidget(
                        'Type to search...',
                        style: AppTextStyle.s14W400.copyWith(
                          color: AppColors.hintColors,
                        ),
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
