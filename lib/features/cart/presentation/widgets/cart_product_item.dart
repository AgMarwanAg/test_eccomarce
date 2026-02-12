import 'package:flutter/material.dart';
import 'package:test_eccomarce/features/cart/data/models/cart_model.dart';
import 'package:test_eccomarce/shared/widgets/images/network_image.dart';

class CartProductItem extends StatelessWidget {
  final CartItem item;
  const CartProductItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NetWorkImageWidget(url: item.product.thumbnail),
        Expanded(child: Column(children: [])),
      ],
    );
  }
}
