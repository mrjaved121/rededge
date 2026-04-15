import 'package:flutter/material.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAllTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.wp(context, 4.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          if (onSeeAllTap != null)
            GestureDetector(
              onTap: onSeeAllTap,
              child: Icon(
                Icons.arrow_forward,
                size: ResponsiveUtils.sp(context, 22),
              ),
            ),
        ],
      ),
    );
  }
}