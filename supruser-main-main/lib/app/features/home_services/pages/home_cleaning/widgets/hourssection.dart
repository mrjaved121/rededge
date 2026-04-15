import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../provider/home_cleaing_provider.dart';

class HoursSelectionWidget extends StatelessWidget {
  final BookingProvider provider;

  const HoursSelectionWidget({Key? key, required this.provider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "How many hours do you need your\nprofessional to stay?",
                  style: TextStyle(
                    fontSize: ResponsiveUtils.sp(context, 11.9),
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: ResponsiveUtils.getSpacing(context, 6.8)),
                Icon(Icons.info_outline,
                    color: Colors.black,
                    size: ResponsiveUtils.getIconSize(context, base: 17)),
              ],
            ),
            SizedBox(height: ResponsiveUtils.getSpacing(context, 13.6)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(8, (index) {
                  final hour = index + 1;
                  // ✅ Fix: Directly check selectedHours
                  final isSelected = provider.selectedHours == hour;

                  return Padding(
                    padding: EdgeInsets.only(
                        right: ResponsiveUtils.getSpacing(context, 10.2)),
                    child: InkWell(
                      onTap: () {
                        // ✅ Direct call without any condition
                        provider.setHours(hour);
                        print('🔥 Hour selected: $hour');
                      },
                      child: Container(
                        width: ResponsiveUtils.wp(context, 8.5),
                        height: ResponsiveUtils.hp(context, 4.25),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.darkGreen
                              : AppColors.white,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.darkGreen
                                : AppColors.appGrey,
                          ),
                          borderRadius: BorderRadius.circular(
                              ResponsiveUtils.getBorderRadius(context, 6.8)),
                        ),
                        child: Center(
                          child: Text(
                            "$hour",
                            style: TextStyle(
                              fontSize: ResponsiveUtils.sp(context, 12.75),
                              fontWeight: FontWeight.w900,
                              color: isSelected
                                  ? AppColors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }
}
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/utils/responsive_utils.dart';
// import '../provider/home_cleaing_provider.dart';
//
// class HoursSelectionWidget extends StatefulWidget {
//   final BookingProvider provider;
//
//   const HoursSelectionWidget({Key? key, required this.provider})
//       : super(key: key);
//
//   @override
//   State<HoursSelectionWidget> createState() => _HoursSelectionWidgetState();
// }
//
// class _HoursSelectionWidgetState extends State<HoursSelectionWidget> {
//   @override
//   void initState() {
//     super.initState();
//     // listen to provider changes
//     widget.provider.addListener(_checkAndSelectHours);
//     WidgetsBinding.instance.addPostFrameCallback((_) => _checkAndSelectHours());
//   }
//
//   @override
//   void dispose() {
//     widget.provider.removeListener(_checkAndSelectHours);
//     super.dispose();
//   }
//
//   void _checkAndSelectHours() {
//     if (widget.provider.selectedServices.isNotEmpty &&
//         widget.provider.selectedHours == null) {
//       widget.provider.setHours(1);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<BookingProvider>(
//       builder: (context, provider, _) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   "How many hours do you need your\nprofessional to stay?",
//                   style: TextStyle(
//                     fontSize: ResponsiveUtils.sp(context, 11.9),
//                     fontWeight: FontWeight.w900,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(width: ResponsiveUtils.getSpacing(context, 6.8)),
//                 Icon(Icons.info_outline,
//                     color: Colors.black,
//                     size: ResponsiveUtils.getIconSize(context, base: 17)),
//               ],
//             ),
//             SizedBox(height: ResponsiveUtils.getSpacing(context, 13.6)),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: List.generate(8, (index) {
//                   final hour = index + 1;
//                   final isSelected = provider.selectedHours == hour;
//                   return Padding(
//                     padding: EdgeInsets.only(
//                         right: ResponsiveUtils.getSpacing(context, 10.2)),
//                     child: InkWell(
//                       onTap: () => provider.setHours(hour),
//                       child: Container(
//                         width: ResponsiveUtils.wp(context, 8.5),
//                         height: ResponsiveUtils.hp(context, 4.25),
//                         decoration: BoxDecoration(
//                           color: isSelected
//                               ? AppColors.darkGreen
//                               : AppColors.white,
//                           border: Border.all(
//                             color: isSelected
//                                 ? AppColors.darkGreen
//                                 : AppColors.appGrey,
//                           ),
//                           borderRadius: BorderRadius.circular(
//                               ResponsiveUtils.getBorderRadius(context, 6.8)),
//                         ),
//                         child: Center(
//                           child: Text(
//                             "$hour",
//                             style: TextStyle(
//                               fontSize: ResponsiveUtils.sp(context, 12.75),
//                               fontWeight: FontWeight.w900,
//                               color: isSelected
//                                   ? AppColors.white
//                                   : Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// //
// // import '../../../../../core/constants/app_colors.dart';
// // import '../../../../../core/utils/responsive_utils.dart';
// // import '../provider/home_cleaing_provider.dart';
// //
// // class HoursSelectionWidget extends StatelessWidget {
// //   final BookingProvider provider;
// //
// //   const HoursSelectionWidget({Key? key, required this.provider}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Row(
// //           children: [
// //             Text(
// //               "How many hours do you need your\nprofessional to stay?",
// //               style: TextStyle(
// //                 fontSize: ResponsiveUtils.sp(context, 11.9),
// //                 fontWeight: FontWeight.w900,
// //                 color: Colors.black,
// //               ),
// //             ),
// //             SizedBox(width: ResponsiveUtils.getSpacing(context, 6.8)),
// //             Icon(
// //               Icons.info_outline,
// //               color: Colors.black,
// //               size: ResponsiveUtils.getIconSize(context, base: 17),
// //             ),
// //           ],
// //         ),
// //         SizedBox(height: ResponsiveUtils.getSpacing(context, 13.6)),
// //         SingleChildScrollView(
// //           scrollDirection: Axis.horizontal,
// //           child: Row(
// //             children: List.generate(8, (index) {
// //               final hour = index + 1;
// //               // ✅ اگر selectedHours null ہے تو کوئی selected نہیں
// //               final isSelected = provider.selectedHours == hour;
// //               return Padding(
// //                 padding: EdgeInsets.only(right: ResponsiveUtils.getSpacing(context, 10.2)),
// //                 child: InkWell(
// //                   onTap: () => provider.setHours(hour),
// //                   child: Container(
// //                     width: ResponsiveUtils.wp(context, 8.5),
// //                     height: ResponsiveUtils.hp(context, 4.25),
// //                     decoration: BoxDecoration(
// //                       color: isSelected ? AppColors.darkGreen : AppColors.white,
// //                       border: Border.all(
// //                         color: isSelected ? AppColors.darkGreen : AppColors.appGrey,
// //                       ),
// //                       borderRadius: BorderRadius.circular(ResponsiveUtils.getBorderRadius(context, 6.8)),
// //                     ),
// //                     child: Center(
// //                       child: Text(
// //                         "$hour",
// //                         style: TextStyle(
// //                           fontSize: ResponsiveUtils.sp(context, 12.75),
// //                           fontWeight: FontWeight.w900,
// //                           color: isSelected ? AppColors.white : Colors.black,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             }),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// // // import 'package:flutter/cupertino.dart';
// // // import 'package:flutter/material.dart';
// // //
// // // import '../../../../../core/constants/app_colors.dart';
// // // import '../../../../../core/utils/responsive_utils.dart';
// // // import '../provider/home_cleaing_provider.dart';
// // //
// // // class HoursSelectionWidget extends StatelessWidget {
// // //   final BookingProvider provider;
// // //
// // //   const HoursSelectionWidget({Key? key, required this.provider}) : super(key: key);
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Row(
// // //           children: [
// // //             Text(
// // //               "How many hours do you need your\nprofessional to stay?",
// // //               style: TextStyle(
// // //                 fontSize: ResponsiveUtils.sp(context, 11.9),
// // //                 fontWeight: FontWeight.w900,
// // //                 color: Colors.black,
// // //               ),
// // //             ),
// // //             SizedBox(width: ResponsiveUtils.getSpacing(context, 6.8)),
// // //             Icon(
// // //               Icons.info_outline,
// // //               color: Colors.black,
// // //               size: ResponsiveUtils.getIconSize(context, base: 17),
// // //             ),
// // //           ],
// // //         ),
// // //         SizedBox(height: ResponsiveUtils.getSpacing(context, 13.6)),
// // //         SingleChildScrollView(
// // //           scrollDirection: Axis.horizontal,
// // //           child: Row(
// // //             children: List.generate(8, (index) {
// // //               final hour = index + 1;
// // //               final isSelected = provider.hours == hour;
// // //               return Padding(
// // //                 padding: EdgeInsets.only(right: ResponsiveUtils.getSpacing(context, 10.2)),
// // //                 child: InkWell(
// // //                   onTap: () => provider.setHours(hour),
// // //                   child: Container(
// // //                     width: ResponsiveUtils.wp(context, 8.5),
// // //                     height: ResponsiveUtils.hp(context, 4.25),
// // //                     decoration: BoxDecoration(
// // //                       color: isSelected ? AppColors.darkGreen : AppColors.white,
// // //                       border: Border.all(
// // //                         color: isSelected ? AppColors.darkGreen : AppColors.appGrey,
// // //                       ),
// // //                       borderRadius: BorderRadius.circular(ResponsiveUtils.getBorderRadius(context, 6.8)),
// // //                     ),
// // //                     child: Center(
// // //                       child: Text(
// // //                         "$hour",
// // //                         style: TextStyle(
// // //                           fontSize: ResponsiveUtils.sp(context, 12.75),
// // //                           fontWeight: FontWeight.w900,
// // //                           color: isSelected ? AppColors.white : Colors.black,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               );
// // //             }),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // // }
