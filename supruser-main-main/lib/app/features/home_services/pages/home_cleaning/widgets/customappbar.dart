import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../../../../../shared/widgets/custom_menu_button.dart';
import '../../../../home/widgets/top_sheet.dart';
import '../provider/home_cleaing_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final String title;
  final VoidCallback? onBackPressed; // ✅ NEW: Callback for back button

  const CustomAppBar({
    Key? key,
    this.showBackButton = false,
    required this.title,
    this.onBackPressed, // ✅ NEW
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            // ✅ اگر callback pass ہوا تو وہ call کرو
            if (onBackPressed != null) {
              onBackPressed!();
            } else {
              // ✅ Default behavior
              if (showBackButton) {
                context.pop();
              } else {
                Navigator.of(context).pop();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<BookingProvider>().resetCurrentService();
                });
              }
            }
          },
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.appGrey),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Icon(
              showBackButton ? Icons.arrow_back : Icons.close,
              color: AppColors.darkGrey,
              size: 20,
            ),
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: ResponsiveUtils.sp(context, 20),
          color: AppColors.darkGreen,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomMenuButton(
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
        ),
      ],
    );
  }
}
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/utils/responsive_utils.dart';
// import '../../../../../shared/widgets/custom_menu_button.dart';
// import '../../../../home/widgets/top_sheet.dart';
// import '../provider/home_cleaing_provider.dart';
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final bool showBackButton;
//   final String title; // 👈 add this
//
//   const CustomAppBar({
//     Key? key,
//     this.showBackButton = false,
//     required this.title, // 👈 required
//   }) : super(key: key);
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: AppColors.white,
//       elevation: 0,
//       leading: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: InkWell(
//           onTap: () {
//             if (showBackButton) {
//
//               // WidgetsBinding.instance.addPostFrameCallback((_) {
//               //   context.read<BookingProvider>().resetCurrentService();
//               // });
//               context.pop();
//             } else {
//               Navigator.of(context).pop();
//
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 context.read<BookingProvider>().resetCurrentService();
//               });
//             }
//           },
//           child: Container(
//             height: 30,
//             width: 30,
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.appGrey),
//               borderRadius: BorderRadius.circular(7),
//             ),
//             child: Icon(
//               showBackButton ? Icons.arrow_back : Icons.close,
//               color: AppColors.darkGrey,
//               size: 20,
//             ),
//           ),
//         ),
//       ),
//       centerTitle: true,
//       title: Text(
//         title, // 👈 dynamic title here
//         style: TextStyle(
//           fontWeight: FontWeight.w900,
//           fontSize: ResponsiveUtils.sp(context, 20),
//           color: AppColors.darkGreen,
//         ),
//       ),
//       actions: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: CustomMenuButton(
//             onPressed: () {
//               showGeneralDialog(
//                 context: context,
//                 barrierDismissible: true,
//                 barrierLabel: 'TopSheet',
//                 transitionDuration: const Duration(milliseconds: 300),
//                 pageBuilder: (_, __, ___) => const SizedBox.shrink(),
//                 transitionBuilder: (_, animation, __, ___) {
//                   return SlideTransition(
//                     position: Tween<Offset>(
//                       begin: const Offset(0, -1),
//                       end: Offset.zero,
//                     ).animate(animation),
//                     child: const Align(
//                       alignment: Alignment.topCenter,
//                       child: TopSheetWidget(),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
