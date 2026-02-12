import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectionService {
  InternetConnectionService._();

  static final _connectivity = Connectivity();
  static final _checker = InternetConnection();

  /// Emits true when device has actual internet access.
  static Stream<bool> get onInternetStatusChange async* {
    await for (final _ in _connectivity.onConnectivityChanged) {
      final hasInternet = await _checker.hasInternetAccess;
      yield hasInternet;
    }
  }

  /// Initial check (useful for first build)
  static Future<bool> get initialStatus =>
      _checker.hasInternetAccess;
}
