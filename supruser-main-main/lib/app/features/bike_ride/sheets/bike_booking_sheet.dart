import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/rides/widgets/schdule_ride.dart';

class BikeBookingSheet extends StatefulWidget {
  const BikeBookingSheet({super.key});

  @override
  State<BikeBookingSheet> createState() => _BikeBookingSheetState();
}

class _BikeBookingSheetState extends State<BikeBookingSheet> {
  @override
  void initState() {
    super.initState();

    // Wait 5 seconds before showing the scheduled ride bottom sheet
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(context).pop(); // Close the current bottom sheet
        _showScheduledRideBottomSheet();
      }
    });
  }

  void _showScheduledRideBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => ScheduledRideBottomSheet(
        pickupTimeStart: DateTime(2025, 6, 12, 1, 20),
        pickupTimeEnd: DateTime(2025, 6, 12, 1, 30),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.65,
        builder: (_, controller) => SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Text(
                  "Creating a booking...",
                  style: textTheme(context)
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                LinearProgressIndicator(
                  value: 0.3,
                  minHeight: 6,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Icon(Icons.radio_button_checked,
                            color: Colors.green),
                        Container(
                          width: 2,
                          height: 40,
                          color: Colors.grey[300],
                        ),
                        const Icon(Icons.location_on, color: Colors.red),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tahir Qadri Abayat",
                              style: textTheme(context)
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          Text(
                            "Tahir Qadri Abayat, Tariq Road - PECHS Block 2 - Pakistan",
                            style: textTheme(context)
                                .bodySmall
                                ?.copyWith(color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          Text("Lahore DHA",
                              style: textTheme(context)
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          Text(
                            "62, 7 F St, D.H.A Phase 6 Defence Housing Authority",
                            style: textTheme(context)
                                .bodySmall
                                ?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black.withOpacity(0.3),
                ),
                const SizedBox(height: 24),
                Text("Booking details",
                    style: textTheme(context)
                        .bodySmall
                        ?.copyWith(color: Colors.grey)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Image.asset(
                      AppImages.bikeImage,
                      height: 32,
                      width: 32,
                    ),
                    const SizedBox(width: 12),
                    Text("GO Premium",
                        style: textTheme(context)
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.payment, size: 20),
                    const SizedBox(width: 20),
                    Text(
                      "Cash",
                      style: textTheme(context)
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(
                  color: Colors.black.withOpacity(0.3),
                ),
                Text("Manage Ride",
                    style: textTheme(context)
                        .bodySmall
                        ?.copyWith(color: Colors.grey)),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.help_outline,
                        color: Colors.grey[600],
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text("Get support",
                          style: textTheme(context)
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
