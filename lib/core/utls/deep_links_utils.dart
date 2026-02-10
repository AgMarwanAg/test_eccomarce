import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import '../../../core/logging/logger.dart';
import '../services/routing/navigator_service.dart';

///```dart
/// A service responsible for managing and routing deep links within the application.
///
/// It validates incoming paths against an allowed list and ensures navigation 
/// is performed safely using the [NavigationService].
///```

class DeepLinkService {
  DeepLinkService._();

  static void handle(Map<String, dynamic> data) {
    final path = data['path'] as String?;
    if (path == null || path.isEmpty) {
      Logger.notification('DeepLinkService: No valid path found in data.');
      return;
    }

    // Validate the path
    final isAllowed = _allowedPaths.any((allowed) {
      // For parameterized routes like '/support/:id', check the base path
      if (allowed.contains('/:')) {
        final basePath = allowed.substring(0, allowed.indexOf('/:'));
        return path.startsWith(basePath);
      }
      return path.startsWith(allowed);
    });
    if (!isAllowed) {
      Logger.notification('DeepLinkService: Blocked unauthorized path "$path"');
      return;
    }

    // Schedule navigation safely after the current frame
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final context = NavigationService.navigatorKey.currentContext;

      if (context == null) {
        Logger.notification('DeepLinkService: Context not ready, retrying...');
        Future.delayed(const Duration(milliseconds: 300), () => handle(data));
        return;
      }

      try {
        Logger.notification('DeepLinkService: Navigating to $path');
        context.go(path);
      } catch (e, s) {
        Logger.notification('DeepLinkService navigation error: $e\n$s');
      }
    });
  }

  /// List of allowed route paths for security and validation.
  static const List<String> _allowedPaths = [
   
  ];
}
