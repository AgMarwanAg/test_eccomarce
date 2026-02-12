import 'package:flutter/material.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';

import 'widgets/cart_app_bar_widget.dart';
import 'widgets/cart_body_widget.dart';

class CartScreen extends StatelessWidget {
  static const String path = '/cart';
  const CartScreen({super.key});

  static void push(BuildContext context) {
    context.push(path);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [CartAppBarWidget(), 25.sizeH, CartBodyWidget()],
    ).paddingHorizontal(24.w);
  }
}
