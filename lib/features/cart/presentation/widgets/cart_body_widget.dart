import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_eccomarce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:test_eccomarce/features/cart/presentation/widgets/cart_product_item.dart';

class CartBodyWidget extends StatelessWidget {
  const CartBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
                  final items = state.cart.items??[];

        return Column(children:List.generate(state.getCartItemCount(), (index) => CartProductItem(item: items[index])),);
      },
    );
  }
}
