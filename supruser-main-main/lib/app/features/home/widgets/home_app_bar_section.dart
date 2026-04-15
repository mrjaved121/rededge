import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/home/widgets/custom_icon_button.dart';
import 'package:suprapp/app/features/home/widgets/top_sheet.dart';
import 'package:suprapp/app/routes/go_router.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

class HomeAppBarSection extends StatelessWidget {
  const HomeAppBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xFFFFF3D9),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/app_logo.png',
            height: 30,
            width: 70,
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(30),
            ),
            child: CustomElevatedButton(
              borderRadius: 30,
              buttonColor: AppColors.accentColor,
              padding: const EdgeInsets.all(0),
              width: 70,
              height: 30,
              onPressed: () {
                context.pushNamed(AppRoute.suprPayPage);
              },
              text: 'Pay',
              textStyle: textTheme(context).bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).onSurface,
                  ),
            ),
          ),
          const SizedBox(width: 4),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(30),
            ),
            child: CustomIconButton(
              height: 30,
              width: 30,
              iconSize: 18,
              borderRadius: 30,
              icon: Icons.menu,
              iconColor: colorScheme(context).onSurface,
              buttonColor: AppColors.accentColor,
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
              padding: const EdgeInsets.all(0),
            ),
          ),
        ],
      ),
    );
  }
}
