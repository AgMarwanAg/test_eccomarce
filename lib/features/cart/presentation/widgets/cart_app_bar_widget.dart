import 'package:flutter/material.dart';
import 'package:test_eccomarce/shared/widgets/buttons/back_btn.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

class CartAppBarWidget extends StatelessWidget {
  const CartAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BackBtnWidget(),
        Expanded(
          child: Center(
            child: TextWidget('Shopping Cart', style: AppTextStyle.s18W600),
          ),
        ),
      ],
    );
  }
}
