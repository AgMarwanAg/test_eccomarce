import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_eccomarce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:test_eccomarce/features/cart/presentation/widgets/cart_product_item.dart';
import 'package:test_eccomarce/shared/extensions/padding_ex.dart';
import 'package:test_eccomarce/shared/widgets/app_divider_widget.dart';
import 'package:test_eccomarce/shared/widgets/app_dotted_divider.dart';
import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

class CartBodyWidget extends StatelessWidget {
  const CartBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final items = state.cart.items ?? [];
          if (items.isEmpty) {
            return Center(child: TextWidget('Your cart is empty'));
          }
          return ListView.separated(
            itemBuilder: (context, index) =>
                CartProductItem(item: items[index]),
            separatorBuilder: (context, index) =>
                DottedDivider().paddingVertical(24.h),
            itemCount: state.getCartItemCount(),
          );
        },
      ).paddingHorizontal(24.w),
    );
  }
}
