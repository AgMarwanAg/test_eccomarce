import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../dio_client/api_exception.dart';
import '../buttons/primary_btn.dart';
import '../images/svg_image.dart';
import '../text_widget.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({
    super.key,
    required this.exception,
    required this.onTap,
    this.topHeight,
    this.withCloseButton,
    this.showContactSupport = true,
  });

  final ApiException exception;
  final GestureTapCallback? onTap;
  final double? topHeight;
  final bool? withCloseButton;
  final bool showContactSupport;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (topHeight != null) SizedBox(height: topHeight),

            // Error Icon
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: AppColors.errorColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgAsset(
                  AppIcons.exclamationMark,
                  size: 40.w,
                  color: AppColors.errorColor,
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Error Title
            TextWidget(
              exception.statusCode?.toString(),
              style: AppTextStyle.s18W700.copyWith(
                color: AppColors.primaryFontColor,
              ),
              textAlign: TextAlign.center,
              withLocale: false,
            ),

            SizedBox(height: 12.h),

            // Error Message
            TextWidget(
              exception.message,
              style: AppTextStyle.s14W400.copyWith(
                color: AppColors.fontGreyColor,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              withLocale: false,
            ),

            SizedBox(height: 32.h),

            // Action Buttons
            Column(
              children: [
                // Retry Button
                if (onTap != null)
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryBtn(
                      text: 'retry',
                      onPressed: onTap,
                      height: 48,
                    ),
                  ),

                // Contact Support Button
                // if (showContactSupport && _shouldShowContactSupport()) ...[
                //   SizedBox(height: 12.h),
                //   SizedBox(
                //     width: double.infinity,
                //     child: SecondaryBtn(
                //       text: 'support_complaints',
                //       onTap: () {
                //         SupportScreen.push(context);
                //       },
                //       height: 48,
                //     ),
                //   ),
                // ],
              ],
            ),

            // Debug info (only in debug mode)

            // SizedBox(height: 24.h),
            // Container(
            //   padding: EdgeInsets.all(12.w),
            //   decoration: BoxDecoration(
            //     color: AppColors.sectionBg,
            //     borderRadius: BorderRadius.circular(8.r),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       TextWidget(
            //         'Debug Info:',
            //         style: AppTextStyle.s12W600,
            //         withLocale: false,
            //       ),
            //       SizedBox(height: 4.h),
            //       TextWidget(
            //         'Status Code: ${exception.statusCode ?? 'N/A'}',
            //         style: AppTextStyle.s11W400.copyWith(
            //           color: AppColors.fontGreyColor,
            //         ),
            //         withLocale: false,
            //       ),
            //       TextWidget(
            //         'Message: ${exception.message ?? 'N/A'}',
            //         style: AppTextStyle.s11W400.copyWith(
            //           color: AppColors.fontGreyColor,
            //         ),
            //         withLocale: false,
            //         maxLines: 2,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // bool _shouldShowContactSupport() {
  //   final statusCode = exception.statusCode;
  //   // Show contact support for server errors, forbidden access, or persistent issues
  //   return statusCode == 500  || statusCode == 403 || statusCode == null;
  // }
}
