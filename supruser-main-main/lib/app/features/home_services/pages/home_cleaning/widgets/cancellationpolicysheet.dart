import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';

class CancellationPolicyWidget extends StatelessWidget {
  final VoidCallback? onDetailsTap;

  const CancellationPolicyWidget({
    super.key,
    this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getBorderRadius(context, 12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // 🔹 Icon vertically centered
        children: [
          /// Info Icon (slightly lower visually)
          Padding(
            padding: EdgeInsets.only(top: ResponsiveUtils.getSpacing(context,10)),
            child: Icon(
              Icons.info_outline,
              color: AppColors.darkGrey,
              size: ResponsiveUtils.getIconSize(context, base: 22),
            ),
          ),

          SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),

          /// Text + Details (right side)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Main info text
                Text(
                  "Enjoy free cancellation up to 6 hours before your booking start time.",
                  style: TextStyle(
                    fontSize: ResponsiveUtils.sp(context, 12),
                    color: Colors.black,
                    height: 1.4, // Slightly better line spacing
                  ),
                ),

                /// Larger gap between text and Details
                SizedBox(height: ResponsiveUtils.getSpacing(context, 10)),

                /// "Details" bottom right aligned
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: onDetailsTap,
                    borderRadius: BorderRadius.circular(4),
                    child: Text(
                      "Details",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 14),
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkGreens,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
