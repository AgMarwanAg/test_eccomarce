import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/style/app_colors.dart';
import '../../extensions/_export.dart';
import '../text_widget.dart';

part 'text_field_validator.dart';

class TextFieldWidget extends StatefulWidget {
  final String? hintText, labelText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? padding;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final bool autofocus;
  final bool? obscureText;
  final Function(String val)? onChanged;
  final Function(String val)? onFieldSubmitted;
  final Function(String val)? onSubmitted;
  final FocusNode? focusNode;
  final String? Function(String? value)? validator;
  final bool readOnly;
  final bool enabled;
  final int maxLines;
  final bool alignLabelWithHint;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final TextAlign textAlign;
  final void Function()? onTap;

  final EdgeInsetsGeometry? contentPadding;
  final TextDirection? hintTextDirection;
  final TextDirection? textDirection;
  final bool tapOutSide;
  final bool? filled;
  final InputDecoration? decoration;
  final Color? filledColor;
  final bool showCounter;
  final BoxConstraints? constraints;
  final double? cursorHeight;
  const TextFieldWidget({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.focusNode,
    this.suffixIcon,
    this.prefixIcon,
    this.padding,
    this.autovalidateMode,
    this.keyboardType,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    this.obscureText,
    this.onTap,
    this.validator,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.enabled = true,
    this.showCounter = false,
    this.alignLabelWithHint = false,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.contentPadding,
    this.hintTextDirection,
    this.textDirection,
    this.tapOutSide = true,
    this.filled,
    this.decoration,
    this.filledColor,
    this.maxLength,
    this.constraints,
    this.cursorHeight,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child: TextFormField(
        obscureText: widget.obscureText ?? false,
        textAlign: widget.textAlign,
        cursorColor: AppColors.hintColors,
        cursorHeight: widget.cursorHeight,
        decoration:
            widget.decoration ??
            InputDecoration(
              constraints: widget.constraints,
              filled: widget.filled,
              fillColor: widget.filledColor,
              counterText: widget.showCounter ? null : '',
              contentPadding:
                  widget.contentPadding ??
                  EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
              hintText: widget.hintText?.tr(),
              hintStyle: AppTextStyle.textHintStyle,
              hintTextDirection: widget.hintTextDirection,
              labelText: widget.labelText?.tr(),
              labelStyle: AppTextStyle.textLabelStyle,
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              alignLabelWithHint: widget.alignLabelWithHint,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
        controller: widget.controller,
        maxLines: widget.maxLines,
        textDirection: widget.textDirection,
        textInputAction: widget.textInputAction,
        autovalidateMode:
            widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
        keyboardType: widget.keyboardType,
        autofocus: widget.autofocus,
        inputFormatters:
            (widget.keyboardType == TextInputType.number ||
                widget.keyboardType == TextInputType.phone)
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9\u0660-\u0669]'),
                ),
              ]
            : null,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        onFieldSubmitted: widget.onFieldSubmitted,
        onTapOutside: widget.tapOutSide
            ? (event) => FocusManager.instance.primaryFocus?.unfocus()
            : null,
        focusNode: widget.focusNode,
        validator: widget.validator,
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        maxLength: widget.maxLength,
      ),
    );
  }
}
