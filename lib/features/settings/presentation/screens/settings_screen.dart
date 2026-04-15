import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/sync/sync_manager.dart';
import '../../../../core/widgets/app_bottom_nav.dart';
import '../../../../core/widgets/app_outline_button.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../jobs/presentation/providers/sync_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final syncAsync = ref.watch(syncStatusProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: AppTextStyles.headlineLargeWhite.copyWith(fontSize: 20),
            ),
            Text(
              'Manage your preferences',
              style: AppTextStyles.bodySmallWhite,
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Profile Card
          if (user != null) _ProfileCard(user: user),
          const SizedBox(height: AppSpacing.md),

          // Notifications
          _SectionCard(
            title: 'Notifications',
            icon: Icons.notifications_outlined,
            children: [
              _ToggleRow(label: 'Job Assignments', value: true, onChanged: (_) {}),
              _ToggleRow(label: 'Step Reminders', value: true, onChanged: (_) {}),
              _ToggleRow(label: 'Sync Alerts', value: false, onChanged: (_) {}),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Sync Status
          syncAsync.when(
            data: (sync) => _SyncStatusCard(syncState: sync, ref: ref),
            loading: () => const SizedBox(),
            error: (_, __) => _SyncStatusCard(
              syncState: const SyncState(),
              ref: ref,
            ),
          ),
          
          const SizedBox(height: AppSpacing.md),

          // Logout
          SizedBox(
            width: double.infinity,
            child: AppOutlineButton(
              label: 'Logout',
              icon: Icons.logout,
              borderColor: AppColors.primary,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(authProvider.notifier).logout();
                          context.go('/login');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final UserEntity user;
  const _ProfileCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        side: const BorderSide(color: AppColors.cardBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.primary,
              child: Text(
                user.initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name, style: AppTextStyles.headlineSmall),
                  Text(user.role, style: AppTextStyles.bodyMedium),
                  Text(user.email, style: AppTextStyles.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        side: const BorderSide(color: AppColors.cardBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Text(title, style: AppTextStyles.headlineSmall),
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyLarge),
          Switch.adaptive(
            value: value,
            activeColor: AppColors.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyMedium),
          Text(value, style: AppTextStyles.bodyLarge),
        ],
      ),
    );
  }
}

class _SyncStatusCard extends StatelessWidget {
  final SyncState syncState;
  final WidgetRef ref;

  const _SyncStatusCard({required this.syncState, required this.ref});

  @override
  Widget build(BuildContext context) {
    final isOnline = syncState.status != SyncStatus.error;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        side: const BorderSide(color: AppColors.cardBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.sync, size: 20, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Text('Sync Status', style: AppTextStyles.headlineSmall),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isOnline
                        ? AppColors.completed.withOpacity(0.1)
                        : AppColors.offline.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isOnline ? Icons.wifi : Icons.wifi_off,
                        size: 14,
                        color: isOnline
                            ? AppColors.completed
                            : AppColors.offline,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isOnline ? 'Online' : 'Offline',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: isOnline
                              ? AppColors.completed
                              : AppColors.offline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _InfoRow(
              label: 'Pending Operations',
              value: '${syncState.pendingCount}',
            ),
            if (syncState.failedCount > 0)
              _InfoRow(
                label: 'Failed (max retries)',
                value: '${syncState.failedCount}',
              ),
            if (syncState.lastSyncAt != null)
              _InfoRow(
                label: 'Last Sync',
                value: _formatTime(syncState.lastSyncAt!),
              ),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              width: double.infinity,
              child: AppPrimaryButton(
                label: syncState.status == SyncStatus.syncing
                    ? 'Syncing...'
                    : 'Sync Now',
                icon: Icons.sync,
                isLoading: syncState.status == SyncStatus.syncing,
                onTap: syncState.status == SyncStatus.syncing
                    ? null
                    : () => ref.read(syncManagerProvider).flush(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}