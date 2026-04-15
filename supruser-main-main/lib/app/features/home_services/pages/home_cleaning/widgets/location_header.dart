import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../provider/home_cleaing_provider.dart';

class LocationHeaderWidget extends StatelessWidget {
  final BookingProvider provider;
  // 1. Yahan naya variable add karein
  final bool showDropdownIcon;

  const LocationHeaderWidget({
    Key? key,
    required this.provider,
    // 2. Constructor mein isko default value 'true' de dein
    this.showDropdownIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                provider.location,
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 11.9),
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              // 3. Yahan condition laga dein (collection-if ka use karke)
              if (showDropdownIcon) ...[
                SizedBox(width: ResponsiveUtils.getSpacing(context, 3.4)),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: ResponsiveUtils.getIconSize(context, base: 17),
                ),
              ],
            ],
          ),
          SizedBox(height: ResponsiveUtils.getSpacing(context, 1.7)),
          Text(
            provider.address,
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(context, 10.2),
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
//
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/utils/responsive_utils.dart';
// import '../provider/home_cleaing_provider.dart';
//
// class LocationHeaderWidget extends StatelessWidget {
//   final BookingProvider provider;
//
//   const LocationHeaderWidget({Key? key, required this.provider}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {},
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 provider.location,
//                 style: TextStyle(
//                   fontSize: ResponsiveUtils.sp(context, 11.9),
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(width: ResponsiveUtils.getSpacing(context, 3.4)),
//               Icon(
//                   Icons.keyboard_arrow_down,
//                   color: Colors.black,
//                   size: ResponsiveUtils.getIconSize(context, base: 17)),
//             ],
//           ),
//           SizedBox(height: ResponsiveUtils.getSpacing(context, 1.7)),
//           Text(
//             provider.address,
//             style: TextStyle(
//               fontSize: ResponsiveUtils.sp(context, 10.2),
//               color: Colors.black87,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
