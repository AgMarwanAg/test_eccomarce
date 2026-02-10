
import 'di/locator.dart';
import 'logging/logger.dart';

Future init() async {
 try {
    await setUpLocator();
  
 } catch (e) {
 Logger.error(e);  
 }
}
