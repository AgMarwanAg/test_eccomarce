import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../caching/shared_pref_services.dart';
import '../di/locator.dart';

/// Enum representing supported locales.
enum LocaleType {
  ar, // Arabic
  en, // English
}

/// A service that handles localization settings for the application.
class LocalizationService {
  // Path to the translation files.
  final String translationPath = "assets/translations";

  /// Supported locales.
  final List<Locale> supportedLocales = [
    const Locale('ar'), // Arabic
    const Locale('en'), // English
  ];

  /// Fallback locale when no matching locale is found.
  Locale fallbackLocale = const Locale('en');
  Locale initialLocale = const Locale('en');

  // Key for storing the locale in shared preferences.
  static const String _localeTXT = 'locale';
  static String get localeTXT => _localeTXT;

  /// Initializes the localization service.
  /// Ensures that the EasyLocalization package is initialized before the app starts.
  static Future<void> initialize() async {
    await EasyLocalization.ensureInitialized();
  }

  /// Retrieves the stored locale from shared preferences.
  ///
  /// Returns:
  /// - A [Locale] object representing the stored locale, or the fallback locale if none is found.
  Locale get currentLocale {
    String? languageCode = sl<SharedPreferencesService>().getString(_localeTXT);
    return languageCode != null ? Locale(languageCode) : initialLocale;
  }

  /// Changes the app's locale and saves it in shared preferences.
  ///
  /// Parameters:
  /// - [context]: The BuildContext for changing the locale.
  /// - [locale]: The new locale to set.
  void setLocale(BuildContext context, Locale locale) {
    if (currentLocale != locale) context.setLocale(locale);
    // sl<SharedPreferencesService>().saveString(_localeTXT, locale.languageCode);
  }

  /// Sets the app's locale to Arabic.
  ///
  /// Parameters:
  /// - [context]: The BuildContext for changing the locale.
  void setAr(BuildContext context) {
    context.setLocale(const Locale('ar'));
  }

  /// Sets the app's locale to English.
  ///
  /// Parameters:
  /// - [context]: The BuildContext for changing the locale.
  void setEn(BuildContext context) {
    context.setLocale(const Locale('en'));
  }

  /// Toggles the app's locale between Arabic and English.
  ///
  /// Parameters:
  /// - [context]: The BuildContext for changing the locale.
  void toggleLocale(BuildContext context) {
    Locale newLocale = currentLocale.languageCode == LocaleType.ar.name
        ? const Locale('en')
        : const Locale('ar');
    setLocale(context, newLocale);
  }

  /// returns the device locale
  ///
  /// Parameters:
  /// - [context]: The BuildContext .
  Locale? getDeviceLocale(BuildContext context) {
    Locale locale = context.deviceLocale;
    return locale;
  }

  /// Sets the locale in shared preferences.
  ///
  /// Parameters:
  /// - [locale]: The new locale to set and store.
  // set locale(Locale newLocale) {
  //   sl<SharedPreferencesService>().saveString(
  //     _localeTXT,
  //     newLocale.languageCode,
  //   );
  // }

  /// Checks if the current locale is Right-To-Left (RTL).
  bool get isRTL => currentLocale.languageCode == LocaleType.ar.name;
  TextDirection get textDirection =>
      isRTL ? TextDirection.RTL : TextDirection.LTR;

  /// Checks if the current locale is English.
  bool get isEn => currentLocale.languageCode == LocaleType.en.name;

  /// Checks if the current locale is Arabic.
  bool get isAr => currentLocale.languageCode == LocaleType.ar.name;
}
