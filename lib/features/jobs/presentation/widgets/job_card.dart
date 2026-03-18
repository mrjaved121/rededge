import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/system_chip.dart';
import '../../domain/entities/job_entity.dart';
import 'job_progress_bar.dart';

class JobCard extends StatelessWidget {
  final JobEntity job;
  final VoidCallback onTap;

  const JobCard({super.key, required this.job, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        side: const BorderSide(color: AppColors.cardBorder),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: ID + badges + chevron
              Row(
                children: [
                  Text(job.displayId, style: AppTextStyles.jobId),
                  const SizedBox(width: AppSpacing.sm),
                  StatusBadge(status: job.status),
                  const SizedBox(width: AppSpacing.sm),
                  Flexible(child: SystemChip(system: job.systemType)),
                  const SizedBox(width: 4),
                  if (!job.isSynced)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Icon(
                        Icons.cloud_off,
                        size: 16,
                        color: AppColors.offline,
                      ),
                    ),
                  const Icon(Icons.chevron_right,
                      color: AppColors.textSecondary),
                ],
              ),
              const SizedBox(height: AppSpacing.sm + 4),

              // Title
              Text(job.title, style: AppTextStyles.jobTitle),
              const SizedBox(height: AppSpacing.sm),

              // Location
              _MetaRow(
                icon: Icons.location_on_outlined,
                text: job.location,
              ),
              const SizedBox(height: AppSpacing.xs),

              // Date
              _MetaRow(
                icon: Icons.calendar_today_outlined,
                text: job.formattedDate,
              ),

              // Progress bar (only for in-progress jobs)
              if (job.status == JobStatus.inProgress) ...[
                const SizedBox(height: AppSpacing.sm + 4),
                JobProgressBar(
                  completed: job.completedSteps,
                  total: job.totalSteps,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MetaRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
