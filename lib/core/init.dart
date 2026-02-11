import 'package:test_eccomarce/core/database/database_helper.dart';

import 'di/locator.dart';
import 'logging/logger.dart';

Future init() async {
  try {
    // Initialize Hive database
    await DatabaseHelper.instance.init();

    // Setup dependency injection
    await setUpLocator();
  } catch (e) {
    Logger.error(e);
  }
}
