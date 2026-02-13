import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:test_eccomarce/config/style/app_decoration.dart';
import 'package:test_eccomarce/features/cart/data/models/cart_model.dart';
import 'package:test_eccomarce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:test_eccomarce/features/cart/presentation/widgets/counter_widget.dart';
import 'package:test_eccomarce/features/product_details/presentation/product_details_screen.dart';
import 'package:test_eccomarce/shared/extensions/size_ex.dart';
import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';
import 'package:test_eccomarce/shared/widgets/images/network_image.dart';
import 'package:test_eccomarce/shared/widgets/images/svg_image.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

class CartProductItem extends StatelessWidget {
  final CartItem item;
  const CartProductItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ProductDetailsScreen.push(context, id: item.product.id);
      },
      child: Slidable(
        key: ValueKey(item.product.id),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          extentRatio: 0.25,

          children: [
            CustomSlidableAction(
              padding: EdgeInsets.only(left: 10.w),
              onPressed: (context) {
                context.read<CartBloc>().add(RemoveCartItem(item.product.id));
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.all(20.sp),
                decoration: AppDecoration.deleteSlider,
                child: SvgAsset(AppIcons.trash, color: AppColors.whiteColor),
              ),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.navBarColor, width: 5.w),
              ),
              child: NetWorkImageWidget(
                url: item.product.thumbnail,
                width: 64.w,
                height: 64.w,
              ),
            ),
            16.sizeW,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    item.product.title,
                    style: AppTextStyle.s15W500,
                    maxLines: 2,
                  ),
                  TextWidget(
                    item.product.category,
                    style: AppTextStyle.s12W400.copyWith(
                      color: AppColors.hintColors,
                    ),
                  ),
                  12.sizeH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            "${item.product.price} USD",
                            style: AppTextStyle.s10W400.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: AppColors.hintColors,
                              decorationThickness: 0.5,
                            ),
                          ),
                          TextWidget(
                            "${item.product.priceAfterDiscount} USD",
                            style: AppTextStyle.s14W600,
                          ),
                        ],
                      ),
                      CounterWidget(
                        onAdd: () {
                          context.read<CartBloc>().add(AddCartItem(item));
                        },
                        onRemove: () {
                          context.read<CartBloc>().add(
                            DecreaseQuantityItem(item.product.id),
                          );
                        },
                        quantity: item.quantity,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
