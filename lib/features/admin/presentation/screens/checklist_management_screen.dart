import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/network/api_client.dart';
import '../../../../di/injection.dart';
import '../providers/admin_provider.dart';

/// Provider to fetch all checklist templates from the API.
final checklistTemplatesProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final response = await getIt<ApiClient>().getChecklists();
  final data = response.data as Map<String, dynamic>;
  final raw = data['templates'] as List<dynamic>? ?? [];
  return raw.cast<Map<String, dynamic>>();
});

class ChecklistManagementScreen extends ConsumerWidget {
  const ChecklistManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templatesAsync = ref.watch(checklistTemplatesProvider);
    final systemTypesAsync = ref.watch(systemTypesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Checklist Templates',
          style: AppTextStyles.headlineLargeWhite.copyWith(fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: templatesAsync.when(
        data: (templates) => _TemplateList(templates: templates),
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
                onPressed: () => ref.invalidate(checklistTemplatesProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: systemTypesAsync.when(
        data: (types) => FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => _ChecklistEditorScreen(
                  systemTypes: types,
                ),
              ),
            );
          },
          backgroundColor: AppColors.primary,
          icon: const Icon(Icons.add),
          label: const Text('New Template'),
        ),
        loading: () => null,
        error: (_, __) => null,
      ),
    );
  }
}

