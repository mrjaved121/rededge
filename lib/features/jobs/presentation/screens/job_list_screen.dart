import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:red_edge_app/features/jobs/presentation/providers/job_provider.dart' show filteredJobsProvider, jobsNotifierProvider;
import 'package:shimmer/shimmer.dart';
import 'package:red_edge_app/core/constants/app_colors.dart';
import 'package:red_edge_app/core/constants/app_spacing.dart';
import 'package:red_edge_app/core/constants/app_text_styles.dart';
import 'package:red_edge_app/core/widgets/app_bottom_nav.dart';
import 'package:red_edge_app/core/widgets/skeleton_box.dart';
import 'package:red_edge_app/features/jobs/presentation/widgets/job_card.dart';
import 'package:red_edge_app/features/jobs/presentation/widgets/job_filter_bar.dart';

class JobListScreen extends ConsumerWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(filteredJobsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          'My Installations',
          style: AppTextStyles.headlineLargeWhite.copyWith(fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          const JobFilterBar(),
          Expanded(
            child: jobsAsync.when(
              data: (jobs) => jobs.isEmpty
                  ? _buildEmptyState()
                  : RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () =>
                    ref.refresh(jobsNotifierProvider.future),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.sm,
                  ),
                  itemCount: jobs.length,
                  itemBuilder: (_, i) => JobCard(
                    job: jobs[i],
                    onTap: () => context.push('/jobs/${jobs[i].id}'),
                  ),
                ),
              ),
              loading: () => _buildSkeleton(),
              error: (e, _) => _buildError(e.toString(), ref),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.work_off_outlined,
              size: 64, color: AppColors.textSecondary.withOpacity(0.5)),
          const SizedBox(height: AppSpacing.md),
          Text('No installations found', style: AppTextStyles.headlineSmall),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Pull down to refresh or create a new job',
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildSkeleton() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        itemCount: 4,
        itemBuilder: (_, __) => const _SkeletonJobCard(),
      ),
    );
  }

  Widget _buildError(String message, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: AppSpacing.md),
            Text(message,
                textAlign: TextAlign.center, style: AppTextStyles.bodyLarge),
            const SizedBox(height: AppSpacing.md),
            TextButton.icon(
              onPressed: () => ref.invalidate(jobsNotifierProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  }


class _SkeletonJobCard extends StatelessWidget {
  const _SkeletonJobCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SkeletonBox(width: 70, height: 14),
                const SizedBox(width: AppSpacing.sm),
                const SkeletonBox(width: 80, height: 24),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            const SkeletonBox(width: double.infinity, height: 20),
            const SizedBox(height: AppSpacing.sm),
            const SkeletonBox(width: 160, height: 14),
            const SizedBox(height: AppSpacing.xs),
            const SkeletonBox(width: 120, height: 14),
          ],
        ),
      ),
    );
  }
}