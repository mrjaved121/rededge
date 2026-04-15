import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/rides/widgets/find_captain_sheet.dart';
import 'package:suprapp/app/routes/go_router.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

class ScheduledRideBottomSheet extends StatelessWidget {
  final DateTime pickupTimeStart;
  final DateTime pickupTimeEnd;

  const ScheduledRideBottomSheet({
    super.key,
    required this.pickupTimeStart,
    required this.pickupTimeEnd,
  });

  String get pickupTimeRange {
    final formatter = DateFormat('hh:mm a');
    return '${formatter.format(pickupTimeStart)} - ${formatter.format(pickupTimeEnd)}';
  }

  String get pickupDate {
    final formatter = DateFormat('EEE, dd MMM');
    return formatter.format(pickupTimeStart);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your scheduled ride has been confirmed",
                style: textTheme(context)
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.1)),
                child: Icon(
                  Icons.calendar_month_outlined,
                  color: colorScheme(context).primary,
                ),
              ),
              title: Text(
                "Your pickup",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              subtitle: Text('$pickupDate, $pickupTimeRange',
                  style: textTheme(context)
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            Text(
              "We will send you a push notification to remind you when the Captain is on the way.",
              style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            CustomElevatedButton(
              text: "Okay got it",
              onPressed: () {
                context.pushNamed(AppRoute.findingCaptain);
              },
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => context.pushNamed(AppRoute.manageRide),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.withOpacity(0.3))),
                child: Center(
                  child: Text(
                    "Manage this ride",
                    style: textTheme(context)
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
