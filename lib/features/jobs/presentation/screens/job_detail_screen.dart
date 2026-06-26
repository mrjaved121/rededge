import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:printing/printing.dart';
import 'package:red_edge_app/features/jobs/presentation/providers/job_provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/system_chip.dart';
import '../../../../di/injection.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../admin/presentation/providers/admin_provider.dart';
import '../../domain/entities/job_entity.dart';
import '../../domain/entities/step_entity.dart';
import '../../domain/repositories/job_repository.dart';
import '../providers/step_provider.dart';
import '../services/pdf_report_service.dart';
import '../widgets/job_progress_bar.dart';

class JobDetailScreen extends ConsumerWidget {
  final String jobId;

  const JobDetailScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobAsync = ref.watch(jobDetailProvider(jobId));

    return jobAsync.when(
      data: (job) => _buildContent(context, ref, job),
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

  Widget _buildContent(BuildContext context, WidgetRef ref, JobEntity job) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Red Header ──
          SliverAppBar(
            expandedHeight: AppSpacing.appBarExpandedHeight,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                tooltip: 'Generate PDF Report',
                onPressed: () => _generateReport(context, job),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _JobDetailHeader(job: job),
            ),
          ),

          // ── Progress Section ──
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

          // ── Steps List grouped by section ──
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) {
                  final step = job.steps[i];
                  // Show section header when section changes
                  final showSectionHeader = step.section.isNotEmpty &&
                      (i == 0 || job.steps[i - 1].section != step.section);

                  void openCamera() async {
                    await context.push(
                      '/jobs/$jobId/steps/${step.id}/camera',
                    );
                    ref.invalidate(jobDetailProvider(jobId));
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showSectionHeader) ...[
                        if (i > 0) const SizedBox(height: AppSpacing.md),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.2),
                            ),
                          ),
                          child: Text(
                            step.section,
                            style: AppTextStyles.headlineSmall.copyWith(
                              color: AppColors.primary,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                      ],
                      _StepCard(
                        step: step,
                        jobId: jobId,
                        onTap: openCamera,
                        onToggle: () {
                          ref.read(stepActionProvider.notifier).completeStep(
                                jobId,
                                step.id,
                              );
                        },
                        onCamera: openCamera,
                        onInputSaved: (value) async {
                          await getIt<ApiClient>().completeStep(
                            jobId,
                            step.id,
                            {'inputValue': value, 'isCompleted': true},
                          );
                          ref.invalidate(jobDetailProvider(jobId));
                        },
                      ),
                    ],
                  );
                },
                childCount: job.steps.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 100), // Bottom padding for CTA
          ),
        ],
      ),
      bottomNavigationBar: _CompleteJobButton(job: job),
    );
  }
}

class _JobDetailHeader extends StatelessWidget {
  final JobEntity job;

