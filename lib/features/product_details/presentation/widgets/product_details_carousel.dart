import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';
import 'package:test_eccomarce/shared/extensions/size_ex.dart';
import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';

import '../../../../shared/widgets/images/network_image.dart';

class ProductDetailsCarousel extends StatefulWidget {
  final List<String> images;

  const ProductDetailsCarousel({super.key, required this.images});

  @override
  State<ProductDetailsCarousel> createState() => _ProductDetailsCarouselState();
}

class _ProductDetailsCarouselState extends State<ProductDetailsCarousel> {
  int _currentIndex = 0;
  late CarouselSliderController _carouselController;
  @override
  void initState() {
    _carouselController = CarouselSliderController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 246.h,
            viewportFraction: 1,
            initialPage: 0,
            autoPlay: widget.images.length > 1,
            autoPlayInterval: const Duration(seconds: 3),

            pauseAutoPlayOnTouch: true,
            enableInfiniteScroll: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
          itemCount: widget.images.length,
          itemBuilder: (context, index, _) {
            return NetWorkImageWidget(
              url: widget.images[index],
              width: double.infinity,
              fit: BoxFit.fill,
            );
          },
        ),
        48.sizeH,
        Container(
          height: 22,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          margin: EdgeInsets.only(bottom: 8.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              widget.images.length,
              (index) => GestureDetector(
                onTap: () => _carouselController.animateToPage(index),
                child: _BuildItem(selected: _currentIndex == index),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BuildItem extends StatelessWidget {
  final bool selected;

  const _BuildItem({required this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: selected ? 12.w : 9.w,
      height: selected ? 12.w : 9.w,
      decoration: BoxDecoration(
        color: selected ? AppColors.blackColor : AppColors.hintColors,
        shape: BoxShape.circle,
      ),
    );
  }
}
