import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';

/// Severity / intent of the log
enum LogType { log, error, route, debug, success, notification }

/// Application layer (auto-detected)
enum LogLayer { api, repository, state, view, domain, unknown }

/// Centralized logger utility
class Logger {
  Logger(dynamic data, [LogType type = LogType.log]) {
    _log(data, type);
  }

  // ---------------------------------------------------------------------------
  // Public helpers
  // ---------------------------------------------------------------------------

  static void error(dynamic data) => _log(data, LogType.error);
  static void route(dynamic data) => _log(data, LogType.route);
  static void debug(dynamic data) => _log(data, LogType.debug);
  static void success(dynamic data) => _log(data, LogType.success);
  static void notification(dynamic data) => _log(data, LogType.notification);

  // ---------------------------------------------------------------------------
  // Core logger
  // ---------------------------------------------------------------------------

  static void _log(dynamic data, LogType type) {
    if (!kDebugMode) return;

    final layer = _detectLayer();
    final color = _getLogColor(type);
    final message = _formatMessage(
      data: data.toString(),
      type: type,
      layer: layer,
    );

    dev.log('$color$message$_resetColor');
  }

  // ---------------------------------------------------------------------------
  // Layer detection (no manual parameters)
  // ---------------------------------------------------------------------------

  static LogLayer _detectLayer() {
    final stackLines = StackTrace.current.toString().split('\n');

    final caller = stackLines
        .firstWhere((line) => !line.contains('Logger'), orElse: () => '')
        .toLowerCase();

    if (caller.contains('dio') ||
        caller.contains('/remote/') ||
        caller.contains('/network/')) {
      return LogLayer.api;
    }

    if (caller.contains('/data/') || caller.contains('repository')) {
      return LogLayer.repository;
    }

    if (caller.contains('bloc') ||
        caller.contains('cubit') ||
        caller.contains('/state/')) {
      return LogLayer.state;
    }

    if (caller.contains('/presentation/') ||
        caller.contains('/ui/') ||
        caller.contains('widget')) {
      return LogLayer.view;
    }

    if (caller.contains('/domain/')) {
      return LogLayer.domain;
    }

    return LogLayer.unknown;
  }

  // ---------------------------------------------------------------------------
  // Formatting & colors
  // ---------------------------------------------------------------------------

  static String _formatMessage({
    required String data,
    required LogType type,
    required LogLayer layer,
  }) {
    return '[${type.name.toUpperCase()}]'
        '[${layer.name.toUpperCase()}] $data';
  }

  static String _getLogColor(LogType type) {
    switch (type) {
      case LogType.error:
        return '\x1B[31m'; // Red
      case LogType.route:
        return '\x1B[34m'; // Blue
      case LogType.debug:
        return '\x1B[35m'; // Magenta
      case LogType.success:
        return '\x1B[32m'; // Green
      case LogType.notification:
        return '\x1B[36m'; // Cyan
      case LogType.log:
        return '\x1B[33m'; // Yellow
    }
  }

  static const String _resetColor = '\x1B[0m';
}
