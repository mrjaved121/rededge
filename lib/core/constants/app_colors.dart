import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand
  static const Color primary = Color(0xFFCC0000);
  static const Color primaryDark = Color(0xFF990000);
  static const Color primaryLight = Color(0xFFFF3333);

  // Backgrounds
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFEEEEEE);

  // Text
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textHint = Color(0xFF999999);

  // Status
  static const Color draft = Color(0xFF607D8B);
  static const Color pending = Color(0xFFFF9800);
  static const Color inProgress = Color(0xFF2196F3);
  static const Color completed = Color(0xFF4CAF50);

  // Semantic
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFFFF9C4);
  static const Color warningText = Color(0xFF795548);
  static const Color success = Color(0xFF4CAF50);
  static const Color disabled = Color(0xFFBDBDBD);
  static const Color offline = Color(0xFFFF9800);

  // Misc
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color shadow = Color(0x1A000000);
}