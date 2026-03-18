import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:red_edge_app/di/injection.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/app_outline_button.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../photos/domain/repositories/photo_repository.dart';
import '../../../jobs/presentation/providers/job_provider.dart';
import 'camera_screen.dart';

class PhotoReviewScreen extends ConsumerStatefulWidget {
  final PhotoReviewArgs args;

  const PhotoReviewScreen({super.key, required this.args});

  @override
  ConsumerState<PhotoReviewScreen> createState() => _PhotoReviewScreenState();
}

class _PhotoReviewScreenState extends ConsumerState<PhotoReviewScreen> {
  final _annotationController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _annotationController.dispose();
    super.dispose();
  }

  Future<void> _savePhoto() async {
    setState(() => _isSaving = true);

    final repo = getIt<PhotoRepository>();
    final result = await repo.savePhoto(
      jobId: widget.args.jobId,
      stepId: widget.args.stepId,
      localPath: widget.args.imagePath,
      latitude: widget.args.gps?.latitude,
      longitude: widget.args.gps?.longitude,
      address: widget.args.address,
      annotation: _annotationController.text.isNotEmpty
          ? _annotationController.text
          : null,
    );

    if (mounted) {
      result.fold(
        (failure) {
          setState(() => _isSaving = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed: ${failure.message}')),
          );
        },
        (_) {
          // Refresh job detail so photos/step status update in UI
          ref.invalidate(jobDetailProvider(widget.args.jobId));
          // Pop back past camera to step list
          context.pop(); // Review
          context.pop(); // Camera
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Photo Capture',
          style: AppTextStyles.headlineLargeWhite.copyWith(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Photo preview
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.file(
                  File(widget.args.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // GPS info
            if (widget.args.gps != null) ...[
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm + 4),
                decoration: BoxDecoration(
                  color: AppColors.completed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  border: Border.all(
                    color: AppColors.completed.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.gps_fixed,
                        color: AppColors.completed, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GPS Location Captured',
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.completed,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '${widget.args.gps!.latitude.toStringAsFixed(6)}, '
                          '${widget.args.gps!.longitude.toStringAsFixed(6)}',
                          style: AppTextStyles.code.copyWith(fontSize: 12),
                        ),                        if (widget.args.address != null) ...[  
                          const SizedBox(height: 2),
                          Text(
                            widget.args.address!,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.completed,
                            ),
                          ),
                        ],                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],

            // Annotation field
            Text('Notes (optional)', style: AppTextStyles.label),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _annotationController,
              maxLines: 3,
              style: AppTextStyles.bodyLarge,
              decoration: InputDecoration(
                hintText: 'Add notes about this photo...',
                hintStyle: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textHint,
                ),
                filled: true,
                fillColor: Colors.white,
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
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
          child: Row(
            children: [
              Expanded(
                child: AppOutlineButton(
                  label: 'Retake',
                  icon: Icons.refresh,
                  onTap: () => context.pop(),
                ),
              ),
              const SizedBox(width: AppSpacing.sm + 4),
              Expanded(
                child: AppPrimaryButton(
                  label: 'Save Photo',
                  icon: Icons.check,
                  color: AppColors.completed,
                  isLoading: _isSaving,
                  onTap: _isSaving ? null : _savePhoto,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
