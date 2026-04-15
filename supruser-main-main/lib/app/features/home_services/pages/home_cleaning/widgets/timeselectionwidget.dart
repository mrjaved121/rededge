import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../provider/home_cleaing_provider.dart';

class TimeSelectionWidget extends StatelessWidget {
  final BookingProvider provider;

  const TimeSelectionWidget({
    super.key,
    required this.provider,
  });

  /// Generate next 8 hours slots (rounded to next full hour)
  List<String> _generateNext8Hours() {
    final now = DateTime.now();
    final nextFullHour = DateTime(now.year, now.month, now.day, now.hour + 1);
    return List.generate(8, (i) {
      final time = nextFullHour.add(Duration(hours: i));
      final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
      final period = time.hour >= 12 ? "PM" : "AM";
      return "${hour.toString().padLeft(2, '0')}:00 $period";
    });
  }

  @override
  Widget build(BuildContext context) {
    final times = _generateNext8Hours();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "What time would you like us to start?",
              style: TextStyle(
                fontSize: ResponsiveUtils.sp(context, 14),
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "See all",
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 14),
                  fontWeight: FontWeight.w600,
                  color: AppColors.appGreen,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: ResponsiveUtils.getSpacing(context, 2)),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(times.length, (index) {
              final time = times[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: ResponsiveUtils.getSpacing(context, 10),
                ),
                child: TimeCard(
                  time: time,
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

/// Single Time Slot Card
class TimeCard extends StatelessWidget {
  final String time;
  final BookingProvider provider;

  const TimeCard({
    super.key,
    required this.time,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = provider.selectedTime == time;

    return InkWell(
      onTap: () => provider.setSelectedTime(time),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.getSpacing(context, 12),
          vertical: ResponsiveUtils.getSpacing(context, 10),
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.darkGreen : AppColors.white,
          border: Border.all(
            color: isSelected ? AppColors.darkGreen : AppColors.appGrey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.getBorderRadius(context, 8),
          ),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontSize: ResponsiveUtils.sp(context, 13),
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
