import 'package:flutter/material.dart';

import 'package:toastification/toastification.dart';
import '../../../config/style/app_colors.dart';
import 'text_widget.dart';

/// Helper class for displaying various types of Snackbars.
/// [note] pass the context whenever You can to avoid null context error
class AppToast {
  /// Displays an error Snackbar.
  static void showErrorToast({
    BuildContext? context,
    String? message,
    Duration duration = const Duration(seconds: 4),
    Color backgroundColor = AppColors.errorColor,
    bool withLocale = true,
  }) {
    toastification.dismissAll();
    toastification.show(
        context: context,
        title: TextWidget(
          message,
          withLocale: withLocale,
          maxLines: 5,
          style: AppTextStyle.s13W600.copyWith(color: AppColors.whiteColor),
        ),
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        showIcon: false,
        autoCloseDuration: duration,
        backgroundColor: backgroundColor,
        dragToClose: true,
        showProgressBar: true,
        progressBarTheme: const ProgressIndicatorThemeData(color: AppColors.whiteColor, linearMinHeight: 1, linearTrackColor: AppColors.transparent));
  }

  // static void showErrorToast({
  //   BuildContext? context,
  //   String? message,
  //   Duration duration = const Duration(seconds: 4),
  //   Color backgroundColor = AppColors.errorColor,
  //   bool withLocale = true,
  // }) {
  //   toastification.show(
  //       context: context,
  //       title: TextWidget(
  //         message,
  //         withLocale: withLocale,
  //         maxLines: 5,
  //         style: AppTextStyle.s13W600.copyWith(color: AppColors.whiteColor),
  //       ),
  //       type: ToastificationType.error,
  //       style: ToastificationStyle.simple,
  //       showIcon: false,
  //       autoCloseDuration: duration,
  //       backgroundColor: backgroundColor,
  //       dragToClose: true,
  //       showProgressBar: true,
  //       progressBarTheme: const ProgressIndicatorThemeData(color: AppColors.whiteColor, linearMinHeight: 1, linearTrackColor: AppColors.transparent));
  // }

  /// Displays an success Snackbar.
  static void showSuccessToast({
    BuildContext? context,
    String? message,
    Duration duration = const Duration(seconds: 2),
    Color backgroundColor = AppColors.successColor,
    bool withLocale = true,
  }) {
    toastification.show(
        context: context,
        title: TextWidget(message, withLocale: withLocale, style: AppTextStyle.s13W600.copyWith(color: AppColors.whiteColor)),
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
        showIcon: false,
        autoCloseDuration: duration,
        backgroundColor: backgroundColor,
        dragToClose: true,
        showProgressBar: true,
        progressBarTheme: const ProgressIndicatorThemeData(color: AppColors.whiteColor, linearMinHeight: 1, linearTrackColor: AppColors.transparent));
  }

  static void showInfoToast({
    BuildContext? context,
    String? message,
    Duration duration = const Duration(seconds: 2),
     bool withLocale = true,
    AlignmentGeometry? alignment,
  }) {
    toastification.show(
      context: context,
      title: TextWidget(
        message,
        withLocale: withLocale,
        style: AppTextStyle.s13W600.copyWith(color: AppColors.primaryColor),
      ),
      type: ToastificationType.info,
      alignment:alignment?? Alignment.bottomCenter,
      style: ToastificationStyle.minimal,
      showIcon: false,
      autoCloseDuration: duration,
       dragToClose: true,
      showProgressBar: false,
    );
  }
}
