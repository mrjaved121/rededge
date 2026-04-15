import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../provider/home_cleaing_provider.dart';

class DateSelectionWidget extends StatelessWidget {
  final BookingProvider provider;

  const DateSelectionWidget({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "When would you like your service?",
          style: TextStyle(
            fontSize: ResponsiveUtils.sp(context, 14),
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(7, (index) {
              final date = DateTime.now().add(Duration(days: index));
              return Padding(
                padding: EdgeInsets.only(right: ResponsiveUtils.getSpacing(context, 12)),
                child: DateCard(
                  date: date,
                  provider: provider,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class DateCard extends StatelessWidget {
  final DateTime date;
  final BookingProvider provider;

  const DateCard({
    super.key,
    required this.date,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = provider.selectedDate?.day == date.day;
    final weekday = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][date.weekday - 1];

    return InkWell(
      onTap: () => provider.setSelectedDate(date),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            weekday,
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(context, 10),
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
          Container(
            width: ResponsiveUtils.wp(context, 10),
            height: ResponsiveUtils.wp(context, 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.darkGreen : AppColors.white,
              border: Border.all(
                color: isSelected ? AppColors.darkGreen : AppColors.appGrey,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(ResponsiveUtils.getBorderRadius(context, 10)),
            ),
            child: Center(
              child: Text(
                "${date.day}",
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 14),
                  fontWeight: FontWeight.w700,
                  color: isSelected ? AppColors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}