import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';

class CustomMenuButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? iconColor;
  final IconData? icon;
  final double? height;
  final double? width;
  final double? iconSize;
  final double? borderRadius;
  final bool withShadow;
  final EdgeInsets? padding;

  const CustomMenuButton({
    super.key,
    required this.onPressed,
    this.buttonColor,
    this.iconColor,
    this.icon,
    this.height,
    this.width,
    this.iconSize,
    this.borderRadius,
    this.withShadow = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: withShadow
            ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ]
            : null,
        borderRadius: BorderRadius.circular(borderRadius ?? 5),
      ),
      child: IconButton(
        style: ButtonStyle(
          fixedSize: WidgetStateProperty.all(
            Size(width ?? 35, height ?? 37),
          ),
          backgroundColor: WidgetStateProperty.all(
            buttonColor ?? AppColors.darkGreen,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 5),
            ),
          ),
          padding: WidgetStateProperty.all(padding ?? EdgeInsets.zero),
        ),
        onPressed: onPressed,
        icon: Icon(
          icon ?? Icons.menu,
          size: iconSize ?? 18,
          color: iconColor ?? AppColors.lightGreen,
        ),
      ),
    );
  }
}