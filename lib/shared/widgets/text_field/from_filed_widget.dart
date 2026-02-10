import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_border_wrapper.dart';
import '/config/style/app_colors.dart';

 import '../text_widget.dart';

class FormFieldWidget<T> extends FormField<T> {
  FormFieldWidget({
    super.key, // Super parameter
    super.initialValue, // Super parameter
    super.enabled, // Super parameter
    super.validator, // Super parameter
    super.onSaved, // Super parameter
    required Widget Function(FormFieldState<T> state) builder,
    BorderRadius? borderRadius,
   }) : super(
          builder: (state) {
            return state.hasError
                ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BorderWrapper(
                      borderRadius:borderRadius?? BorderRadius.circular(12.r),
                      borderColor: AppColors.errorColor,
                        // decoration: decoration.copyWith(
                        //   errorText: state.errorText,
                        // ),
                        child: builder(state),
                      ),
                    if (state.errorText != null)
                    TextWidget(
                      state.errorText!,
                      style: const TextStyle(color: AppColors.errorColor),
                    ),
                  ],
                )
                : builder(state);
          },
        );
}
