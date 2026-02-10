import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_eccomarce/config/style/app_colors.dart';
import 'package:test_eccomarce/config/style/app_decoration.dart';
import 'package:test_eccomarce/shared/extensions/_export.dart';
import 'package:test_eccomarce/shared/models/category_model.dart';
import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';
import 'package:test_eccomarce/shared/widgets/horizontal_list.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

class HomeCategoriesWidget extends StatefulWidget {
  const HomeCategoriesWidget({super.key});

  @override
  State<HomeCategoriesWidget> createState() => _HomeCategoriesWidgetState();
}

class _HomeCategoriesWidgetState extends State<HomeCategoriesWidget> {
  CategoryModel? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget('Categories', style: AppTextStyle.s18W700),
            TextWidget(
              'See all',
              style: AppTextStyle.s12W500.copyWith(
                color: AppColors.fontGreyColor,
              ),
            ),
          ],
        ),
        16.sizeH,
        HorizontalList(
          itemCount: 10,
          spacing: 12.w,
          itemBuilder: (context, index) => _BuildItem(
            CategoryModel.fromDummyList()[index],
            isSelected:
                selectedCategory == CategoryModel.fromDummyList()[index],
            onTap: (category) {
              setState(() {
                selectedCategory = category;
              });
            },
          ),
        ),
      ],
    );
  }
}

class _BuildItem extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final ValueChanged<CategoryModel> onTap;

  const _BuildItem(
    this.category, {
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(category);
        context.ensureVisible(alignment: 0.5);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: AppDecoration.categoryItem.copyWith(
          color: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
        ),
        child: TextWidget(
          category.name,
          withLocale: false,
          style: AppTextStyle.s14W500.copyWith(
            color: isSelected ? AppColors.whiteColor : null,
          ),
        ),
      ),
    );
  }
}
