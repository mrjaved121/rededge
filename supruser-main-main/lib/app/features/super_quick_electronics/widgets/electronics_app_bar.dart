import 'package:flutter/material.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';
import 'package:suprapp/app/features/home/widgets/top_sheet.dart';
import 'package:suprapp/app/routes/go_router.dart';

class ElectronicsAppBar extends StatelessWidget {
  const ElectronicsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.wp(context, 3.2),
        vertical: ResponsiveUtils.hp(context, 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              // Navigator.pushReplacementNamed(context, AppRoute.homePage);
            },
            child: Container(
              height: ResponsiveUtils.hp(context, 5.4),
              width: ResponsiveUtils.hp(context, 5.4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.arrow_back,
                size: ResponsiveUtils.sp(context, 22),
              ),
            ),
          ),
          Text(
            'Quik',
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(context, 24),
              fontWeight: FontWeight.bold,
              color: const Color(0xff018D14),
            ),
          ),
          Container(
            height: ResponsiveUtils.hp(context, 5.4),
            width: ResponsiveUtils.hp(context, 5.4),
            decoration: BoxDecoration(
              color: const Color(0xff018D14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
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
              icon: Icon(
                Icons.menu,
                size: ResponsiveUtils.sp(context, 22),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}