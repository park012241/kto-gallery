import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kto_gallery/app_router.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'constants/constants.dart';

Future<void> main() async {
  /// Initialize Widget binding for wakelock
  WidgetsFlutterBinding.ensureInitialized();

  /// Load .env file
  await dotenv.load(
    fileName: '.env',
    mergeWith: Platform.environment,
  );

  /// Disable sleep for debug only
  if (kDebugMode) {
    await WakelockPlus.enable();
  }

  /// Finally run app
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
