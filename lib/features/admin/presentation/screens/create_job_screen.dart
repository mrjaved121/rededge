import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_config.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../di/injection.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../jobs/domain/repositories/job_repository.dart';
import '../providers/admin_provider.dart';

class CreateJobScreen extends ConsumerStatefulWidget {
  const CreateJobScreen({super.key});

  @override
  ConsumerState<CreateJobScreen> createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends ConsumerState<CreateJobScreen> {
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _addressController = TextEditingController();
  final _companyController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _newSystemTypeController = TextEditingController();

  String? _selectedSystem;
  UserEntity? _selectedInstaller;
  DateTime _scheduledDate = DateTime.now().add(const Duration(days: 1));
  bool _isLoading = false;
  bool _isLoadingTemplate = false;
  String? _errorMessage;

  // Custom steps defined by admin
  final List<_StepDraft> _steps = [
    _StepDraft(title: '', description: '', requiresPhoto: true),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _addressController.dispose();
    _companyController.dispose();
    _descriptionController.dispose();
    _newSystemTypeController.dispose();
    for (final s in _steps) {
      s.titleCtrl.dispose();
      s.descCtrl.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _scheduledDate,
      firstDate: DateTime.now(),
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

  void _addStep() {
    setState(() {
      _steps.add(_StepDraft(title: '', description: '', requiresPhoto: true));
    });
  }

  void _removeStep(int index) {
    if (_steps.length <= 1) return;
    setState(() {
      _steps[index].titleCtrl.dispose();
      _steps[index].descCtrl.dispose();
      _steps.removeAt(index);
    });
  }

  Future<void> _createNewSystemType() async {
    final name = _newSystemTypeController.text.trim();
    if (name.isEmpty) return;

    try {
      await getIt<ApiClient>().createSystemType(name);
      ref.invalidate(systemTypesProvider);
      _newSystemTypeController.clear();
      if (mounted) {
        setState(() => _selectedSystem = name);
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create system type: $e')),
        );
      }
    }
  }

  void _showAddSystemTypeDialog() {
    _newSystemTypeController.clear();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add System Type'),
        content: TextField(
          controller: _newSystemTypeController,
          decoration: const InputDecoration(
            hintText: 'e.g. Topcon MC-X1 Excavator',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _createNewSystemType,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  Future<void> _loadTemplateForSystem(String systemType) async {
    setState(() => _isLoadingTemplate = true);
    try {
      final response = await getIt<ApiClient>().getChecklist(systemType);
      final data = response.data as Map<String, dynamic>;
      final rawSteps = data['steps'] as List<dynamic>? ?? [];

      // Dispose old step controllers
      for (final s in _steps) {
        s.titleCtrl.dispose();
        s.descCtrl.dispose();
      }
      _steps.clear();

      for (final s in rawSteps) {
        final map = s as Map<String, dynamic>;
        _steps.add(_StepDraft(
          title: (map['title'] as String?) ?? '',
          description: (map['description'] as String?) ?? '',
          requiresPhoto: (map['requiresPhoto'] as bool?) ?? false,
          section: (map['section'] as String?) ?? '',
          inputType: (map['inputType'] as String?) ?? 'checkbox',
          inputLabel: (map['inputLabel'] as String?) ?? '',
          options: (map['options'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
              [],
        ));
      }

      if (_steps.isEmpty) {
        _steps.add(_StepDraft(title: '', description: '', requiresPhoto: true));
      }

      if (mounted) setState(() => _isLoadingTemplate = false);
    } catch (_) {
      // No template found — keep existing steps or add a blank one
      if (_steps.isEmpty) {
        _steps.add(_StepDraft(title: '', description: '', requiresPhoto: true));
      }
      if (mounted) setState(() => _isLoadingTemplate = false);
    }
  }

  Future<void> _createJob() async {
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
    if (_selectedSystem == null) {
      setState(() => _errorMessage = 'Please select a system type');
      return;
    }

    // Validate steps
    final validSteps =
        _steps.where((s) => s.titleCtrl.text.trim().isNotEmpty).toList();
    if (validSteps.isEmpty) {
      setState(() => _errorMessage = 'At least one step is required');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final stepsData = validSteps
        .asMap()
        .entries
        .map((e) => {
              'number': e.key + 1,
              'title': e.value.titleCtrl.text.trim(),
              'description': e.value.descCtrl.text.trim(),
              'requiresPhoto': e.value.requiresPhoto,
              'section': e.value.section,
              'inputType': e.value.inputType,
              'inputLabel': e.value.inputLabel,
              'options': e.value.options,
            })
        .toList();

    final data = <String, dynamic>{
      'title': title,
      'systemType': _selectedSystem,
      'location': location,
      'address': address,
      'company': company,
      'scheduledDate': _scheduledDate.toIso8601String(),
      'steps': stepsData,
      if (description.isNotEmpty) 'description': description,
      if (_selectedInstaller != null) 'assignedTo': _selectedInstaller!.id,
    };

    final result = await getIt<JobRepository>().createJob(data);

    result.fold(
      (failure) {
        setState(() {
          _isLoading = false;
          _errorMessage = failure.message;
        });
      },
      (_) {
        ref.invalidate(adminJobsProvider);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Job created successfully!'),
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
    final installersAsync = ref.watch(installersProvider);
    final systemTypesAsync = ref.watch(systemTypesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Create New Job',
          style: AppTextStyles.headlineLargeWhite.copyWith(fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // System Type
            _buildSectionLabel('System Type'),
            const SizedBox(height: AppSpacing.sm),
            systemTypesAsync.when(
              data: (types) => Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.cardRadius),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: types.contains(_selectedSystem)
                              ? _selectedSystem
                              : null,
                          isExpanded: true,
                          hint: const Text('Select system type'),
                          items: types
                              .map((s) => DropdownMenuItem(
                                    value: s,
                                    child: Text(s),
                                  ))
                              .toList(),
                          onChanged: (v) {
                            if (v != null) {
                              setState(() => _selectedSystem = v);
                              _loadTemplateForSystem(v);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _showAddSystemTypeDialog,
                    icon: const Icon(Icons.add_circle,
                        color: AppColors.primary, size: 32),
                    tooltip: 'Add new system type',
                  ),
                ],
              ),
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              ),
              error: (e, _) => Text('Failed to load system types',
                  style:
                      AppTextStyles.bodySmall.copyWith(color: AppColors.error)),
            ),
            const SizedBox(height: AppSpacing.md),

            // Job Title
            _buildSectionLabel('Job Title'),
            const SizedBox(height: AppSpacing.sm),
            _buildTextField(
              controller: _titleController,
              hint: 'e.g. Dozer GPS Installation',
              icon: Icons.work_outline,
            ),
            const SizedBox(height: AppSpacing.md),

            // Location (Google Places autocomplete)
            _buildSectionLabel('Location'),
            const SizedBox(height: AppSpacing.sm),
            _LocationSearchField(
              locationController: _locationController,
              addressController: _addressController,
              locationHint: 'e.g. Brisbane CBD',
              addressHint: 'e.g. 123 Main St, Brisbane QLD 4000',
            ),
            const SizedBox(height: AppSpacing.md),

            // Company
            _buildSectionLabel('Company'),
            const SizedBox(height: AppSpacing.sm),
            _buildTextField(
              controller: _companyController,
              hint: 'e.g. ABC Construction Pty Ltd',
              icon: Icons.business_outlined,
            ),
            const SizedBox(height: AppSpacing.md),

            // Scheduled Date
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
                    Text(
                      _formatDate(_scheduledDate),
                      style: AppTextStyles.bodyLarge,
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_drop_down,
                        color: AppColors.textSecondary),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Assign to Installer
            _buildSectionLabel('Assign to Installer'),
            const SizedBox(height: AppSpacing.sm),
            installersAsync.when(
              data: (installers) => Row(
                children: [
                  Expanded(
                    child: Container(
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
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => context.push('/admin/installers'),
                    icon: const Icon(Icons.person_add,
                        color: AppColors.primary, size: 28),
                    tooltip: 'Manage installers',
                  ),
                ],
              ),
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              ),
              error: (e, _) => Text(
                'Failed to load installers',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Description
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
            const SizedBox(height: AppSpacing.lg),

            // ── Installation Steps ──
            Row(
              children: [
                Expanded(
                  child: Text('Installation Steps',
                      style: AppTextStyles.headlineSmall),
                ),
                if (_isLoadingTemplate)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  ),
                TextButton.icon(
                  onPressed: _addStep,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Step'),
                  style:
                      TextButton.styleFrom(foregroundColor: AppColors.primary),
                ),
              ],
            ),
            if (_selectedSystem != null && _steps.isNotEmpty && _steps.first.section.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Text(
                  '${_steps.length} steps loaded from template',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.completed,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            const SizedBox(height: AppSpacing.sm),

            ...List.generate(_steps.length, (i) => _buildStepEditor(i)),

            const SizedBox(height: AppSpacing.sm),

            // Error
            if (_errorMessage != null) ...[
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
              const SizedBox(height: AppSpacing.md),
            ],

            // Create button
            AppPrimaryButton(
              label: 'Create Job',
              icon: Icons.add_task,
              isLoading: _isLoading,
              onTap: _isLoading ? null : _createJob,
            ),

            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildStepEditor(int index) {
    final step = _steps[index];
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
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text('Step ${index + 1}',
                    style: AppTextStyles.label
                        .copyWith(fontWeight: FontWeight.w700)),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      step.requiresPhoto
                          ? Icons.camera_alt
                          : Icons.camera_alt_outlined,
                      size: 18,
                      color: step.requiresPhoto
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'Photo',
                      style: TextStyle(
                        fontSize: 11,
                        color: step.requiresPhoto
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      width: 36,
                      child: Switch(
                        value: step.requiresPhoto,
                        onChanged: (v) =>
                            setState(() => step.requiresPhoto = v),
                        activeColor: AppColors.primary,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
                if (_steps.length > 1)
                  IconButton(
                    onPressed: () => _removeStep(index),
                    icon: const Icon(Icons.remove_circle_outline,
                        color: AppColors.error, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    tooltip: 'Remove step',
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: step.titleCtrl,
              style: AppTextStyles.bodyLarge,
              decoration: InputDecoration(
                hintText: 'Step name (e.g. Mount GPS Antenna)',
                hintStyle:
                    AppTextStyles.bodyLarge.copyWith(color: AppColors.textHint),
                filled: true,
                fillColor: AppColors.surface,
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            TextField(
              controller: step.descCtrl,
              style: AppTextStyles.bodySmall,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Description (optional)',
                hintStyle:
                    AppTextStyles.bodySmall.copyWith(color: AppColors.textHint),
                filled: true,
                fillColor: AppColors.surface,
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),
          ],
        ),
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

// ── Google Places Autocomplete field ─────────────────────────────────────────
class _LocationSearchField extends StatefulWidget {
  final TextEditingController locationController;
  final TextEditingController addressController;
  final String locationHint;
  final String addressHint;

  const _LocationSearchField({
    required this.locationController,
    required this.addressController,
    required this.locationHint,
    required this.addressHint,
  });

  @override
  State<_LocationSearchField> createState() => _LocationSearchFieldState();
}

class _LocationSearchFieldState extends State<_LocationSearchField> {
  final _dio = Dio();
  final _focusNode = FocusNode();
  Timer? _debounce;
  List<Map<String, dynamic>> _predictions = [];
  bool _showDropdown = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() => _showDropdown = false);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _focusNode.dispose();
    _dio.close();
    super.dispose();
  }

  bool get _placesEnabled =>
      ApiConfig.googleMapsApiKey != 'YOUR_GOOGLE_MAPS_API_KEY';

  Future<void> _search(String input) async {
    if (!_placesEnabled || input.length < 2) {
      setState(() => _predictions = []);
      return;
    }
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json',
        queryParameters: {
          'input': input,
          'key': ApiConfig.googleMapsApiKey,
          'types': 'geocode',
        },
      );
      final data = response.data as Map<String, dynamic>;
      final preds = (data['predictions'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>();
      if (mounted) setState(() => _predictions = preds);
    } catch (_) {
      // Silently ignore search errors
    }
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () => _search(value));
    setState(() => _showDropdown = value.isNotEmpty);
  }

  void _onSelect(Map<String, dynamic> prediction) {
    final description = prediction['description'] as String? ?? '';
    final mainText = (prediction['structured_formatting']
            as Map<String, dynamic>?)?['main_text'] as String? ??
        description;
    widget.locationController.text = mainText;
    widget.addressController.text = description;
    setState(() {
      _predictions = [];
      _showDropdown = false;
    });
    _focusNode.unfocus();
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.locationController,
          focusNode: _focusNode,
          style: AppTextStyles.bodyLarge,
          decoration: _inputDecoration(
            _placesEnabled ? 'Search location…' : widget.locationHint,
            Icons.location_on_outlined,
          ),
          onChanged: _placesEnabled ? _onChanged : null,
        ),
        if (_showDropdown && _predictions.isNotEmpty)
          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _predictions.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final pred = _predictions[i];
                final main = (pred['structured_formatting']
                        as Map<String, dynamic>?)?['main_text'] as String? ??
                    pred['description'] as String? ??
                    '';
                final secondary = (pred['structured_formatting']
                            as Map<String, dynamic>?)?['secondary_text']
                        as String? ??
                    '';
                return ListTile(
                  dense: true,
                  leading: const Icon(Icons.place_outlined, size: 18),
                  title: Text(main, style: AppTextStyles.bodyMedium),
                  subtitle: secondary.isNotEmpty
                      ? Text(secondary,
                          style: AppTextStyles.bodySmall
                              .copyWith(color: AppColors.textSecondary))
                      : null,
                  onTap: () => _onSelect(pred),
                );
              },
            ),
          ),
        const SizedBox(height: AppSpacing.md),
        // Full address label + field
        Text(
          'Full Address',
          style: AppTextStyles.label.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: widget.addressController,
          style: AppTextStyles.bodyLarge,
          decoration: _inputDecoration(widget.addressHint, Icons.map_outlined),
        ),
      ],
    );
  }
}

class _StepDraft {
  final TextEditingController titleCtrl;
  final TextEditingController descCtrl;
  bool requiresPhoto;
  String section;
  String inputType;
  String inputLabel;
  List<String> options;

  _StepDraft({
    required String title,
    required String description,
    this.requiresPhoto = true,
    this.section = '',
    this.inputType = 'checkbox',
    this.inputLabel = '',
    this.options = const [],
  })  : titleCtrl = TextEditingController(text: title),
        descCtrl = TextEditingController(text: description);
}
