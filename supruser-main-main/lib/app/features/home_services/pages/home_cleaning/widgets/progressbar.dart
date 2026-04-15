import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../provider/home_cleaing_provider.dart';

class ProgressBarWidget extends StatelessWidget {
  final int currentStep;

  const ProgressBarWidget({Key? key, required this.currentStep}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(4, (index) {
        return Expanded(
          child: Container(
            margin:  EdgeInsets.zero,
            height: ResponsiveUtils.hp(context, 0.45),
            decoration: BoxDecoration(
              color: index <= currentStep
                  ? AppColors.darkGreen
                  : Colors.black12,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}