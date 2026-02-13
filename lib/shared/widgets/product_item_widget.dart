import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';
import 'package:test_eccomarce/config/style/app_decoration.dart';
import 'package:test_eccomarce/features/cart/data/models/cart_model.dart';
import 'package:test_eccomarce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:test_eccomarce/features/product_details/presentation/product_details_screen.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';
import 'package:test_eccomarce/shared/widgets/badge_widget.dart';
import 'package:test_eccomarce/shared/widgets/images/network_image.dart';
import 'package:test_eccomarce/shared/widgets/success_overlay.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

class ProductItemWidget extends StatefulWidget {
  final ProductModel product;
  final bool isFavorite;
  const ProductItemWidget({
    super.key,
    required this.product,
    required this.isFavorite,
  });

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  late bool isFav = widget.isFavorite;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ProductDetailsScreen.push(context, id: widget.product.id);
      },
      child: Container(
        width: 155.w,
        padding: EdgeInsets.all(12.w),
        decoration: AppDecoration.productCard,
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NetWorkImageWidget(
                  url: widget.product.thumbnail,
                  width: 112.w,
                  height: 112.w,
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                ).paddingSymmetric(h: 10.w, v: 8.h),
                12.sizeH,
                TextWidget(
                  widget.product.category,
                  style: AppTextStyle.s10W500.copyWith(
                    color: AppColors.hintColors,
                  ),
                ),
                TextWidget(widget.product.title, style: AppTextStyle.s12W700),
                Container(
                  padding: EdgeInsetsDirectional.only(
                    start: 6.w,
                    top: 6.h,
                    bottom: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.appDivider,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        "${widget.product.price} USD",
                        style: AppTextStyle.s12W700,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!context.read<CartBloc>().state.isProductInCart(
                            widget.product.id,
                          )) {
                            SuccessOverlay.show(context);
                          }

                          context.read<CartBloc>().add(
                            AddCartItem(
                              CartItem(product: widget.product, quantity: 1),
                            ),
                          );
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.blackColor,
                              ),
                              child: Icon(
                                Icons.add,
                                color: AppColors.whiteColor,
                                size: 18.sp,
                              ),
                            ),
                            PositionedDirectional(
                              top: -10,
                              end: -10,
                              child: BadgeWidget(
                                count: context
                                    .watch<CartBloc>()
                                    .state
                                    .getProductQuantity(widget.product.id),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                setState(() => isFav = !isFav);
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: Tween<double>(begin: 0.6, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutBack,
                      ),
                    ),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border_outlined,
                  key: ValueKey(isFav),
                  color: isFav ? AppColors.primaryColor : AppColors.blackColor,
                  size: 18.sp,
                ),
              ),
            ),
            if (!widget.product.brand.isEmptyOrNull)
              PositionedDirectional(
                start: 0,
                top: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.blackColor,
                  ),
                  child: Text(
                    widget.product.brand,
                    style: AppTextStyle.s10W500.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
