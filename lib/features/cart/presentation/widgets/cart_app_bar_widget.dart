import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';
import 'package:test_eccomarce/features/cart/presentation/bloc/cart_bloc.dart';
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
        Visibility(
          visible: context.watch<CartBloc>().state.isCartNotEmpty,
          child: GestureDetector(
            onTap: () {
              context.read<CartBloc>().add(ClearCart());
            },
            child: Icon(Icons.delete, color: AppColors.errorColor),
          ),
        ),
      ],
    );
  }
}
