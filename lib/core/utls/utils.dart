import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../config/flavors/flavor_config.dart';

import '../di/locator.dart';
import '../localization/localization_service.dart' show LocalizationService;

class Utils {
  static const Utils _instance = Utils._internal();
  factory Utils() => _instance;
  const Utils._internal();
  static Future<bool> checkInternetConnectivity() async {
    try {
      List<InternetAddress> result = await InternetAddress.lookup(
        FlavorConfig.instance.baseUrl,
      ).timeout(const Duration(seconds: 5));

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  // Reset the cache
  static void resetCache() {
    PaintingBinding.instance.imageCache.clear();
  }

  static String formatArabicDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('EEEE d MMMM', sl<LocalizationService>().currentLocale.languageCode);
    return formatter.format(dateTime);
  }
}
