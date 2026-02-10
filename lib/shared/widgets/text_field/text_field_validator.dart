
part of 'text_field_widget.dart';
class TextFieldValidator {
  static String? defaultFieldValidator(String? value) {
    if (value == null || value.isEmptyOrNull) {
      return 'validation.required'.tr();
    }
    return null;
  }
  static String? customFieldValidator(String? value, bool Function(String value) condition) {
    final requiredError = defaultFieldValidator(value);
    if (requiredError != null) {
      return requiredError;
    }
    if (!condition(value!)) {
      return 'validation.required'.tr();
    }
    return null;
  }

  static String? emailFieldValidator(String? value) {
    final requiredError = defaultFieldValidator(value);
    if (requiredError != null) {
      return requiredError;
    }
    if (!(value?.isEmail ?? false)) {
      return 'validation.invalid_email'.tr();
    }
    return null;
  }

  static String? optionalEmailFieldValidator(String? value) {
    if (value == null || value.isEmptyOrNull) {
      return null;
    }
    if (!(value.isEmail)) {
      return 'validation.invalid_email'.tr();
    }
    return null;
  }

  static String? callablePhoneNoFieldValidator(String? value) {
    final requiredError = defaultFieldValidator(value);
    if (requiredError != null) {
      return requiredError;
    }
  
    if (value?.length != 9) {
      return 'validation.invalid_phone_length'.tr();
    }
    return null;
  }

  static String? passwordFieldValidator(String? value) {
    final requiredError = defaultFieldValidator(value);
    if (requiredError != null) {
      return requiredError;
    }
    if ((value?.length ?? 0) < 8) {
      return 'validation.password_length'.tr();
    }
    return null;
  }

  static String? passwordConfirmFieldValidator(String? value, String password) {
    final requiredError = defaultFieldValidator(value);
    if (requiredError != null) {
      return requiredError;
    }
    if (value != password) {
      return 'validation.password_mismatch'.tr();
    }
    return null;
  }

  static String? minimumLengthFieldValidator(String? value, double minAmount) {
    final requiredError = defaultFieldValidator(value);
    if (requiredError != null) {
      return requiredError;
    }
    double? amount = double.tryParse(value!);
    if (amount != null && amount < minAmount) {
      return 'validation.minimum_length'.tr(namedArgs: {'count': '$minAmount'});
    }
    return null;
  }
}
