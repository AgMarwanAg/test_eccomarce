import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';
import 'package:test_eccomarce/config/style/app_decoration.dart';
import 'package:test_eccomarce/core/di/locator.dart';
import 'package:test_eccomarce/features/cart/data/models/cart_model.dart';
import 'package:test_eccomarce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:test_eccomarce/features/cart/presentation/widgets/counter_widget.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/cubit/get_home_cubit.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/widgets/home_recommedation_widget.dart';
import 'package:test_eccomarce/features/product_details/presentation/cubit/get_product_details_cubit.dart';
import 'package:test_eccomarce/features/product_details/presentation/product_details_shimmer.dart';
import 'package:test_eccomarce/features/product_details/presentation/widgets/extra_info.dart';
import 'package:test_eccomarce/features/product_details/presentation/widgets/product_details_appbar_widget.dart';
import 'package:test_eccomarce/features/product_details/presentation/widgets/product_details_carousel.dart';
import 'package:test_eccomarce/features/product_details/presentation/widgets/product_details_description.dart';
import 'package:test_eccomarce/features/product_details/presentation/widgets/product_sizes_widget.dart';
import 'package:test_eccomarce/shared/extensions/size_ex.dart';
import 'package:test_eccomarce/shared/extensions/widget_ex.dart';
import 'package:test_eccomarce/shared/widgets/app_fav_widget.dart';
import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';
import 'package:test_eccomarce/shared/widgets/badge_widget.dart';
import 'package:test_eccomarce/shared/widgets/buttons/primary_btn.dart';
import 'package:test_eccomarce/shared/widgets/state_widgets/failure_widget.dart';

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
  void initState() {
    super.initState();
    context.read<GetProductDetailsCubit>().getData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: 24.w,
      body: BlocBuilder<GetProductDetailsCubit, GetProductDetailsState>(
        builder: (context, state) {
          if (state is GetProductDetailsLoading) {
            return ProductDetailsShimmer();
          }

          if (state is GetProductDetailsSuccess) {
            return RefreshIndicator(
              onRefresh: () async =>
                  context.read<GetProductDetailsCubit>().getData(widget.id),
              child: Column(
                children: [
                  ProductDetailsAppBarWidget(),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductDetailsCarousel(images: state.product.images),
                          16.sizeH,
                          ProductDetailsDescription(product: state.product),
                          24.sizeH,
                          ProductSizesWidget(sizes: state.product.tags),
                          32.sizeH,
                          ExtraInfo(product: state.product),
                          32.sizeH,

                          BlocProvider(
                            create: (context) => sl<GetHomeCubit>(),
                            child: BlocBuilder<GetHomeCubit, GetHomeState>(
                              builder: (context, state) {
                                if (state is GetHomeSuccess) {
                                  return HomeRecommendedWidget(
                                    products: state.home.products,
                                  );
                                }
                                return SizedBox();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is GetProductDetailsFailure) {
            return FailureWidget(
              exception: state.exception,
              onTap: () {
                context.read<GetProductDetailsCubit>().getData(widget.id);
              },
            );
          }

          return SizedBox();
        },
      ),
      bottomNavigationBar:
          BlocBuilder<GetProductDetailsCubit, GetProductDetailsState>(
            builder: (context, state) {
              if (state is! GetProductDetailsSuccess) {
                return SizedBox();
              }

              return Container(
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
                        border: Border.all(
                          color: AppColors.appDivider,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: AppFavWidget(isFav: false),
                    ),
                    16.sizeW,
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        PrimaryBtn(
                          text: 'Add to Cart',
                          onPressed: () {
                            context.read<CartBloc>().add(
                              AddCartItem(
                                CartItem(product: state.product, quantity: 1),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          top: -10,
                          right: -10,
                          child: BadgeWidget(
                            count: context
                                .watch<CartBloc>()
                                .state
                                .getProductQuantity(state.product.id),
                          ),
                        ),
                      ],
                    ).expanded(),
                  ],
                ),
              );
            },
          ),
    );
  }
}
