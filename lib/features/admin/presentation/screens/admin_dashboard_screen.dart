import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/network/api_config.dart';
import '../../../../core/widgets/app_bottom_nav.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/system_chip.dart';
import '../../../../di/injection.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../jobs/domain/entities/job_entity.dart';
import '../../../jobs/domain/repositories/job_repository.dart';
import '../providers/admin_provider.dart';

class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  final _searchController = TextEditingController();
  JobStatus? _statusFilter;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jobsAsync = ref.watch(adminJobsProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Admin Dashboard',
              style: AppTextStyles.headlineLargeWhite.copyWith(fontSize: 20),
            ),
            if (user != null)
              Text(
                'Welcome, ${user.name}',
                style: AppTextStyles.bodySmallWhite,
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.checklist_rtl, color: Colors.white),
            onPressed: () => context.push('/admin/checklists'),
            tooltip: 'Checklist Templates',
          ),
          IconButton(
            icon: const Icon(Icons.people_outline, color: Colors.white),
            onPressed: () => context.push('/admin/installers'),
            tooltip: 'Manage Installers',
          ),
          IconButton(
            icon: const Icon(Icons.table_chart_outlined, color: Colors.white),
            onPressed: () => _openChecklistManager(context),
            tooltip: 'Excel Checklist Manager',
          ),
        ],
      ),
      body: jobsAsync.when(
        data: (jobs) => _buildContent(jobs),
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: AppSpacing.md),
              Text(e.toString(), textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.md),
              TextButton.icon(
                onPressed: () => ref.invalidate(adminJobsProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/admin/create-job'),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add),
        label: const Text('Create Job'),
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }

  Future<void> _openChecklistManager(BuildContext context) async {
    final uri = Uri.parse(ApiConfig.checklistManagerUrl);
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the Checklist Manager')),
      );
    }
  }

  Widget _buildContent(List<JobEntity> allJobs) {
    // Stats
    final totalJobs = allJobs.length;
    final pendingApproval =
        allJobs.where((j) => j.status == JobStatus.needsApproval).length;
    final inProgress =
        allJobs.where((j) => j.status == JobStatus.inProgress).length;
    final completed =
        allJobs.where((j) => j.status == JobStatus.completed).length;

    // Filter
    var filteredJobs = allJobs;
    if (_statusFilter != null) {
      filteredJobs =
          filteredJobs.where((j) => j.status == _statusFilter).toList();
    }
    final query = _searchController.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      filteredJobs = filteredJobs
          .where((j) =>
              j.title.toLowerCase().contains(query) ||
              j.jobNumber.toLowerCase().contains(query) ||
              j.location.toLowerCase().contains(query) ||
              j.company.toLowerCase().contains(query) ||
              (j.assignedToName?.toLowerCase().contains(query) ?? false))
          .toList();
    }

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => ref.refresh(adminJobsProvider.future),
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Stats Cards
          Row(
            children: [
              _StatCard(
                label: 'Total Jobs',
                value: '$totalJobs',
                color: AppColors.primary,
                icon: Icons.work,
                isSelected: _statusFilter == null,
                onTap: () => setState(() => _statusFilter = null),
              ),
              const SizedBox(width: AppSpacing.sm),
              _StatCard(
                label: 'Needs Approval',
                value: '$pendingApproval',
                color: const Color(0xFFE65100),
                icon: Icons.pending_actions,
                isSelected: _statusFilter == JobStatus.needsApproval,
                onTap: () => setState(() {
                  _statusFilter = _statusFilter == JobStatus.needsApproval
                      ? null
                      : JobStatus.needsApproval;
                }),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              _StatCard(
                label: 'In Progress',
                value: '$inProgress',
                color: AppColors.inProgress,
                icon: Icons.engineering,
                isSelected: _statusFilter == JobStatus.inProgress,
                onTap: () => setState(() {
                  _statusFilter = _statusFilter == JobStatus.inProgress
                      ? null
                      : JobStatus.inProgress;
                }),
              ),
              const SizedBox(width: AppSpacing.sm),
              _StatCard(
                label: 'Completed',
                value: '$completed',
                color: AppColors.completed,
                icon: Icons.check_circle,
                isSelected: _statusFilter == JobStatus.completed,
                onTap: () => setState(() {
                  _statusFilter = _statusFilter == JobStatus.completed
                      ? null
                      : JobStatus.completed;
                }),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Search bar
          TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Search jobs...',
              hintStyle:
                  AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint),
              prefixIcon:
                  const Icon(Icons.search, color: AppColors.textSecondary),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                    )
                  : null,
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                borderSide: const BorderSide(color: AppColors.cardBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                borderSide: const BorderSide(color: AppColors.cardBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                borderSide:
                    const BorderSide(color: AppColors.primary, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Results header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _statusFilter != null
                    ? '${_statusFilter!.name.toUpperCase()} (${filteredJobs.length})'
                    : 'All Jobs (${filteredJobs.length})',
                style: AppTextStyles.headlineSmall,
              ),
              if (_statusFilter != null)
                TextButton(
                  onPressed: () => setState(() => _statusFilter = null),
                  child: const Text('Clear filter'),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Job cards
          if (filteredJobs.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.work_off_outlined,
                        size: 48,
                        color: AppColors.textSecondary.withOpacity(0.5)),
                    const SizedBox(height: AppSpacing.sm),
                    Text('No jobs found', style: AppTextStyles.bodyMedium),
                  ],
                ),
              ),
            )
          else
            ...filteredJobs.map((job) => _AdminJobCard(
                  job: job,
                  onTap: () => context.push('/admin/jobs/${job.id}'),
                  onEdit: () => context.push('/admin/edit-job/${job.id}'),
                  onDelete: () => _confirmDeleteJob(job),
                  onStatusChange: (status) => _changeJobStatus(job, status),
                )),
        ],
      ),
    );
  }

  void _confirmDeleteJob(JobEntity job) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Job?'),
        content: Text(
            'Are you sure you want to delete \"${job.title}\" (${job.displayId})?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final result = await getIt<JobRepository>().deleteJob(job.id);
              result.fold(
                (failure) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed: ${failure.message}')),
                    );
                  }
                },
                (_) {
                  ref.invalidate(adminJobsProvider);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Job deleted'),
                        backgroundColor: AppColors.completed,
                      ),
                    );
                  }
                },
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _changeJobStatus(JobEntity job, String status) async {
    final result = await getIt<JobRepository>().updateJobStatus(job.id, status);
    result.fold(
      (failure) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed: ${failure.message}')),
          );
        }
      },
      (_) {
        ref.invalidate(adminJobsProvider);
        if (mounted) {
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

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.1) : AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            border: Border.all(
              color: isSelected ? color : AppColors.cardBorder,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: AppSpacing.sm),
              Text(
                value,
                style: AppTextStyles.headlineLarge.copyWith(color: color),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdminJobCard extends StatelessWidget {
  final JobEntity job;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final void Function(String status) onStatusChange;

  const _AdminJobCard({
    required this.job,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        side: const BorderSide(color: AppColors.cardBorder),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  Text(
                    job.displayId,
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  StatusBadge(status: job.status),
                  const Spacer(),
                  Flexible(child: SystemChip(system: job.systemType)),
                  const SizedBox(width: 4),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert,
                        size: 20, color: AppColors.textSecondary),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          onEdit();
                          break;
                        case 'delete':
                          onDelete();
                          break;
                        default:
                          if (value.startsWith('status_')) {
                            onStatusChange(value.replaceFirst('status_', ''));
                          }
                      }
                    },
                    itemBuilder: (_) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: ListTile(
                          leading: Icon(Icons.edit,
                              color: AppColors.primary, size: 20),
                          title: Text('Edit Job'),
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      if (job.status == JobStatus.needsApproval) ...[
                        const PopupMenuItem(
                          value: 'status_completed',
                          child: ListTile(
                            leading: Icon(Icons.check_circle,
                                color: AppColors.completed, size: 20),
                            title: Text('Approve'),
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'status_in_progress',
                          child: ListTile(
                            leading: Icon(Icons.undo,
                                color: AppColors.inProgress, size: 20),
                            title: Text('Reject (Back to In Progress)'),
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                      if (job.status == JobStatus.draft)
                        const PopupMenuItem(
                          value: 'status_pending',
                          child: ListTile(
                            leading: Icon(Icons.send,
                                color: AppColors.inProgress, size: 20),
                            title: Text('Send to Installer'),
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                        value: 'delete',
                        child: ListTile(
                          leading: Icon(Icons.delete,
                              color: AppColors.error, size: 20),
                          title: Text('Delete Job',
                              style: TextStyle(color: AppColors.error)),
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),

              // Title
              Text(job.title, style: AppTextStyles.headlineSmall),
              const SizedBox(height: AppSpacing.xs),

              // Company
              if (job.company.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(job.company, style: AppTextStyles.bodyMedium),
                ),

              // Location
              Row(
                children: [
                  const Icon(Icons.location_on,
                      size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      job.address.isNotEmpty ? job.address : job.location,
                      style: AppTextStyles.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xs),

              // Bottom row: date + assigned installer
              Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text(job.formattedDate, style: AppTextStyles.bodySmall),
                  const Spacer(),
                  if (job.assignedToName != null) ...[
                    const Icon(Icons.person,
                        size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      job.assignedToName!,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),

              // Progress bar
              if (job.totalSteps > 0) ...[
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: job.progressPercent,
                          backgroundColor: AppColors.cardBorder,
                          color: job.isComplete
                              ? AppColors.completed
                              : AppColors.primary,
                          minHeight: 4,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      '${job.completedSteps}/${job.totalSteps}',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
