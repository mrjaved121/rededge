import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/rides/provider/map_provider.dart';
import 'package:suprapp/app/features/rides/widgets/cancel_custom_bottom_sheet.dart';

class CaptainWayPage extends StatefulWidget {
  const CaptainWayPage({super.key});

  @override
  State<CaptainWayPage> createState() => _CaptainWayPageState();
}

class _CaptainWayPageState extends State<CaptainWayPage> {
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

            /// Draggable Bottom Sheet
            DraggableScrollableSheet(
              initialChildSize: 0.5,
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
                        const SizedBox(height: 40),
                        Text("Your Captain is on the way",
                            style: textTheme(context)
                                .headlineLarge
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 25,

                              backgroundImage: NetworkImage(
                                  'https://toppng.com/uploads/preview/happy-black-person-115314937552vhdlzhqnj.png'), // Replace with actual image
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Islam K.",
                                        style: textTheme(context)
                                            .bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.star,
                                        color: Colors.blue, size: 16),
                                    Text(" 4.9",
                                        style: textTheme(context)
                                            .bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.circle,
                                        size: 8, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text("White Lexus ES300H",
                                        style: textTheme(context)
                                            .bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.darkGrey)),
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text("L42132"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Call & Chat buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.call),
                                label: const Text("CALL"),
                              ),
                            ),
                            const VerticalDivider(),
                            Expanded(
                              child: TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.chat_bubble_outline),
                                label: const Text("CHAT"),
                              ),
                            ),
                          ],
                        ),
                        Text("Trip Details",
                            style: textTheme(context)
                                .bodySmall
                                ?.copyWith(color: Colors.grey)),
                        const SizedBox(height: 20),
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
                            Text("Comfort",
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
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.payment, size: 20),
                                const SizedBox(width: 20),
                                Text(
                                  "Fare",
                                  style: textTheme(context)
                                      .bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "INR 69.67-93.87",
                                  style: textTheme(context)
                                      .bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
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
                                Icons.share,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Text("Share ride details",
                                  style: textTheme(context)
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.headphones,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Text("Need our help?",
                                  style: textTheme(context)
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              builder: (context) =>
                                  const CancelConfirmationBottomSheet(),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.close,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "Cancle ride",
                                style: textTheme(context).bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.carmineRed),
                              ),
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
