import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';

class ElectronicsSearchBar extends StatelessWidget {
  const ElectronicsSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.wp(context, 4.3),
        vertical: ResponsiveUtils.hp(context, 1),
      ),
      child: Container(
        height: ResponsiveUtils.hp(context, 5.1),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.wp(context, 4.1),
                  vertical: ResponsiveUtils.wp(context, 1.1),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for electronics',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: ResponsiveUtils.sp(context, 16),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(ResponsiveUtils.wp(context, 2.1)),
              child: Icon(
                Icons.search,
                color: Colors.grey,
                size: ResponsiveUtils.sp(context, 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}