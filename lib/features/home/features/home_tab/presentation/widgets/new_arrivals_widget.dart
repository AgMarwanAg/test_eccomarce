import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';
import 'package:test_eccomarce/config/style/app_decoration.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

import '../../../../../../shared/widgets/horizontal_list.dart';

class NewArrivalsWidget extends StatelessWidget {
  const NewArrivalsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget('New arrivals', style: AppTextStyle.s18W700),
            TextWidget(
              'See all',
              style: AppTextStyle.s12W500.copyWith(
                color: AppColors.fontGreyColor,
              ),
            ),
          ],
        ),
        16.sizeH,
      ],
    );
  }
}
