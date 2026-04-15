import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';

class OpeningHoursBottomSheet extends StatelessWidget {
  final String today = 'Wednesday'; // Dynamically set this if needed

  final Map<String, String> openingHours = {
    'Monday': '7:30 AM - 1:30 AM',
    'Tuesday': '7:30 AM - 1:30 AM',
    'Wednesday': '7:30 AM - 1:30 AM',
    'Thursday': '7:30 AM - 1:30 AM',
    'Friday': '7:30 AM - 2:30 AM',
    'Saturday': '7:30 AM - 2:30 AM',
    'Sunday': '7:30 AM - 2:30 AM',
  };

  OpeningHoursBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Opening hours',
                style: textTheme(context)
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 16),
          ...openingHours.entries.map((entry) {
            final isToday = entry.key == today;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key,
                      style: textTheme(context)
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Text(entry.value,
                      style: textTheme(context).bodyMedium?.copyWith(
                          fontWeight:
                              isToday ? FontWeight.w600 : FontWeight.normal)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