  const _JobDetailHeader({required this.job});

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
          // Job ID + System chip
          Row(
            children: [
              Text(
                job.displayId,
                style: AppTextStyles.headlineMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              SystemChip(system: job.systemType),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Company
          Text(job.company, style: AppTextStyles.bodyMediumWhite),
          const SizedBox(height: AppSpacing.sm),

          // Status
          StatusBadge(status: job.status),
          const SizedBox(height: AppSpacing.sm),

          // Location
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

          // Date
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

class _StepCard extends StatefulWidget {
  final StepEntity step;
  final String jobId;
  final VoidCallback onTap;
  final VoidCallback onToggle;
  final VoidCallback onCamera;
  final Future<void> Function(String)? onInputSaved;

  const _StepCard({
    required this.step,
    required this.jobId,
    required this.onTap,
    required this.onToggle,
    required this.onCamera,
    this.onInputSaved,
  });

  @override
  State<_StepCard> createState() => _StepCardState();
}

class _StepCardState extends State<_StepCard> {
  late final TextEditingController _inputCtrl;
  String? _selectedOption;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _inputCtrl = TextEditingController(text: widget.step.inputValue);
    if (widget.step.inputType == 'select' && widget.step.inputValue.isNotEmpty) {
      _selectedOption = widget.step.inputValue;
    }
  }

  @override
  void dispose() {
    _inputCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveInput(String value) async {
    if (value.isEmpty || _isSaving) return;
    setState(() => _isSaving = true);
    try {
      await widget.onInputSaved?.call(value);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save — check your connection and try again'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = widget.step;
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        side: const BorderSide(color: AppColors.cardBorder),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        onTap: step.hasInput ? null : widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Checkbox
                  GestureDetector(
                    onTap: step.hasInput ? null : widget.onToggle,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, anim) => ScaleTransition(
                        scale: CurvedAnimation(
                          parent: anim,
                          curve: Curves.elasticOut,
                        ),
                        child: child,
                      ),
                      child: step.isCompleted
                          ? Container(
                              key: const ValueKey('checked'),
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.check,
                                  color: Colors.white, size: 18),
                            )
                          : Container(
                              key: const ValueKey('unchecked'),
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.disabled,
                                  width: 2,
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm + 4),

                  // Step info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Step ${step.number}',
                          style: AppTextStyles.stepLabel,
                        ),
                        const SizedBox(height: 2),
                        Text(step.title, style: AppTextStyles.stepTitle),
                      ],
                    ),
                  ),
                ],
              ),

              // Input field for text/number types
              if (step.hasInput) ...[
                const SizedBox(height: AppSpacing.sm),
                if (step.inputType == 'select' && step.options.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedOption,
                        isExpanded: true,
                        hint: Text(step.inputLabel, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textHint)),
                        items: step.options
                            .map((o) => DropdownMenuItem(value: o, child: Text(o, style: AppTextStyles.bodySmall)))
                            .toList(),
                        onChanged: (v) {
                          if (v != null) {
                            setState(() => _selectedOption = v);
                            widget.onInputSaved?.call(v);
                          }
                        },
                      ),
                    ),
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _inputCtrl,
                          keyboardType: step.inputType == 'number'
                              ? TextInputType.number
                              : TextInputType.text,
                          style: AppTextStyles.bodySmall,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (val) => _saveInput(val.trim()),
                          decoration: InputDecoration(
                            hintText: step.inputLabel,
                            hintStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.textHint),
                            filled: true,
                            fillColor: AppColors.surface,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppColors.cardBorder),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppColors.cardBorder),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppColors.primary, width: 2),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 44,
                        width: 72,
                        child: ElevatedButton(
                          onPressed: _isSaving
                              ? null
                              : () => _saveInput(_inputCtrl.text.trim()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor:
                                AppColors.primary.withOpacity(0.6),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _isSaving
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Save',
                                  style: TextStyle(fontSize: 13)),
                        ),
                      ),
                    ],
                  ),
                if (step.inputValue.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${step.inputLabel}: ${step.inputValue}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.completed,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],

              // Photo required banner
              if (step.needsPhoto) ...[
                const SizedBox(height: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs + 2,
                  ),
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
                        'Photo Required',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.warningText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Photo count badge
              if (step.hasPhoto) ...[
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Icon(Icons.photo_library,
                        size: 16, color: AppColors.completed),
                    const SizedBox(width: 4),
                    Text(
                      '${step.photoCount} photo${step.photoCount > 1 ? 's' : ''} captured',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.completed,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],

              // Camera button (only for photo-requiring steps or steps that aren't pure input)
              if (step.requiresPhoto || !step.hasInput) ...[
                const SizedBox(height: AppSpacing.sm),
                SizedBox(
                  height: 36,
                  child: OutlinedButton.icon(
                    onPressed: widget.onCamera,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    icon: const Icon(Icons.camera_alt_outlined, size: 16),
                    label: Text(
                      step.hasPhoto ? 'Add Photo' : 'Capture Photo',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CompleteJobButton extends ConsumerWidget {
  final JobEntity job;

  const _CompleteJobButton({required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final isAdmin = user?.isAdmin ?? false;

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
      child: SafeArea(
        child: isAdmin
            ? _buildAdminActions(context, ref)
            : _buildInstallerActions(context),
      ),
    );
  }

  Widget _buildAdminActions(BuildContext context, WidgetRef ref) {
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
                  borderRadius: BorderRadius.circular(12),
                ),
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
                  borderRadius: BorderRadius.circular(12),
                ),
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
      label: 'In Progress',
      icon: Icons.hourglass_empty,
      onTap: null,
    );
  }

  Widget _buildInstallerActions(BuildContext context) {
    final canComplete = job.isComplete;
    return AppPrimaryButton(
      label: canComplete ? 'Complete Installation' : 'In Progress',
      icon: canComplete ? Icons.check_circle : Icons.hourglass_empty,
      onTap: canComplete ? () => _completeJob(context) : null,
      color: canComplete ? AppColors.completed : null,
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

  void _completeJob(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Submit for Approval?'),
        content: const Text(
          'All steps are done. This will send the job to admin for review.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final result = await getIt<JobRepository>()
                  .updateJobStatus(job.id, 'needs_approval');
              result.fold(
                (failure) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed: ${failure.message}'),
                        backgroundColor: AppColors.error,
                      ),
                    );
                  }
                },
                (_) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Job submitted for admin approval!'),
                        backgroundColor: AppColors.completed,
                      ),
                    );
                    context.pop();
                  }
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.completed,
              foregroundColor: Colors.white,
            ),
            child: const Text('Submit for Approval'),
          ),
        ],
      ),
    );
  }
}
