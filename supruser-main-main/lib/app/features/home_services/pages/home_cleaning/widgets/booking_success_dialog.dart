import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';

class BookingSuccessDialog extends StatelessWidget {
  const BookingSuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ResponsiveUtils.getBorderRadius(context, 20)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 20)),
            decoration: BoxDecoration(
              color: AppColors.appGreen.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle,
              color: AppColors.appGreen,
              size: ResponsiveUtils.getIconSize(context, base: 60),
            ),
          ),
          SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),

          // Title
          Text(
            "Booking Confirmed!",
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(context, 24),
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),

          // Description
          Text(
            "Your home cleaning service has been successfully booked.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(context, 14),
              color: AppColors.darkGrey,
            ),
          ),
          SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),

          // Done Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkGreen,
                padding: EdgeInsets.symmetric(
                  vertical: ResponsiveUtils.getSpacing(context, 16),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ResponsiveUtils.getBorderRadius(context, 12)),
                ),
              ),
              child: Text(
                "Done",
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 18),
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightGreen,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Static helper method to show the dialog
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const BookingSuccessDialog(),
    );
  }
}
