import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'dependencies_injection.dart';
import 'main_app.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await FMTCObjectBoxBackend().initialise();

      Intl.systemLocale = await findSystemLocale();
      
      await serviceLocator();

      return SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
      ).then((_) => runApp(const MainApp()));
    },
    (error, stackTrace) async {
      debugPrint(error.toString());
    },
  );
}
