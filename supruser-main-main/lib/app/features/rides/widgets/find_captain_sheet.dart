import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/rides/provider/map_provider.dart';
import 'package:suprapp/app/features/rides/widgets/captain_way_page.dart';

class FindCaptainBottomSheet extends StatefulWidget {
  const FindCaptainBottomSheet({super.key});

  @override
  State<FindCaptainBottomSheet> createState() => _FindCaptainBottomSheetState();
}

class _FindCaptainBottomSheetState extends State<FindCaptainBottomSheet> {
  @override
  void initState() {
    super.initState();

    // Wait 5 seconds before showing the scheduled ride bottom sheet
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(context).pop(); // Close the current bottom sheet
        _captainOnTheWayBottomSheet();
      }
    });
  }

  void _captainOnTheWayBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => CaptainWayPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MapProvider>(builder: (context, provider, child) {
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: provider.currentPosition ?? const LatLng(0, 0),
                zoom: 20,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: provider.onMapCreated,
              polylines: provider.polylines,
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.1,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Material(
                  // Ensure Material context
                  elevation: 10,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text("Finding Your Captain",
                            style: textTheme(context)
                                .headlineLarge
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        LinearProgressIndicator(
                          value: 0.3,
                          minHeight: 4,
                          backgroundColor: Colors.grey[300],
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                        SizedBox(
                          height: 30,
                        ),
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
                                const Icon(Icons.location_on,
                                    color: Colors.red),
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
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold)),
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
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold)),
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
                              AppImages.car1,
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
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
