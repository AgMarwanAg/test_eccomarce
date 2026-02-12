import 'package:flutter/material.dart';
import 'package:test_eccomarce/shared/extensions/padding_ex.dart';
import 'package:test_eccomarce/shared/extensions/size_ex.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';
import 'package:test_eccomarce/shared/widgets/app_scaffold.dart';
import 'package:test_eccomarce/shared/widgets/images/svg_image.dart';
import 'package:test_eccomarce/shared/widgets/modals/custom_bottom_sheet.dart';
import 'package:test_eccomarce/shared/widgets/text_widget.dart';

class ExtraInfo extends StatelessWidget {
  final ProductModel product;
  const ExtraInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _item(AppIcons.stock, 'In stock', isPrimary: true),
        12.sizeH,
        _item(AppIcons.delivery, 'delivery'),
        12.sizeH,

        _item(AppIcons.store, 'Available in the nearest store'),
        24.sizeH,
        TextWidget(
          product.description,
          style: AppTextStyle.s14W400.copyWith(color: AppColors.fontGreyColor),
          maxLines: 2,
        ),
        24.sizeH,
        _BuildDescCard(title: 'Description', description: product.description),
        10.sizeH,
        _BuildDescCard(title: 'Ingredients', description: product.description),
        10.sizeH,
        _BuildDescCard(title: 'How to use', description: product.description),
      ],
    );
  }

  Row _item(String icon, String title, {bool isPrimary = false}) {
    return Row(
      spacing: 8.w,
      children: [
        SvgAsset(icon),
        TextWidget(
          title,
          style: AppTextStyle.s14W500.copyWith(
            color: isPrimary ? AppColors.textPrimary : AppColors.fontGreyColor,
          ),
        ),
      ],
    );
  }
}

class _BuildDescCard extends StatelessWidget {
  final String title, description;
  const _BuildDescCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _openSheet(context, description);
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.appDivider,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(title, style: AppTextStyle.s16W500),
            Icon(Icons.arrow_forward, color: AppColors.hintColors),
          ],
        ),
      ),
    );
  }

  void _openSheet(BuildContext context, String description) async {
    CustomBottomSheet.show(
      context: context,

      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(title, style: AppTextStyle.s18W700),
              CircleAvatar(
                backgroundColor: AppColors.appDivider,
                child: CloseButton(),
              ),
            ],
          ),
          30.sizeH,
          TextWidget(description, maxLines: null, overflow: TextOverflow.clip),
          30.sizeH,
        ],
      ).paddingSymmetric(h: 20.w),
    );
  }
}
