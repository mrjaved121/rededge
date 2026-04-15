import 'package:flutter/material.dart';

class ResponsiveUtils {
  // ============================================
  // YOUR EXISTING METHODS (KEPT AS IS)
  // ============================================

  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;

  // Responsive width
  static double wp(BuildContext context, double percentage) {
    return width(context) * percentage / 100;
  }

  // Responsive height
  static double hp(BuildContext context, double percentage) {
    return height(context) * percentage / 100;
  }

  // Responsive font size
  static double sp(BuildContext context, double size) {
    double screenWidth = width(context);
    return size * (screenWidth / 375); // 375 is base width (iPhone X)
  }

  // Responsive padding
  static EdgeInsets responsivePadding(BuildContext context, {
    double horizontal = 16,
    double vertical = 8,
  }) {
    return EdgeInsets.symmetric(
      horizontal: wp(context, horizontal * 100 / 375),
      vertical: hp(context, vertical * 100 / 812),
    );
  }

  // Check if tablet
  static bool isTablet(BuildContext context) {
    return width(context) > 600;
  }

  // Get responsive card width
  static double getCardWidth(BuildContext context, {double baseWidth = 140}) {
    if (isTablet(context)) {
      return baseWidth * 1.3;
    }
    return wp(context, baseWidth * 100 / 375);
  }

  // Get responsive card height
  static double getCardHeight(BuildContext context, {double baseHeight = 220}) {
    if (isTablet(context)) {
      return baseHeight * 1.3;
    }
    return hp(context, baseHeight * 100 / 812);
  }

  // ============================================
  // NEW ENHANCED METHODS (ADDED FOR YOU)
  // ============================================

  /// Check if screen is small (less than 360px width)
  static bool isSmallScreen(BuildContext context) {
    return width(context) < 360;
  }

  /// Check if screen is medium (360px - 400px width)
  static bool isMediumScreen(BuildContext context) {
    return width(context) >= 360 && width(context) < 400;
  }

  /// Check if screen is large (400px+ width, excluding tablets)
  static bool isLargeScreen(BuildContext context) {
    return width(context) >= 400 && width(context) <= 600;
  }

  /// Get adaptive value based on screen size
  /// Usage: ResponsiveUtils.adaptive(context, small: 12, medium: 14, large: 16)
  static T adaptive<T>(
      BuildContext context, {
        required T small,
        T? medium,
        T? large,
        T? tablet,
      }) {
    if (isTablet(context) && tablet != null) return tablet;
    if (isLargeScreen(context) && large != null) return large;
    if (isMediumScreen(context) && medium != null) return medium;
    return small;
  }

  /// Get responsive spacing based on screen size
  /// Usage: ResponsiveUtils.getSpacing(context, 16)
  /// Returns: small: 12.8, medium: 16, large: 17.6, tablet: 20.8
  static double getSpacing(BuildContext context, double baseSpacing) {
    return adaptive(
      context,
      small: baseSpacing * 0.8,
      medium: baseSpacing,
      large: baseSpacing * 1.1,
      tablet: baseSpacing * 1.3,
    );
  }

  /// Get responsive icon size
  /// Usage: ResponsiveUtils.getIconSize(context, base: 24)
  static double getIconSize(BuildContext context, {double base = 24}) {
    return adaptive(
      context,
      small: base * 0.9,
      medium: base,
      large: base * 1.1,
      tablet: base * 1.3,
    );
  }

  /// Get responsive button height
  /// Usage: ResponsiveUtils.getButtonHeight(context, base: 48)
  static double getButtonHeight(BuildContext context, {double base = 48}) {
    return adaptive(
      context,
      small: base * 0.85,
      medium: base,
      large: base * 1.05,
      tablet: base * 1.2,
    );
  }

  /// Get responsive tile size for grid items
  /// Usage: ResponsiveUtils.getTileSize(context, 80)
  static double getTileSize(BuildContext context, double baseSize) {
    final screenWidth = width(context);
    return (screenWidth / 375) * baseSize;
  }

  /// Get responsive border radius
  /// Usage: ResponsiveUtils.getBorderRadius(context, 8)
  static double getBorderRadius(BuildContext context, double baseRadius) {
    return adaptive(
      context,
      small: baseRadius * 0.9,
      medium: baseRadius,
      large: baseRadius * 1.1,
      tablet: baseRadius * 1.2,
    );
  }

  /// Get screen size category as string (for debugging)
  static String getScreenCategory(BuildContext context) {
    if (isTablet(context)) return 'Tablet';
    if (isLargeScreen(context)) return 'Large';
    if (isMediumScreen(context)) return 'Medium';
    if (isSmallScreen(context)) return 'Small';
    return 'Unknown';
  }
}