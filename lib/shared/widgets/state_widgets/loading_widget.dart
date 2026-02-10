import 'package:flutter/material.dart';


import '../../../config/style/app_colors.dart';
import '../app_spinner_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: AppSpinnerWidget(
      color: AppColors.primaryColor,
    ));
  }
}
