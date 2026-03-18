import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:red_edge_app/core/router/app_router.dart';
import 'package:red_edge_app/di/injection.dart';
import 'package:red_edge_app/features/auth/presentation/providers/auth_provider.dart';
import 'core/constants/app_colors.dart';
import 'core/network/network_info.dart';
import 'core/sync/sync_manager.dart';
import 'core/widgets/offline_banner.dart';

class RedEdgeApp extends ConsumerStatefulWidget {
  const RedEdgeApp({super.key});

  @override
  ConsumerState<RedEdgeApp> createState() => _RedEdgeAppState();
}

class _RedEdgeAppState extends ConsumerState<RedEdgeApp> {
  @override
  void initState() {
    super.initState();
    _startConnectivityListener();
    // Check for existing auth session on app start
    Future.microtask(() {
      ref.read(authProvider.notifier).checkAuth();
    });
  }

  void _startConnectivityListener() {
    getIt<NetworkInfo>().onConnectivityChanged.listen((isConnected) {
      if (isConnected) {
        getIt<SyncManager>().flush();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Red Edge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          surface: AppColors.surface,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.interTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.cardBorder),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: const Size(0, 48),
          ),
        ),
      ),
      routerConfig: router,

      // ✅ FIXED — Stack overlay instead of Column
      builder: (context, child) {
        return Stack(
          children: [
            // App content fills entire screen
            Positioned.fill(
              child: child ?? const SizedBox(),
            ),
            // Banner overlays on top — no layout space taken
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: OfflineBanner(),
            ),
          ],
        );
      },
    );
  }
}
