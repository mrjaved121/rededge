import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_durations.dart';

class AppPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool isLoading;
  final Color? color;
  final double? width;

  const AppPrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.isLoading = false,
    this.color,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null && !isLoading;
    final bgColor = isEnabled
        ? (color ?? AppColors.primary)
        : AppColors.disabled;

    return AnimatedContainer(
      duration: AppDurations.fast,
      width: width,
      height: AppSpacing.buttonHeight,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: isEnabled
            ? [
          BoxShadow(
            color: bgColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          onTap: isEnabled ? onTap : null,
          child: Center(
            child: isLoading
                ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.5,
              ),
            )
                : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: Colors.white, size: AppSpacing.iconSizeMd),
                  const SizedBox(width: AppSpacing.sm),
                ],
                Text(label, style: AppTextStyles.buttonLabel),
              ],
            ),
          ),
        ),
      ),
    );
  }
}