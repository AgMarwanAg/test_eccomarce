import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/widgets/horizontal_list.dart';
import 'package:test_eccomarce/shared/widgets/images/network_image.dart';

class HomeSliderWidget extends StatelessWidget {
  final List<String>ads;
  const HomeSliderWidget({super.key,required this.ads});

  @override
  Widget build(BuildContext context) {
    return HorizontalList(
      itemCount: ads.length,
      spacing: 10.w,
      itemBuilder: (context, index) => Stack(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: NetWorkImageWidget(
              url: ads[index],
              height: 223.h,
              width: context.width * 0.8,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
