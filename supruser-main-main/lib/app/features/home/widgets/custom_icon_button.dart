import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final double? width;
  final double? height;
  final Color? buttonColor;
  final Color? iconColor;
  final double borderRadius;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.width,
    this.height,
    this.buttonColor,
    this.iconColor,
    this.borderRadius = 10.0,
    this.padding,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    final buttonWidth = width ?? (isSmallScreen ? 45 : 50);
    final buttonHeight = height ?? (isSmallScreen ? 45 : 50);
    final calculatedIconSize = iconSize ?? (isSmallScreen ? 20 : 24);

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            decoration: BoxDecoration(
              color: buttonColor ?? colorScheme(context).primary,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: padding ?? EdgeInsets.all(isSmallScreen ? 6 : 8),
            child: Icon(
              icon,
              size: calculatedIconSize,
              color: iconColor ?? Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}