import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/groceries/widgets/select_address_sheet.dart';
import 'package:suprapp/app/features/home/widgets/top_sheet.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.appGrey),
                      borderRadius: BorderRadius.circular(7)),
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.darkGrey,
                    size: 20,
                  ),
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcon.creeamLogo,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    'GROCERIES',
                    style: textTheme(context).headlineLarge?.copyWith(
                          color: colorScheme(context).primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(
                    width: 30,
                  )
                ],
              ),
              InkWell(
                onTap: () {
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
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: colorScheme(context).primary,
                      border: Border.all(color: AppColors.appGrey),
                      borderRadius: BorderRadius.circular(7)),
                  child: const Icon(
                    Icons.menu,
                    color: Color.fromARGB(255, 20, 188, 96),
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
