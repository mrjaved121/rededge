import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../provider/home_cleaing_provider.dart' show BookingProvider;

class ProfessionalsSelectionWidget extends StatelessWidget {
  final BookingProvider provider;

  const ProfessionalsSelectionWidget({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "How many professionals do you need?",
          style: TextStyle(
            fontSize: ResponsiveUtils.sp(context, 11.9),
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        SizedBox(height: ResponsiveUtils.getSpacing(context, 13.6)),
        Row(
          children: List.generate(4, (index) {
            final count = index + 1;
            final isSelected = provider.professionals == count;
            return Padding(
              padding: EdgeInsets.only(right: ResponsiveUtils.getSpacing(context, 10.2)),
              child: InkWell(
                onTap: () => provider.setProfessionals(count),
                child: Container(
                  width: ResponsiveUtils.wp(context, 8.5),
                  height: ResponsiveUtils.hp(context, 4.25),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.darkGreen : AppColors.white,
                    border: Border.all(
                      color: isSelected ? AppColors.darkGreen : AppColors.appGrey,
                    ),
                    borderRadius: BorderRadius.circular(ResponsiveUtils.getBorderRadius(context, 6.8)),
                  ),
                  child: Center(
                    child: Text(
                      "$count",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 12.75),
                        fontWeight: FontWeight.w900,
                        color: isSelected ? AppColors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
