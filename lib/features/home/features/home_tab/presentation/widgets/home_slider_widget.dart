import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/core/faker/dummy_network_image.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/widgets/horizontal_list.dart';
import 'package:test_eccomarce/shared/widgets/images/network_image.dart';

class HomeSliderWidget extends StatelessWidget {
  const HomeSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalList(
      itemCount: 10,
      spacing: 10.w,
      itemBuilder: (context, index) => Stack(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: NetWorkImageWidget(
              url: DummyImage.placeholderImage(),
              height: 223.h,
              width: context.width * 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
