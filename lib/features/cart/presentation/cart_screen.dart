import 'package:flutter/material.dart';
import 'package:test_eccomarce/features/cart/presentation/widgets/pricing_sheet_widget.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';

import 'widgets/cart_app_bar_widget.dart';
import 'widgets/cart_body_widget.dart';

class CartScreen extends StatelessWidget {
  final bool isFullScreen;
  static const String path = '/cart';
  const CartScreen({super.key, required this.isFullScreen});

  static void push(BuildContext context, {required bool isFullScreen}) {
    context.push(path, extra: isFullScreen);
  }

  @override
  Widget build(BuildContext context) {
    return isFullScreen
        ? AppScaffold(padding: 0, body: _bodyWidget())
        : _bodyWidget();
  }

  Column _bodyWidget() {
    return Column(
      children: [
        CartAppBarWidget().paddingHorizontal(24.w),
        25.sizeH,
        CartBodyWidget(),
        PricingSheetWidget(),
      ],
    );
  }
}
