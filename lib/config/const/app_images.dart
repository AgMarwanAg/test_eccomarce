import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppImages {
  const AppImages._();

  /// This Base Path Image
  static const String _root = "assets/images/";

  //Images
  static const String logo = '${_root}app_logo.png';
  static const String sa = '${_root}sa.png';
  static const String onBoarding1 = '${_root}onboarding1.png';
  static const String onBoarding2 = '${_root}onboarding2.png';
  static const String packages = '${_root}packages.png';
}