class _TemplateList extends ConsumerWidget {
  final List<Map<String, dynamic>> templates;
  const _TemplateList({required this.templates});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (templates.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.checklist_rtl,
                size: 64, color: AppColors.textSecondary.withOpacity(0.5)),
            const SizedBox(height: AppSpacing.md),
            Text('No checklist templates', style: AppTextStyles.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Create a default checklist for each system type',
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.refresh(checklistTemplatesProvider.future),
      color: AppColors.primary,
      child: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: templates.length,
        itemBuilder: (context, index) {
          final t = templates[index];
          final name = t['name'] as String? ?? 'Unnamed';
          final systemType = t['systemType'] as String? ?? '';
          final steps = t['steps'] as List<dynamic>? ?? [];
          final sections = <String>{};
          for (final s in steps) {
            final sec = (s as Map<String, dynamic>)['section'] as String? ?? '';
            if (sec.isNotEmpty) sections.add(sec);
          }
          final photoSteps =
              steps.where((s) => (s as Map)['requiresPhoto'] == true).length;

          return Card(
            margin: const EdgeInsets.only(bottom: AppSpacing.sm),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              side: const BorderSide(color: AppColors.cardBorder),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => _ChecklistViewScreen(
                      template: t,
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            systemType,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.chevron_right,
                            color: AppColors.textSecondary),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(name, style: AppTextStyles.headlineSmall),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        _InfoChip(
                          icon: Icons.checklist,
                          label: '${steps.length} steps',
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _InfoChip(
                          icon: Icons.camera_alt_outlined,
                          label: '$photoSteps photos',
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _InfoChip(
                          icon: Icons.folder_outlined,
                          label: '${sections.length} sections',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(label, style: AppTextStyles.bodySmall),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// VIEW SCREEN — shows full checklist detail with edit/delete
// ═══════════════════════════════════════════════════════════
class _ChecklistViewScreen extends ConsumerWidget {
  final Map<String, dynamic> template;
  const _ChecklistViewScreen({required this.template});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = template['name'] as String? ?? 'Unnamed';
    final systemType = template['systemType'] as String? ?? '';
    final steps = (template['steps'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>();

    // Group steps by section
    final grouped = <String, List<Map<String, dynamic>>>{};
    for (final s in steps) {
      final sec = s['section'] as String? ?? 'General';
      grouped.putIfAbsent(sec, () => []).add(s);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(name,
            style: AppTextStyles.headlineLargeWhite.copyWith(fontSize: 18)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            tooltip: 'Edit Template',
            onPressed: () async {
              final systemTypesAsync = ref.read(systemTypesProvider);
              final types = systemTypesAsync.valueOrNull ?? [systemType];
              final result = await Navigator.of(context).push<bool>(
                MaterialPageRoute(
                  builder: (_) => _ChecklistEditorScreen(
                    systemTypes: types,
                    existingTemplate: template,
                  ),
                ),
              );
              if (result == true && context.mounted) {
                ref.invalidate(checklistTemplatesProvider);
                Navigator.of(context).pop();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white),
            tooltip: 'Delete Template',
            onPressed: () => _confirmDelete(context, ref, systemType),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('System Type',
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Text(systemType,
                    style: AppTextStyles.headlineSmall
                        .copyWith(color: AppColors.primary)),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    _InfoChip(
                        icon: Icons.checklist,
                        label: '${steps.length} total steps'),
                    const SizedBox(width: AppSpacing.md),
                    _InfoChip(
                      icon: Icons.camera_alt_outlined,
                      label:
                          '${steps.where((s) => s['requiresPhoto'] == true).length} photo required',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Sections
          for (final entry in grouped.entries) ...[
            // Section header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              margin: const EdgeInsets.only(bottom: AppSpacing.xs),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                entry.key,
                style: AppTextStyles.label.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ...entry.value.map((step) => _StepTile(step: step)),
            const SizedBox(height: AppSpacing.sm),
          ],
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, String systemType) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Template?'),
        content: Text(
            'Are you sure you want to delete the checklist for "$systemType"? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              try {
                await getIt<ApiClient>().dio.delete('/checklists/$systemType');
                ref.invalidate(checklistTemplatesProvider);
                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Template deleted'),
                      backgroundColor: AppColors.completed,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to delete: $e')),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  final Map<String, dynamic> step;
  const _StepTile({required this.step});

  @override
  Widget build(BuildContext context) {
    final number = step['number'] ?? 0;
    final title = step['title'] as String? ?? '';
    final inputType = step['inputType'] as String? ?? 'checkbox';
    final inputLabel = step['inputLabel'] as String? ?? '';
    final requiresPhoto = step['requiresPhoto'] == true;
    final options = (step['options'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

    IconData typeIcon;
    String typeLabel;
    switch (inputType) {
      case 'text':
        typeIcon = Icons.text_fields;
        typeLabel = 'Text Input';
        break;
      case 'number':
        typeIcon = Icons.pin;
        typeLabel = 'Number Input';
        break;
      case 'select':
        typeIcon = Icons.list;
        typeLabel = 'Dropdown';
        break;
      case 'photo':
        typeIcon = Icons.camera_alt;
        typeLabel = 'Photo';
        break;
      default:
        typeIcon = Icons.check_box_outlined;
        typeLabel = 'Checkbox';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.cardBorder.withOpacity(0.5)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                '$number',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMedium),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(typeIcon, size: 12, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      inputLabel.isNotEmpty
                          ? '$typeLabel: $inputLabel'
                          : typeLabel,
                      style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary, fontSize: 11),
                    ),
                    if (requiresPhoto) ...[
                      const SizedBox(width: 8),
                      Icon(Icons.camera_alt,
                          size: 12, color: AppColors.primary),
                      const SizedBox(width: 2),
                      Text('Photo',
                          style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primary, fontSize: 11)),
                    ],
                  ],
                ),
                if (options.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      'Options: ${options.join(', ')}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// EDITOR SCREEN — create or edit a checklist template
// ═══════════════════════════════════════════════════════════
class _ChecklistEditorScreen extends ConsumerStatefulWidget {
  final List<String> systemTypes;
  final Map<String, dynamic>? existingTemplate;

  const _ChecklistEditorScreen({
    required this.systemTypes,
    this.existingTemplate,
  });

  @override
  ConsumerState<_ChecklistEditorScreen> createState() =>
      _ChecklistEditorScreenState();
}

class _ChecklistEditorScreenState
    extends ConsumerState<_ChecklistEditorScreen> {
  String? _selectedSystemType;
  final _nameController = TextEditingController();
  final List<_EditableStep> _steps = [];
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingTemplate != null) {
      final t = widget.existingTemplate!;
      _selectedSystemType = t['systemType'] as String?;
      _nameController.text = t['name'] as String? ?? '';
      final rawSteps = t['steps'] as List<dynamic>? ?? [];
      for (final s in rawSteps) {
        final map = s as Map<String, dynamic>;
        _steps.add(_EditableStep(
          title: (map['title'] as String?) ?? '',
          description: (map['description'] as String?) ?? '',
          section: (map['section'] as String?) ?? '',
          inputType: (map['inputType'] as String?) ?? 'checkbox',
          inputLabel: (map['inputLabel'] as String?) ?? '',
          requiresPhoto: map['requiresPhoto'] == true,
          options: (map['options'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
              [],
        ));
      }
    }
    if (_steps.isEmpty) {
      _steps.add(_EditableStep());
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    for (final s in _steps) {
      s.dispose();
    }
    super.dispose();
  }

  void _addStep({int? afterIndex}) {
    setState(() {
      final insertAt = afterIndex != null ? afterIndex + 1 : _steps.length;
      final newStep = _EditableStep();
      // Copy section from previous step
      if (insertAt > 0 && insertAt <= _steps.length) {
        newStep.sectionCtrl.text = _steps[insertAt - 1].sectionCtrl.text;
      }
      _steps.insert(insertAt, newStep);
    });
  }

  void _removeStep(int index) {
    if (_steps.length <= 1) return;
    setState(() {
      _steps[index].dispose();
      _steps.removeAt(index);
    });
  }

  Future<void> _save() async {
    if (_selectedSystemType == null || _selectedSystemType!.isEmpty) {
      _showError('Please select a system type');
      return;
    }
    if (_nameController.text.trim().isEmpty) {
      _showError('Please enter a template name');
      return;
    }

    final validSteps =
        _steps.where((s) => s.titleCtrl.text.trim().isNotEmpty).toList();
    if (validSteps.isEmpty) {
      _showError('At least one step is required');
      return;
    }

    setState(() => _isSaving = true);

    try {
      final stepsData = validSteps
          .asMap()
          .entries
          .map((e) => {
                'number': e.key + 1,
                'title': e.value.titleCtrl.text.trim(),
                'description': e.value.descCtrl.text.trim(),
                'section': e.value.sectionCtrl.text.trim(),
                'inputType': e.value.inputType,
                'inputLabel': e.value.inputLabelCtrl.text.trim(),
                'requiresPhoto': e.value.requiresPhoto,
                'options': e.value.optionsCtrl.text
                    .split(',')
                    .map((o) => o.trim())
                    .where((o) => o.isNotEmpty)
                    .toList(),
              })
          .toList();

      await getIt<ApiClient>().saveChecklist({
        'systemType': _selectedSystemType,
        'name': _nameController.text.trim(),
        'steps': stepsData,
      });

      ref.invalidate(checklistTemplatesProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Checklist template saved!'),
            backgroundColor: AppColors.completed,
          ),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      _showError('Failed to save: $e');
      setState(() => _isSaving = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingTemplate != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          isEditing ? 'Edit Template' : 'New Checklist Template',
          style: AppTextStyles.headlineLargeWhite.copyWith(fontSize: 18),
        ),
        actions: [
          TextButton.icon(
            onPressed: _isSaving ? null : _save,
            icon: _isSaving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.save, color: Colors.white),
            label: Text(
              'Save',
              style:
                  TextStyle(color: _isSaving ? Colors.white54 : Colors.white),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // System Type
          Text('System Type',
              style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w600)),
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
                value: widget.systemTypes.contains(_selectedSystemType)
                    ? _selectedSystemType
                    : null,
                isExpanded: true,
                hint: const Text('Select system type'),
                items: widget.systemTypes
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: isEditing
                    ? null
                    : (v) {
                        setState(() {
                          _selectedSystemType = v;
                          if (_nameController.text.isEmpty && v != null) {
                            _nameController.text = v;
                          }
                        });
                      },
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Template Name
          Text('Template Name',
              style: AppTextStyles.label.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _nameController,
            style: AppTextStyles.bodyLarge,
            decoration: InputDecoration(
              hintText: 'e.g. Hemisphere VR1000 Dozer',
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

          // Steps header
          Row(
            children: [
              Expanded(
                child: Text('Steps (${_steps.length})',
                    style: AppTextStyles.headlineSmall),
              ),
              TextButton.icon(
                onPressed: () => _addStep(),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Step'),
                style: TextButton.styleFrom(foregroundColor: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Steps list
          ...List.generate(_steps.length, (i) => _buildStepEditor(i)),

          const SizedBox(height: AppSpacing.xl),
        ],
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
            // Step header
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
                          fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text('Step ${index + 1}',
                    style: AppTextStyles.label
                        .copyWith(fontWeight: FontWeight.w700)),
                const Spacer(),
                // Photo toggle
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      step.requiresPhoto
                          ? Icons.camera_alt
                          : Icons.camera_alt_outlined,
                      size: 16,
                      color: step.requiresPhoto
                          ? AppColors.primary
                          : AppColors.textSecondary,
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
                IconButton(
                  onPressed: () => _addStep(afterIndex: index),
                  icon: const Icon(Icons.add_circle_outline,
                      color: AppColors.primary, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  tooltip: 'Insert step below',
                ),
                if (_steps.length > 1)
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: IconButton(
                      onPressed: () => _removeStep(index),
                      icon: const Icon(Icons.remove_circle_outline,
                          color: AppColors.error, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      tooltip: 'Remove step',
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),

            // Section
            _smallField(step.sectionCtrl, 'Section (e.g. Pre-Installation)'),
            const SizedBox(height: AppSpacing.xs),

            // Title
            _smallField(step.titleCtrl, 'Step title *'),
            const SizedBox(height: AppSpacing.xs),

            // Description
            _smallField(step.descCtrl, 'Description (optional)'),
            const SizedBox(height: AppSpacing.xs),

            // Input type row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: step.inputType,
                        isExpanded: true,
                        isDense: true,
                        items: const [
                          DropdownMenuItem(
                              value: 'checkbox',
                              child: Text('Checkbox',
                                  style: TextStyle(fontSize: 13))),
                          DropdownMenuItem(
                              value: 'text',
                              child: Text('Text Input',
                                  style: TextStyle(fontSize: 13))),
                          DropdownMenuItem(
                              value: 'number',
                              child: Text('Number Input',
                                  style: TextStyle(fontSize: 13))),
                          DropdownMenuItem(
                              value: 'select',
                              child: Text('Dropdown Select',
                                  style: TextStyle(fontSize: 13))),
                          DropdownMenuItem(
                              value: 'photo',
                              child: Text('Photo Only',
                                  style: TextStyle(fontSize: 13))),
                        ],
                        onChanged: (v) {
                          if (v != null) {
                            setState(() => step.inputType = v);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _smallField(step.inputLabelCtrl, 'Input Label'),
                ),
              ],
            ),

            // Options (for select type)
            if (step.inputType == 'select') ...[
              const SizedBox(height: AppSpacing.xs),
              _smallField(
                  step.optionsCtrl, 'Options (comma-separated, e.g. Yes, No)'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _smallField(TextEditingController ctrl, String hint) {
    return TextField(
      controller: ctrl,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 13, color: AppColors.textHint),
        filled: true,
        fillColor: AppColors.surface,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
    );
  }
}

class _EditableStep {
  final TextEditingController titleCtrl;
  final TextEditingController descCtrl;
  final TextEditingController sectionCtrl;
  final TextEditingController inputLabelCtrl;
  final TextEditingController optionsCtrl;
  String inputType;
  bool requiresPhoto;

  _EditableStep({
    String title = '',
    String description = '',
    String section = '',
    String inputType = 'checkbox',
    String inputLabel = '',
    bool requiresPhoto = false,
    List<String> options = const [],
  })  : titleCtrl = TextEditingController(text: title),
        descCtrl = TextEditingController(text: description),
        sectionCtrl = TextEditingController(text: section),
        inputLabelCtrl = TextEditingController(text: inputLabel),
        optionsCtrl = TextEditingController(text: options.join(', ')),
        inputType = inputType,
        requiresPhoto = requiresPhoto;

  void dispose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    sectionCtrl.dispose();
    inputLabelCtrl.dispose();
    optionsCtrl.dispose();
  }
}
