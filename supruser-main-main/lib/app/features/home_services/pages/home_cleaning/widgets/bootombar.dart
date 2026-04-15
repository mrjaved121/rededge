import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../provider/home_cleaing_provider.dart';

class BottomBarWidget extends StatelessWidget {
  final BookingProvider provider;
  final VoidCallback onNext;
  final String buttonText;

  const BottomBarWidget({
    Key? key,
    required this.provider,
    required this.onNext,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ✅ Check if button should be enabled
    final bool isEnabled = provider.total > 0;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.appGrey.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getSpacing(context, 18),
        vertical: ResponsiveUtils.getSpacing(context, 14),
      ),
      child: Row(
        children: [
          // 🧾 Total section
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 11.9),
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(
                    "AED ${provider.total.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(context, 16),
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: ResponsiveUtils.getSpacing(context, 6.8)),
                  Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.black,
                    size: ResponsiveUtils.getIconSize(context, base: 18),
                  ),
                ],
              ),
            ],
          ),

          const Spacer(),

          // ✅ Next button with conditional styling
          SizedBox(
            width: ResponsiveUtils.wp(context, 40),
            child: ElevatedButton(
              onPressed: isEnabled ? onNext : null, // ✅ Disable when total is 0
              style: ElevatedButton.styleFrom(
                backgroundColor: isEnabled
                    ? AppColors.darkGreen  // ✅ Green when enabled
                    : AppColors.appGrey,   // ✅ Gray when disabled
                disabledBackgroundColor: AppColors.appGrey, // ✅ Explicit disabled color
                padding: EdgeInsets.symmetric(
                  vertical: ResponsiveUtils.getSpacing(context, 10.6),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getBorderRadius(context, 10),
                  ),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 15.3),
                  fontWeight: FontWeight.w700,
                  color: isEnabled
                      ? AppColors.lightGreen  // ✅ Light green when enabled
                      : Colors.black,         // ✅ Black when disabled
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/utils/responsive_utils.dart';
// import '../provider/home_cleaing_provider.dart';
//
// class BottomBarWidget extends StatelessWidget {
//   final BookingProvider provider;
//   final VoidCallback onNext;
//   final String buttonText;
//
//   const BottomBarWidget({
//     Key? key,
//     required this.provider,
//     required this.onNext,
//     required this.buttonText,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.white,
//
//         border: Border(
//           top: BorderSide(
//             color: AppColors.appGrey.withOpacity(0.5), // 👈 Top divider line
//             width: 1,
//           ),
//         ),
//       ),
//       padding: EdgeInsets.symmetric(
//         horizontal: ResponsiveUtils.getSpacing(context, 18),
//         vertical: ResponsiveUtils.getSpacing(context, 14),
//       ),
//       child: Row(
//         children: [
//           // 🧾 Total section
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Total",
//                 style: TextStyle(
//                   fontSize: ResponsiveUtils.sp(context, 11.9), // 👈 15% smaller
//                   color: Colors.black,
//                 ),
//               ),
//               Row(
//                 children: [
//                   Text(
//                     "AED ${provider.total.toStringAsFixed(2)}",
//                     style: TextStyle(
//                       fontSize: ResponsiveUtils.sp(context, 16), // 👈 15% smaller
//                       fontWeight: FontWeight.w900,
//                       color: Colors.black,
//                     ),
//                   ),
//                   SizedBox(width: ResponsiveUtils.getSpacing(context, 6.8)),
//                   Icon(
//                     Icons.keyboard_arrow_up,
//                     color: Colors.black,
//                     size: ResponsiveUtils.getIconSize(context, base: 18),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//
//           const Spacer(),
//
//           // ✅ Next button
//           SizedBox(
//             width: ResponsiveUtils.wp(context, 40), // 👈 increased width by ~15%
//             child: ElevatedButton(
//               onPressed: onNext,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.darkGreen,
//                 padding: EdgeInsets.symmetric(
//                   vertical: ResponsiveUtils.getSpacing(context, 10.6), // 👈 15% less height
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(
//                     ResponsiveUtils.getBorderRadius(context, 10),
//                   ),
//                 ),
//               ),
//               child: Text(
//                 buttonText,
//                 style: TextStyle(
//                   fontSize: ResponsiveUtils.sp(context, 15.3), // 👈 15% smaller text
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.lightGreen,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
