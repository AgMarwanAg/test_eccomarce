import 'package:flutter/material.dart';
import 'package:test_eccomarce/shared/extensions/size_ex.dart';
import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';
import 'package:test_eccomarce/shared/widgets/images/svg_image.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

class ProductSizesWidget extends StatefulWidget {
  final List<String> sizes;
  const ProductSizesWidget({super.key, required this.sizes});

  @override
  State<ProductSizesWidget> createState() => _ProductSizesWidgetState();
}

class _ProductSizesWidgetState extends State<ProductSizesWidget> {
  String? selected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextWidget('Select size', style: AppTextStyle.s14W600),
        12.sizeH,
        Wrap(
          spacing: 8.w,
          children: List.generate(
            widget.sizes.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  selected = widget.sizes[index];
                });
              },
              child: _buildItem(
                widget.sizes[index],
                selected == widget.sizes[index],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(String name, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            color: selected
                ? AppColors.blackColor
                : AppColors.textFontGreyColor,
          ),
          borderRadius: BorderRadius.circular(99.r),
        ),
      ),
      child: TextWidget(
        name,
        style: AppTextStyle.s16W400.copyWith(
          color: selected ? AppColors.blackColor : AppColors.textFontGreyColor,
        ),
      ),
    );
  }
}
