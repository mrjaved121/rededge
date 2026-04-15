import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/home/widgets/custom_icon_button.dart';
import 'package:suprapp/app/features/home/widgets/top_sheet.dart';
import 'package:suprapp/app/routes/go_router.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

import '../../../shared/widgets/custom_menu_button.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white, // Using AppColors instead of hardcoded
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          // App Bar Section - Pay, Logo, Menu
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Pay Button
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: CustomElevatedButton(
                    borderRadius: 10,
                    buttonColor: AppColors.darklightblue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    width: isSmallScreen ? 65 : 75,
                    height: 40,
                    onPressed: () {
                      context.pushNamed(AppRoute.suprPayPage);
                    },
                    text: 'Pay',
                    textStyle: textTheme(context).bodyMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: isSmallScreen ? 13 : 14,
                    ),
                  ),
                ),

                // Logo
                Image.asset(
                  'assets/images/app_logo.png',
                  height: isSmallScreen ? 17 : 22,
                  width: isSmallScreen ? 57 : 67,
                  fit: BoxFit.contain,
                ),

                // Menu Button
                CustomMenuButton(
                  onPressed: () {
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: 'TopSheet',
                      transitionDuration: const Duration(milliseconds: 300),
                      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
                      transitionBuilder: (_, animation, __, ___) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, -1),
                            end: Offset.zero,
                          ).animate(animation),
                          child: const Align(
                            alignment: Alignment.topCenter,
                            child: TopSheetWidget(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),

          // City Selection Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.045,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: AppColors.bluegray,
                borderRadius: BorderRadius.all(Radius.circular(isSmallScreen ? 6 : 10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // City Change Text
                  Text(
                    'Need to change your city?',
                    style: textTheme(context).bodySmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      fontSize: isSmallScreen ? 12 : 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Your currently selected city is Abu Dhabi',
                    style: textTheme(context).bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.black, // Using AppColors
                      fontSize: isSmallScreen ? 11 : 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // Action Buttons - Responsive Column/Row
                  _buildActionButtons(context, screenWidth, isSmallScreen),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function - Responsive buttons
  Widget _buildActionButtons(BuildContext context, double screenWidth, bool isSmallScreen) {
    final isMediumScreen = screenWidth < 400;
    final useColumn = screenWidth < 340;

    return useColumn
        ? Column(
      children: [
        // Select City Button
        _buildCityButton(
          context: context,
          icon: Icons.refresh,
          label: 'Select city',
          onTap: () {
            // context.pushNamed(AppRoute.citySelectionPage);
          },
          isSmallScreen: isSmallScreen,
        ),
        SizedBox(height: isSmallScreen ? 10 : 12),
        // Use Current Location Button
        _buildCityButton(
          context: context,
          icon: null,
          label: 'Use current location',
          onTap: () {
            // context.pushNamed(AppRoute.offersTabPage);
          },
          isSmallScreen: isSmallScreen,
        ),
      ],
    )
        : Row(
      children: [
        // Select City Button
        Expanded(
          child: _buildCityButton(
            context: context,
            icon: Icons.refresh,
            label: 'Select city',
            onTap: () {
              // context.pushNamed(AppRoute.citySelectionPage);
            },
            isSmallScreen: isSmallScreen,
          ),
        ),
        SizedBox(width: isSmallScreen ? 8 : 10),
        // Use Current Location Button
        Expanded(
          child: _buildCityButton(
            context: context,
            icon: null,
            label: 'Use current location',
            onTap: () {
              context.pushNamed(AppRoute.offersTabPage);
            },
            isSmallScreen: isSmallScreen,
          ),
        ),
      ],
    );
  }

  // Helper function - Individual button
  Widget _buildCityButton({
    required BuildContext context,
    required IconData? icon,
    required String label,
    required VoidCallback onTap,
    required bool isSmallScreen,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12 : 14,
          vertical: isSmallScreen ? 9 : 11,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.appGrey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: isSmallScreen ? 16 : 18,
                color: AppColors.textGrey,
              ),
              SizedBox(width: isSmallScreen ? 5 : 7),
            ],
            Flexible(
              child:               Text(
                label,
                style: textTheme(context).bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: isSmallScreen ? 11 : 12,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:suprapp/app/core/constants/app_colors.dart';
// import 'package:suprapp/app/core/constants/global_variables.dart';
// import 'package:suprapp/app/features/home/widgets/custom_icon_button.dart';
// import 'package:suprapp/app/features/home/widgets/top_sheet.dart';
// import 'package:suprapp/app/routes/go_router.dart';
// import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';
//
// import '../../../shared/widgets/custom_menu_button.dart';
//
// class HomeHeader extends StatelessWidget {
//   const HomeHeader({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isSmallScreen = screenWidth < 360;
//
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Colors.white,
//             Colors.white, // Using AppColors instead of hardcoded
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//       ),
//       child: Column(
//         children: [
//           // App Bar Section - Pay, Logo, Menu
//           Container(
//             height: 60,
//             padding: EdgeInsets.symmetric(
//               horizontal: screenWidth * 0.04,
//               vertical: 8,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Pay Button
//                 Container(
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.15),
//                         spreadRadius: 0,
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: CustomElevatedButton(
//                     borderRadius: 10,
//                     buttonColor: AppColors.darklightblue,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 8,
//                     ),
//                     width: isSmallScreen ? 65 : 75,
//                     height: 40,
//                     onPressed: () {
//                       context.pushNamed(AppRoute.suprPayPage);
//                     },
//                     text: 'Pay',
//                     textStyle: textTheme(context).bodyMedium?.copyWith(
//                       fontWeight: FontWeight.w900,
//                       color: Colors.white,
//                       fontSize: isSmallScreen ? 13 : 14,
//                     ),
//                   ),
//                 ),
//
//                 // Logo
//                 Image.asset(
//                   'assets/images/app_logo.png',
//                   height: isSmallScreen ? 17 : 22,
//                   width: isSmallScreen ? 57 : 67,
//                   fit: BoxFit.contain,
//                 ),
//
//                 // Menu Button
//                 CustomMenuButton(
//                   onPressed: () {
//                     showGeneralDialog(
//                       context: context,
//                       barrierDismissible: true,
//                       barrierLabel: 'TopSheet',
//                       transitionDuration: const Duration(milliseconds: 300),
//                       pageBuilder: (_, __, ___) => const SizedBox.shrink(),
//                       transitionBuilder: (_, animation, __, ___) {
//                         return SlideTransition(
//                           position: Tween<Offset>(
//                             begin: const Offset(0, -1),
//                             end: Offset.zero,
//                           ).animate(animation),
//                           child: const Align(
//                             alignment: Alignment.topCenter,
//                             child: TopSheetWidget(),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//
//           // City Selection Section
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(
//                 horizontal: screenWidth * 0.045,
//                 vertical: 16,
//               ),
//               decoration: BoxDecoration(
//                 color: AppColors.bluegray,
//                 borderRadius: BorderRadius.all(Radius.circular(isSmallScreen ? 6 : 10)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // City Change Text
//                   Text(
//                     'Need to change your city?',
//                     style: textTheme(context).bodySmall?.copyWith(
//                       fontWeight: FontWeight.w900,
//                       color: Colors.black,
//                       fontSize: isSmallScreen ? 12 : 13,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     'Your currently selected city is Abu Dhabi',
//                     style: textTheme(context).bodySmall?.copyWith(
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black, // Using AppColors
//                       fontSize: isSmallScreen ? 11 : 12,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   // Text(
//                   //   'Need to change your city?',
//                   //   style: textTheme(context).bodySmall?.copyWith(
//                   //     fontWeight: FontWeight.w700,
//                   //     color: AppColors.textGrey, // Using AppColors
//                   //     fontSize: isSmallScreen ? 12 : 13,
//                   //   ),
//                   // ),
//                   // const SizedBox(height: 2),
//                   // Text(
//                   //   'Your currently selected city is Abu Dhabi',
//                   //   style: textTheme(context).bodySmall?.copyWith(
//                   //     fontWeight: FontWeight.w500,
//                   //     color: AppColors.darkTextGrey, // Using AppColors
//                   //     fontSize: isSmallScreen ? 11 : 12,
//                   //   ),
//                   // ),
//                   const SizedBox(height: 12),
//
//                   // Action Buttons Row
//                   // Action Buttons Row - Fixed for all screen sizes
//                   Row(
//                     children: [
//                       // Select City Button
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             // context.pushNamed(AppRoute.citySelectionPage);
//                           },
//                           child: Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: isSmallScreen ? 10 : 12,
//                               vertical: isSmallScreen ? 8 : 10,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(
//                                 color: AppColors.appGrey,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(20),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.07),
//                                   blurRadius: 4,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(
//                                   Icons.refresh,
//                                   size: isSmallScreen ? 16 : 18,
//                                   color: AppColors.textGrey,
//                                 ),
//                                 SizedBox(width: isSmallScreen ? 4 : 6),
//                                 Flexible(
//                                   child: Text(
//                                     'Select city',
//                                     style: textTheme(context).bodyMedium?.copyWith(
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black,
//                                       fontSize: isSmallScreen ? 12 : 13,
//                                     ),
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 1,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       SizedBox(width: isSmallScreen ? 8 : 10),
//
//                       // Use Current Location Button
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             context.pushNamed(AppRoute.offersTabPage);
//                           },
//                           child: Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: isSmallScreen ? 10 : 12,
//                               vertical: isSmallScreen ? 8 : 10,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(
//                                 color: AppColors.appGrey,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(20),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.05),
//                                   blurRadius: 4,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Flexible(
//                                   child: Text(
//                                     'Use current location',
//                                     style: textTheme(context).bodyMedium?.copyWith(
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black,
//                                       fontSize: isSmallScreen ? 12 : 13,
//                                     ),
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 1,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }