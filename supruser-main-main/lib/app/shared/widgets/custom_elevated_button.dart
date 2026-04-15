import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget? icon;
  final bool isLoading;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor,
    this.textStyle,
    this.width,
    this.height,
    this.borderRadius = 8.0,
    this.padding,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    final buttonHeight = height ?? (isSmallScreen ? 42 : 48);
    final horizontalPadding = padding ?? EdgeInsets.symmetric(
      horizontal: isSmallScreen ? 14 : 16,
      vertical: isSmallScreen ? 10 : 12,
    );

    return SizedBox(
      width: width,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          padding: horizontalPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.15),
        ),
        child: isLoading
            ? SizedBox(
          width: isSmallScreen ? 18 : 20,
          height: isSmallScreen ? 18 : 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              theme.colorScheme.onPrimary,
            ),
          ),
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: isSmallScreen ? 6 : 8),
            ],
            Text(
              text,
              style: textStyle ??
                  theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onPrimary,
                    fontSize: isSmallScreen ? 13 : 14,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}