import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:printing/printing.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/system_chip.dart';
import '../../../../di/injection.dart';
import '../../../jobs/domain/entities/job_entity.dart';
import '../../../jobs/domain/entities/photo_entity.dart';
import '../../../jobs/domain/entities/step_entity.dart';
import '../../../jobs/domain/repositories/job_repository.dart';
import '../../../jobs/presentation/providers/job_provider.dart';
import '../../../jobs/presentation/services/pdf_report_service.dart';
import '../../../jobs/presentation/widgets/job_progress_bar.dart';
import '../providers/admin_provider.dart';

class AdminJobDetailScreen extends ConsumerWidget {
  final String jobId;

  const AdminJobDetailScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobAsync = ref.watch(jobDetailProvider(jobId));

    return jobAsync.when(
      data: (job) => _AdminJobDetailContent(job: job),
      loading: () => const Scaffold(
        body:
            Center(child: CircularProgressIndicator(color: AppColors.primary)),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(backgroundColor: AppColors.primary),
        body: Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _AdminJobDetailContent extends ConsumerWidget {
  final JobEntity job;

  const _AdminJobDetailContent({required this.job});

  Future<void> _generateReport(BuildContext context, JobEntity job) async {
    try {
      final pdfBytes = await PdfReportService.generateJobReport(job);
      if (!context.mounted) return;
      await Printing.layoutPdf(
        onLayout: (_) => pdfBytes,
        name: '${job.title.replaceAll(RegExp(r'[^\w\s]'), '')}_Report',
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to generate report: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            expandedHeight: AppSpacing.appBarExpandedHeight,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onSelected: (value) {
                  if (value == 'edit') {
                    context.push('/admin/edit-job/${job.id}');
                  } else if (value == 'report') {
                    _generateReport(context, job);
                  }
                },
                itemBuilder: (_) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: ListTile(
                      leading:
                          Icon(Icons.edit, color: AppColors.primary, size: 20),
                      title: Text('Edit Job'),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'report',
                    child: ListTile(
                      leading:
                          Icon(Icons.picture_as_pdf, color: AppColors.primary, size: 20),
                      title: Text('Generate Report'),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _Header(job: job),
            ),
          ),

          // Progress
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Installation Progress',
                      style: AppTextStyles.headlineSmall),
                  const SizedBox(height: AppSpacing.sm),
                  JobProgressBar(
                    completed: job.completedSteps,
                    total: job.totalSteps,
                  ),
                ],
              ),
            ),
          ),

          // Job Info Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: _JobInfoCard(job: job),
            ),
          ),

          // Steps Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm),
              child: Text('Installation Steps',
                  style: AppTextStyles.headlineSmall),
            ),
          ),

          // Steps List (read-only tracking)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => _AdminStepCard(step: job.steps[i], jobId: job.id),
                childCount: job.steps.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      bottomNavigationBar: _AdminBottomBar(job: job),
    );
  }
}

class _Header extends StatelessWidget {
  final JobEntity job;
  const _Header({required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        MediaQuery.of(context).padding.top + 56,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Text(job.displayId,
                  style: AppTextStyles.headlineMedium
                      .copyWith(color: Colors.white)),
              const SizedBox(width: AppSpacing.sm),
              SystemChip(system: job.systemType),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(job.company, style: AppTextStyles.bodyMediumWhite),
          const SizedBox(height: AppSpacing.sm),
          StatusBadge(status: job.status),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white70, size: 16),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  job.address.isNotEmpty ? job.address : job.location,
                  style: AppTextStyles.bodySmallWhite,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.white70, size: 16),
              const SizedBox(width: 4),
              Text(job.formattedDate, style: AppTextStyles.bodySmallWhite),
            ],
          ),
        ],
      ),
    );
  }
}

