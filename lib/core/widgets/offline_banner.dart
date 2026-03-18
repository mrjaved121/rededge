import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:red_edge_app/core/network/network_info.dart';
import '../constants/app_colors.dart';
import '../constants/app_durations.dart';

class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.watch(connectivityStatusProvider).maybeWhen(
      data: (status) => !status,
      orElse: () => false,
    );

    return AnimatedSlide(
      offset: isOffline ? Offset.zero : const Offset(0, -1),
      duration: AppDurations.normal,
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: isOffline ? 1.0 : 0.0,
        duration: AppDurations.fast,
        child: Container(
          width: double.infinity,
          color: AppColors.offline,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          child: const SafeArea(
            bottom: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi_off_rounded, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  'Offline — data saved locally',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Simple connectivity provider — referenced across the app
final connectivityStatusProvider = StreamProvider<bool>((ref) {
  return ref.watch(networkInfoProvider).onConnectivityChanged;
});

// This will be provided via GetIt / override
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  throw UnimplementedError('Must be overridden');
});

// Re-export for convenience
// import '../network/network_info.dart';