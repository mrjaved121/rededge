import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:red_edge_app/core/widgets/status_badge.dart';
import 'package:red_edge_app/features/jobs/presentation/providers/job_provider.dart';
import 'package:red_edge_app/features/admin/presentation/providers/admin_provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';

class JobFilterBar extends ConsumerWidget {
  const JobFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final systemTypesAsync = ref.watch(systemTypesProvider);

    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: _FilterDropdown<JobStatus?>(
              value: ref.watch(
                  statusFilterProvider as ProviderListenable<JobStatus?>),
              label: 'All Status',
              items: [
                (null, 'All Status'),
                (JobStatus.draft, 'Draft'),
                (JobStatus.pending, 'Pending'),
                (JobStatus.inProgress, 'In Progress'),
                (JobStatus.completed, 'Completed'),
              ],
              onChanged: (v) =>
                  ref.read(statusFilterProvider.notifier).state = v,
            ),
          ),
          const SizedBox(width: AppSpacing.sm + 4),
          Expanded(
            child: systemTypesAsync.when(
              data: (types) => _FilterDropdown<String?>(
                value: ref
                    .watch(systemFilterProvider as ProviderListenable<String?>),
                label: 'All Systems',
                items: [
                  (null, 'All Systems'),
                  ...types.map((t) => (t, t)),
                ],
                onChanged: (v) =>
                    ref.read(systemFilterProvider.notifier).state = v,
              ),
              loading: () => _FilterDropdown<String?>(
                value: null,
                label: 'All Systems',
                items: [(null, 'All Systems')],
                onChanged: (_) {},
              ),
              error: (_, __) => _FilterDropdown<String?>(
                value: null,
                label: 'All Systems',
                items: [(null, 'All Systems')],
                onChanged: (_) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterDropdown<T> extends StatelessWidget {
  final T value;
  final String label;
  final List<(T, String)> items;
  final ValueChanged<T> onChanged;

  const _FilterDropdown({
    required this.value,
    required this.label,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm + 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              color: AppColors.textSecondary, size: 20),
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item.$1,
              child: Text(item.$2),
            );
          }).toList(),
          onChanged: (v) {
            if (v is T) onChanged(v);
          },
        ),
      ),
    );
  }
}