class _JobInfoCard extends StatelessWidget {
  final JobEntity job;
  const _JobInfoCard({required this.job});

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
            Text('Job Details', style: AppTextStyles.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            if (job.description != null && job.description!.isNotEmpty) ...[
              _InfoRow(
                  icon: Icons.description,
                  label: 'Description',
                  value: job.description!),
              const SizedBox(height: AppSpacing.xs),
            ],
            _InfoRow(
                icon: Icons.person,
                label: 'Assigned To',
                value: job.assignedToName ?? 'Unassigned'),
            const SizedBox(height: AppSpacing.xs),
            _InfoRow(
                icon: Icons.business,
                label: 'Company',
                value: job.company.isNotEmpty ? job.company : 'N/A'),
            const SizedBox(height: AppSpacing.xs),
            _InfoRow(
                icon: Icons.location_on,
                label: 'Location',
                value: job.address.isNotEmpty ? job.address : job.location),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: AppTextStyles.bodySmall,
              children: [
                TextSpan(
                    text: '$label: ',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AdminStepCard extends StatelessWidget {
  final StepEntity step;
  final String jobId;

  const _AdminStepCard({required this.step, required this.jobId});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
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
            // Step header
            Row(
              children: [
                // Status icon
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: step.isCompleted
                        ? AppColors.completed
                        : AppColors.disabled.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    step.isCompleted
                        ? Icons.check
                        : Icons.radio_button_unchecked,
                    color: step.isCompleted ? Colors.white : AppColors.disabled,
                    size: 18,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm + 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Step ${step.number}',
                          style: AppTextStyles.stepLabel),
                      const SizedBox(height: 2),
                      Text(step.title, style: AppTextStyles.stepTitle),
                    ],
                  ),
                ),
                // Status chip
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: step.isCompleted
                        ? AppColors.completed.withOpacity(0.1)
                        : AppColors.warning,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    step.isCompleted ? 'Done' : 'Pending',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: step.isCompleted
                          ? AppColors.completed
                          : AppColors.warningText,
                    ),
                  ),
                ),
              ],
            ),

            // Description
            if (step.description != null && step.description!.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(step.description!, style: AppTextStyles.bodySmall),
            ],

            // Notes from installer
            if (step.notes != null && step.notes!.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.inProgress.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.note,
                        size: 16, color: AppColors.inProgress),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Installer note: ${step.notes}',
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.inProgress),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Photos uploaded by installer
            if (step.hasPhoto) ...[
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Icon(Icons.photo_library,
                      size: 16, color: AppColors.completed),
                  const SizedBox(width: 4),
                  Text(
                    '${step.photoCount} photo${step.photoCount > 1 ? 's' : ''} uploaded',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.completed,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: step.photos.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (ctx, i) {
                    final photo = step.photos[i];
                    final isLocal = photo.localPath.isNotEmpty &&
                        !photo.localPath.startsWith('/uploads') &&
                        File(photo.localPath).existsSync();
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: GestureDetector(
                        onTap: () => _showPhotoFullscreen(ctx, photo, isLocal),
                        child: Container(
                          width: 80,
                          height: 80,
                          color: AppColors.cardBorder,
                          child: isLocal
                              ? Image.file(File(photo.localPath),
                                  fit: BoxFit.cover)
                              : (photo.thumbnailUrl ?? photo.remoteUrl) != null
                                  ? CachedNetworkImage(
                                      imageUrl: _buildThumbnailUrl(
                                          photo.thumbnailUrl ??
                                              photo.remoteUrl!),
                                      fit: BoxFit.cover,
                                      placeholder: (ctx, url) => const Center(
                                        child: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: AppColors.primary),
                                        ),
                                      ),
                                      errorWidget: (ctx, url, err) =>
                                          const Icon(Icons.broken_image,
                                              color: AppColors.textSecondary),
                                    )
                                  : const Icon(Icons.photo,
                                      color: AppColors.textSecondary),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ] else if (step.requiresPhoto) ...[
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm, vertical: AppSpacing.xs + 2),
                decoration: BoxDecoration(
                  color: AppColors.warning,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.camera_alt,
                        size: 14, color: AppColors.warningText),
                    const SizedBox(width: 4),
                    Text(
                      'Photo required – not yet uploaded',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.warningText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _buildPhotoUrl(String path) {
    if (path.startsWith('http')) return path;
    // Legacy local uploads fallback
    return 'http://192.168.100.116:3000$path';
  }

  String _buildThumbnailUrl(String path) {
    if (path.contains('ik.imagekit.io')) {
      return '$path?tr=w-160,h-160,fo-auto';
    }
    return _buildPhotoUrl(path);
  }

  void _showPhotoFullscreen(
      BuildContext context, PhotoEntity photo, bool isLocal) {
    final localPath = photo.localPath;
    final remoteUrl = photo.remoteUrl;
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: isLocal
                        ? Image.file(File(localPath))
                        : remoteUrl != null
                            ? CachedNetworkImage(
                                imageUrl: _buildPhotoUrl(remoteUrl),
                                placeholder: (ctx, url) => const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white)),
                                errorWidget: (ctx, url, err) => const Icon(
                                    Icons.broken_image,
                                    color: Colors.white54,
                                    size: 48),
                              )
                            : const Icon(Icons.photo,
                                color: Colors.white54, size: 48),
                  ),
                  // GPS + address info
                  if (photo.hasGps) ...[
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      color: Colors.black87,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.gps_fixed,
                                  color: Colors.white70, size: 14),
                              const SizedBox(width: 6),
                              Text(
                                photo.gpsString,
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 12),
                              ),
                            ],
                          ),
                          if (photo.address != null &&
                              photo.address!.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.white70, size: 14),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    photo.address!,
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(dialogContext),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminBottomBar extends ConsumerWidget {
  final JobEntity job;
  const _AdminBottomBar({required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(child: _buildActions(context, ref)),
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref) {
    if (job.status == JobStatus.needsApproval) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _updateStatus(context, ref, 'in_progress'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.undo, size: 20),
              label: const Text('Reject'),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: () => _updateStatus(context, ref, 'completed'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.completed,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.check_circle, size: 20),
              label: const Text('Approve & Complete'),
            ),
          ),
        ],
      );
    }

    if (job.status == JobStatus.draft) {
      return AppPrimaryButton(
        label: 'Assign & Send to Installer',
        icon: Icons.send,
        onTap: () => _updateStatus(context, ref, 'pending'),
      );
    }

    if (job.status == JobStatus.completed) {
      return AppPrimaryButton(
        label: 'Completed',
        icon: Icons.check_circle,
        onTap: null,
        color: AppColors.completed,
      );
    }

    return AppPrimaryButton(
      label: 'In Progress – Waiting on Installer',
      icon: Icons.hourglass_empty,
      onTap: null,
    );
  }

  Future<void> _updateStatus(
      BuildContext context, WidgetRef ref, String status) async {
    final result = await getIt<JobRepository>().updateJobStatus(job.id, status);
    result.fold(
      (failure) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed: ${failure.message}')),
          );
        }
      },
      (_) {
        ref.invalidate(jobDetailProvider(job.id));
        ref.invalidate(adminJobsProvider);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Job status updated to $status'),
              backgroundColor: AppColors.completed,
            ),
          );
        }
      },
    );
  }
}
