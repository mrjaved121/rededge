import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

enum JobStatus { draft, pending, inProgress, completed, needsApproval }

class StatusBadge extends StatelessWidget {
  final JobStatus status;

  const StatusBadge({super.key, required this.status});

  static const _config = {
    JobStatus.draft: _BadgeConfig('DRAFT', AppColors.draft),
    JobStatus.pending: _BadgeConfig('PENDING', AppColors.pending),
    JobStatus.inProgress: _BadgeConfig('IN PROGRESS', AppColors.inProgress),
    JobStatus.completed: _BadgeConfig('COMPLETED', AppColors.completed),
    JobStatus.needsApproval: _BadgeConfig('NEEDS APPROVAL', Color(0xFFE65100)),
  };

  @override
  Widget build(BuildContext context) {
    final cfg = _config[status]!;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + 4,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: cfg.color,
        borderRadius: BorderRadius.circular(AppSpacing.badgeRadius),
      ),
      child: Text(
        cfg.label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _BadgeConfig {
  final String label;
  final Color color;
  const _BadgeConfig(this.label, this.color);
}

extension JobStatusX on JobStatus {
  String get apiValue => switch (this) {
        JobStatus.draft => 'draft',
        JobStatus.pending => 'pending',
        JobStatus.inProgress => 'in_progress',
        JobStatus.completed => 'completed',
        JobStatus.needsApproval => 'needs_approval',
      };

  static JobStatus fromApi(String value) => switch (value) {
        'draft' => JobStatus.draft,
        'pending' => JobStatus.pending,
        'in_progress' => JobStatus.inProgress,
        'completed' => JobStatus.completed,
        'needs_approval' => JobStatus.needsApproval,
        _ => JobStatus.draft,
      };
}
