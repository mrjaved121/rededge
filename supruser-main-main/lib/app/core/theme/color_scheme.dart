import 'package:flutter/material.dart';

const ColorScheme colorSchemeLight = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff018D14), //Chrome Yellow for buttons and icons
  onPrimary: Colors.white,
  secondary: Color(
      0xFFFFF000), // Yellow Rose for logo and background and primary brands
  onSecondary: Colors.white,
  tertiary: Color(0xFF6AFF05), // Greenery for success messages and highlights
  onTertiary: Colors.white,
  error: Color(0xFFFF003A), // Carmine Red for error messages and alerts
  onError: Colors.white,
  surface: Color(0xffFFFFFF),
  onSurface: Colors.black,
  outline: Color(0xffE0E0E0),
  outlineVariant: Color(0xff000000),
);
