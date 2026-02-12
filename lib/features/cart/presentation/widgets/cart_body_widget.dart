import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_eccomarce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:test_eccomarce/features/cart/presentation/widgets/cart_product_item.dart';
import 'package:test_eccomarce/shared/widgets/app_divider_widget.dart';
import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';

class CartBodyWidget extends StatelessWidget {
  const CartBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final items = state.cart.items ?? [];
          return ListView.separated(
            itemBuilder: (context, index) =>
                CartProductItem(item: items[index]),
            separatorBuilder: (context, index) =>
                AppDividerWidget(paddingH: 24.h),
            itemCount: state.getCartItemCount(),
          );
        },
      ),
    );
  }
}
