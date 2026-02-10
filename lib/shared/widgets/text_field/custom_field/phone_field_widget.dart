import 'package:flutter/material.dart';
import '../text_field_widget.dart';

class PhoneFieldWidget extends StatelessWidget {
  const PhoneFieldWidget({
    super.key,
    required this.hint,
    this.fieldTitle,
    this.isRequired = true,
    this.onSubmitted,
    this.onChanged,
    this.readOnly = false,
    this.ableToChangeCountry = false,
    this.controller,
    this.focusNode,
    this.autoFocus = false,
  });

  final String hint;
  final String? fieldTitle;
  final bool isRequired;
  final void Function(String val)? onSubmitted;
  final void Function(String)? onChanged;
  final bool readOnly;
  final bool ableToChangeCountry;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autoFocus;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFieldWidget(
        autofocus: autoFocus,
        focusNode: focusNode,
        controller: controller,
        hintText: hint,
        maxLength: 9,
        hintTextDirection: TextDirection.ltr,
        textDirection: TextDirection.ltr,
        keyboardType: TextInputType.number,
        readOnly: readOnly,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        textInputAction: TextInputAction.done,
        validator: isRequired ? TextFieldValidator.callablePhoneNoFieldValidator : null,
        
      ),
    );
  }
}
