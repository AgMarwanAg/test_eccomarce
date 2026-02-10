
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/flavors/flavor_config.dart';
import 'core/init.dart';
import 'main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   FlavorConfig(baseUrl: 'https://dummyjson.com', flavor: Flavor.dev);
  // await Firebase.initializeApp(options: dev.DefaultFirebaseOptions.currentPlatform);
  await init();
  // EasyLocalization.logger.enableBuildModes = [];
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp((const MainApp()));
}

//TO run this app or build it use one of these commands
// To run the app in dev mode, run the following command:
// flutter run -t lib/main_dev.dart --flavor=dev 

// To run the app in prod mode, run the following command:
// flutter run -t lib/main_prod.dart --flavor=prod

// To build the apk in dev mode, run the following command:
// flutter build apk --split-per-abi -t lib/main_dev.dart --flavor=dev

// To build the apk in prod mode, run the following command:
// flutter build apk --split-per-abi -t lib/main_prod.dart --flavor=prod

// To build the appbundle in prod mode, run the following command:
// flutter build appbundle -t lib/main_prod.dart --flavor=prod

// To build the ios in prod mode, run the following command:
//flutter build ipa -t lib/main_prod.dart --flavor=prod
