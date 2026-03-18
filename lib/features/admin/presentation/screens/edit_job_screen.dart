import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../di/injection.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../jobs/domain/entities/job_entity.dart';
import '../../../jobs/domain/repositories/job_repository.dart';
import '../../../jobs/presentation/providers/job_provider.dart';
import '../providers/admin_provider.dart';

class EditJobScreen extends ConsumerStatefulWidget {
  final String jobId;

  const EditJobScreen({super.key, required this.jobId});

  @override
  ConsumerState<EditJobScreen> createState() => _EditJobScreenState();
}

class _EditJobScreenState extends ConsumerState<EditJobScreen> {
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _addressController = TextEditingController();
  final _companyController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedSystem;
  UserEntity? _selectedInstaller;
  DateTime _scheduledDate = DateTime.now();
  bool _isLoading = false;
  String? _errorMessage;
  bool _initialized = false;

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _addressController.dispose();
    _companyController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _initFromJob(JobEntity job, List<UserEntity> installers) {
    if (_initialized) return;
    _initialized = true;
    _titleController.text = job.title;
    _locationController.text = job.location;
    _addressController.text = job.address;
    _companyController.text = job.company;
    _descriptionController.text = job.description ?? '';
    _selectedSystem = job.systemType;
    _scheduledDate = job.date;
    if (job.assignedToId != null) {
      _selectedInstaller =
          installers.where((u) => u.id == job.assignedToId).firstOrNull;
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _scheduledDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _scheduledDate = picked);
    }
  }

  Future<void> _updateJob() async {
    final title = _titleController.text.trim();
    final location = _locationController.text.trim();
    final address = _addressController.text.trim();
    final company = _companyController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty) {
      setState(() => _errorMessage = 'Job title is required');
      return;
    }
    if (location.isEmpty) {
      setState(() => _errorMessage = 'Location is required');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final data = <String, dynamic>{
      'title': title,
      'systemType': _selectedSystem,
      'location': location,
      'address': address,
      'company': company,
      'scheduledDate': _scheduledDate.toIso8601String(),
      'description': description,
      'assignedTo': _selectedInstaller?.id,
    };

    final result = await getIt<JobRepository>().updateJob(widget.jobId, data);

    result.fold(
      (failure) {
        setState(() {
          _isLoading = false;
          _errorMessage = failure.message;
        });
      },
      (_) {
        ref.invalidate(adminJobsProvider);
        ref.invalidate(jobDetailProvider(widget.jobId));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Job updated successfully!'),
              backgroundColor: AppColors.completed,
            ),
          );
          context.pop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final jobAsync = ref.watch(jobDetailProvider(widget.jobId));
    final installersAsync = ref.watch(installersProvider);
    final systemTypesAsync = ref.watch(systemTypesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Edit Job',
          style: AppTextStyles.headlineLargeWhite.copyWith(fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: jobAsync.when(
        data: (job) {
          return installersAsync.when(
            data: (installers) {
              _initFromJob(job, installers);
              return systemTypesAsync.when(
                data: (systemTypes) => _buildForm(installers, systemTypes),
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
                error: (e, _) => _buildForm(installers, []),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
            error: (e, _) {
              _initFromJob(job, []);
              return _buildForm([], []);
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildForm(List<UserEntity> installers, List<String> systemTypes) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionLabel('System Type'),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: systemTypes.contains(_selectedSystem)
                    ? _selectedSystem
                    : null,
                isExpanded: true,
                hint: const Text('Select system type'),
                items: systemTypes
                    .map((s) => DropdownMenuItem(
                          value: s,
                          child: Text(s),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _selectedSystem = v);
                },
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _buildSectionLabel('Job Title'),
          const SizedBox(height: AppSpacing.sm),
          _buildTextField(
            controller: _titleController,
            hint: 'e.g. Dozer GPS Installation',
            icon: Icons.work_outline,
          ),
          const SizedBox(height: AppSpacing.md),
          _buildSectionLabel('Location'),
          const SizedBox(height: AppSpacing.sm),
          _buildTextField(
            controller: _locationController,
            hint: 'e.g. Brisbane CBD',
            icon: Icons.location_on_outlined,
          ),
          const SizedBox(height: AppSpacing.md),
          _buildSectionLabel('Full Address'),
          const SizedBox(height: AppSpacing.sm),
          _buildTextField(
            controller: _addressController,
            hint: 'e.g. 123 Main St, Brisbane QLD 4000',
            icon: Icons.map_outlined,
          ),
          const SizedBox(height: AppSpacing.md),
          _buildSectionLabel('Company'),
          const SizedBox(height: AppSpacing.sm),
          _buildTextField(
            controller: _companyController,
            hint: 'e.g. ABC Construction Pty Ltd',
            icon: Icons.business_outlined,
          ),
          const SizedBox(height: AppSpacing.md),
          _buildSectionLabel('Scheduled Date'),
          const SizedBox(height: AppSpacing.sm),
          InkWell(
            onTap: _pickDate,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today,
                      color: AppColors.textSecondary, size: 20),
                  const SizedBox(width: AppSpacing.sm),
                  Text(_formatDate(_scheduledDate),
                      style: AppTextStyles.bodyLarge),
                  const Spacer(),
                  const Icon(Icons.arrow_drop_down,
                      color: AppColors.textSecondary),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _buildSectionLabel('Assign to Installer'),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<UserEntity?>(
                value: _selectedInstaller,
                isExpanded: true,
                hint: const Text('Select an installer'),
                items: [
                  const DropdownMenuItem<UserEntity?>(
                    value: null,
                    child: Text('Unassigned'),
                  ),
                  ...installers.map((u) => DropdownMenuItem<UserEntity?>(
                        value: u,
                        child: Text('${u.name} (${u.email})'),
                      )),
                ],
                onChanged: (v) => setState(() => _selectedInstaller = v),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _buildSectionLabel('Description (optional)'),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _descriptionController,
            maxLines: 3,
            style: AppTextStyles.bodyLarge,
            decoration: InputDecoration(
              hintText: 'Additional notes about this job...',
              hintStyle:
                  AppTextStyles.bodyLarge.copyWith(color: AppColors.textHint),
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
            ),
          ),
          if (_errorMessage != null) ...[
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline,
                      color: AppColors.error, size: 18),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.error),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          AppPrimaryButton(
            label: 'Save Changes',
            icon: Icons.save,
            isLoading: _isLoading,
            onTap: _isLoading ? null : _updateJob,
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: AppTextStyles.label.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: AppTextStyles.bodyLarge,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.bodyLarge.copyWith(color: AppColors.textHint),
        prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
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
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
      ),
    );
  }

  String _formatDate(DateTime d) {
    final months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[d.month]} ${d.day}, ${d.year}';
  }
}
