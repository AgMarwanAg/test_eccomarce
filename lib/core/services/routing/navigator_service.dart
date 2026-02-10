import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext? _currentContext;

  static BuildContext get currentContext =>
      _currentContext ?? navigatorKey.currentContext!;

  static void updateCurrentContext(BuildContext context) {
    _currentContext = context;
  }

  // Navigate using GoRouter
  static Future<void> goTo(
    String routeName, {
    Map<String, String>? params,
  }) async {
    GoRouter.of(currentContext).go(routeName);
  }

  // Navigate and replace all routes
  static Future<void> goAndRemoveUntil(
    String routeName, {
    Map<String, String>? params,
  }) async {
    GoRouter.of(currentContext).replaceNamed(routeName);
  }

  // Go back
  static void goBack() {
    GoRouter.of(currentContext).pop();
  }
}
