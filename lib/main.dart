import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:red_edge_app/app.dart';
import 'package:red_edge_app/di/injection.dart';
import 'core/storage/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ✅ Light status bar for login screen (dark icons on light background)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, // ← dark icons
      statusBarBrightness: Brightness.light, // ← iOS
    ),
  );

  await HiveService.init();
  await HiveService.openBoxes();

  setupGetIt();

  runApp(
    const ProviderScope(
      child: RedEdgeApp(),
    ),
  );
}
