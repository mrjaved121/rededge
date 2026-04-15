import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../provider/home_cleaing_provider.dart';

class MaterialsSelectionWidget extends StatelessWidget {
  final BookingProvider provider;

  const MaterialsSelectionWidget({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Need cleaning materials?",
          style: TextStyle(
            fontSize: ResponsiveUtils.sp(context, 12.75),
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        SizedBox(height: ResponsiveUtils.getSpacing(context, 13.6)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start, // 👈 Center the whole row
          children: [
            // ❌ NO option
            InkWell(
              onTap: () => provider.setNeedMaterials(false),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.getSpacing(context, 10), // 👈 controls horizontal space
                  vertical: ResponsiveUtils.getSpacing(context, 6),   // 👈 controls vertical space
                ),
                decoration: BoxDecoration(
                  color: !provider.needMaterials ? AppColors.darkGreen : AppColors.white,
                  border: Border.all(
                    width: 1,
                    color: !provider.needMaterials ? AppColors.darkGreen : AppColors.appGrey,
                  ),
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getBorderRadius(context, 6),
                  ),
                ),
                child: Text(
                  "No, I have them",
                  style: TextStyle(
                    fontSize: ResponsiveUtils.sp(context, 12.5),
                    fontWeight: FontWeight.w900,
                    color: !provider.needMaterials ? AppColors.white : AppColors.darkGrey,
                  ),
                ),
              ),
            ),

            SizedBox(width: ResponsiveUtils.getSpacing(context, 8)), // 👈 small gap between buttons

            // ✅ YES option
            InkWell(
              onTap: () => provider.setNeedMaterials(true),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.getSpacing(context, 16), // 👈 tighter but balanced width
                  vertical: ResponsiveUtils.getSpacing(context, 6),
                ),
                decoration: BoxDecoration(
                  color: provider.needMaterials ? AppColors.darkGreen : AppColors.white,
                  border: Border.all(
                    width: 1,
                    color: provider.needMaterials ? AppColors.darkGreen : AppColors.appGrey,
                  ),
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getBorderRadius(context, 6),
                  ),
                ),
                child: Text(
                  "Yes, please",
                  style: TextStyle(
                    fontSize: ResponsiveUtils.sp(context, 12.5),
                    fontWeight: FontWeight.w800,
                    color: provider.needMaterials ? AppColors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),

      ],
    );
  }
}
