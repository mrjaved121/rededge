import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:suprapp/app/features/rides/pages/ride_confirmation.dart';
import 'package:suprapp/app/features/rides/pages/schedule_screen.dart';

import '../../../routes/go_router.dart';

class RideOptionsPage extends StatefulWidget {
  const RideOptionsPage({super.key});

  @override
  State<RideOptionsPage> createState() => _RideOptionsPageState();
}

class _RideOptionsPageState extends State<RideOptionsPage> {
  late GoogleMapController _mapController;
  final LatLng _initialPosition = const LatLng(25.2048, 55.2708); // Dubai

  // Schedule data
  DateTime? _scheduledDate;
  TimeOfDay? _scheduledTime;
  bool _isScheduled = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          /// -------------------- GOOGLE MAP --------------------
          GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 12.5,
            ),
            zoomControlsEnabled: false,
            myLocationEnabled: true,
          ),

          /// -------------------- BACK BUTTON --------------------
          Positioned(
            top: height * 0.05,
            left: width * 0.04,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: EdgeInsets.all(width * 0.02),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 5),
                  ],
                ),
                child: Icon(Icons.arrow_back, size: width * 0.06),
              ),
            ),
          ),

          /// -------------------- PICKUP & DESTINATION CARDS --------------------
          Positioned(
            top: height * 0.12,
            left: width * 0.15,
            child: _mapInfoCard(
              icon: Icons.flight_takeoff,
              title: "Arrive by 11:21 PM",
              subtitle: "Block U - 17/3 - University Rd",
              width: width,
            ),
          ),
          Positioned(
            top: height * 0.25,
            left: width * 0.12,
            child: _mapInfoCard(
              icon: Icons.location_pin,
              title: "Pickup in 4 mins",
              subtitle: "My apartment",
              width: width,
            ),
          ),

          /// -------------------- BOTTOM SHEET --------------------
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.015),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(width * 0.05)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, -2)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: height * 0.005,
                    width: width * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  SizedBox(height: height * 0.015),

                  /// --- RIDE OPTIONS LIST (🔁 UPDATED: Image.asset instead of Icon) ---
                  _rideOption(
                    width: width,
                    image: 'assets/images/carexecutive.png',
                    title: "Comfort",
                    subtitle: "4 mins away • 11:21 PM",
                    price: "₫ 174 - 219",
                    selected: true,
                  ),
                  _rideOption(
                    width: width,
                    image: 'assets/images/carexecutive.png',
                    title: "Executive",
                    subtitle: "3 mins away • 11:21 PM",
                    price: "₫ 224.08",
                    selected: false,
                  ),
                  _rideOption(
                    width: width,
                    image: 'assets/images/carexecutive.png',
                    title: "Hala Taxi",
                    subtitle: "12 mins away • 11:35 PM",
                    price: "₫ 116 - 142",
                    selected: false,
                  ),

                  SizedBox(height: height * 0.02),

                  /// --- PAYMENT SECTION (✅ KEPT FUNCTIONAL) ---
                  InkWell(
                    onTap: () async {
                      final result = await context.pushNamed(AppRoute.paymentOptions);
                      if (result != null) {
                        // Handle the selected payment method
                        print("Selected payment method: $result");
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.account_balance_wallet_outlined,
                                color: Colors.black87),
                            SizedBox(width: width * 0.025),
                            Text(
                              "Cash",
                              style: TextStyle(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),

                  /// --- BUTTONS (✅ KEPT FUNCTIONAL) ---
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RideConfirmationPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff0F6A43),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(width * 0.03),
                            ),
                            padding:
                            EdgeInsets.symmetric(vertical: height * 0.018),
                          ),
                          child: Text(
                            "Yalla!",
                            style: TextStyle(
                              fontSize: width * 0.045,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.04),
                      InkWell(
                        onTap: () async {
                          // Open Schedule Screen
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ScheduleScreen(),
                            ),
                          );

                          // Get returned data
                          if (result != null && result is Map) {
                            setState(() {
                              _scheduledDate = result['date'] as DateTime?;
                              _scheduledTime = result['time'] as TimeOfDay?;
                              _isScheduled = result['bookNow'] != true;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffE8F5E9),
                            borderRadius: BorderRadius.circular(width * 0.03),
                          ),
                          padding: EdgeInsets.all(width * 0.025),
                          child: Icon(
                            Icons.calendar_today_outlined,
                            color: const Color(0xff0F6A43),
                            size: width * 0.06,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.015),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// -------------------- WIDGETS --------------------

  /// 🔁 UPDATED: Changed from IconData to String (Image path)
  Widget _rideOption({
    required double width,
    required String image, // ✅ Changed from IconData to String
    required String title,
    required String subtitle,
    required String price,
    bool selected = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: width * 0.03),
      padding: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
        border: Border.all(
          color: selected ? const Color(0xff0F6A43) : Colors.grey[300]!,
          width: selected ? 1.8 : 1,
        ),
        borderRadius: BorderRadius.circular(width * 0.03),
        color: selected ? const Color(0xffE8F5E9) : Colors.white,
      ),
      child: Row(
        children: [
          /// 🔁 Changed from Icon to Image.asset
          Image.asset(
            image,
            width: width * 0.12,
            height: width * 0.12,
            fit: BoxFit.contain,
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.04,
                      ),
                    ),
                    SizedBox(width: width * 0.01),
                    const Icon(Icons.person_outline, size: 16),
                    const Text(" 4"),
                  ],
                ),
                SizedBox(height: width * 0.01),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: width * 0.032,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: width * 0.04,
            ),
          ),
        ],
      ),
    );
  }

  Widget _mapInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required double width,
  }) {
    return Container(
      padding: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * 0.04),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xff0F6A43),
              borderRadius: BorderRadius.circular(width * 0.02),
            ),
            padding: EdgeInsets.all(width * 0.015),
            child: Icon(icon, color: Colors.white, size: width * 0.045),
          ),
          SizedBox(width: width * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: width * 0.035)),
              SizedBox(height: width * 0.01),
              Text(subtitle,
                  style: TextStyle(
                      fontSize: width * 0.032, color: Colors.black54)),
            ],
          ),
          SizedBox(width: width * 0.02),
          const Icon(Icons.arrow_forward_ios_rounded,
              size: 14, color: Colors.black54),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:suprapp/app/features/rides/pages/ride_confirmation.dart';
// import 'package:suprapp/app/features/rides/pages/schedule_screen.dart';
//
// import '../../../routes/go_router.dart';
//
// class RideOptionsPage extends StatefulWidget {
//   const RideOptionsPage({super.key});
//
//   @override
//   State<RideOptionsPage> createState() => _RideOptionsPageState();
// }
//
// class _RideOptionsPageState extends State<RideOptionsPage> {
//   late GoogleMapController _mapController;
//   final LatLng _initialPosition = const LatLng(25.2048, 55.2708); // Dubai
//   // Schedule data
//   DateTime? _scheduledDate;
//   TimeOfDay? _scheduledTime;
//   bool _isScheduled = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           /// -------------------- GOOGLE MAP --------------------
//           GoogleMap(
//             onMapCreated: (controller) => _mapController = controller,
//             initialCameraPosition: CameraPosition(
//               target: _initialPosition,
//               zoom: 12.5,
//             ),
//             zoomControlsEnabled: false,
//             myLocationEnabled: true,
//           ),
//
//           /// -------------------- BACK BUTTON --------------------
//           Positioned(
//             top: height * 0.05,
//             left: width * 0.04,
//             child: InkWell(
//               onTap: () => Navigator.pop(context),
//               borderRadius: BorderRadius.circular(50),
//               child: Container(
//                 padding: EdgeInsets.all(width * 0.02),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(color: Colors.black26, blurRadius: 5),
//                   ],
//                 ),
//                 child: Icon(Icons.arrow_back, size: width * 0.06),
//               ),
//             ),
//           ),
//
//           /// -------------------- PICKUP & DESTINATION CARDS --------------------
//           Positioned(
//             top: height * 0.12,
//             left: width * 0.15,
//             child: _mapInfoCard(
//               icon: Icons.flight_takeoff,
//               title: "Arrive by 11:21 PM",
//               subtitle: "Block U - 17/3 - University Rd",
//               width: width,
//             ),
//           ),
//           Positioned(
//             top: height * 0.25,
//             left: width * 0.12,
//             child: _mapInfoCard(
//               icon: Icons.location_pin,
//               title: "Pickup in 4 mins",
//               subtitle: "My apartment",
//               width: width,
//             ),
//           ),
//
//           /// -------------------- BOTTOM SHEET --------------------
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: EdgeInsets.symmetric(
//                   horizontal: width * 0.05, vertical: height * 0.015),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius:
//                 BorderRadius.vertical(top: Radius.circular(width * 0.05)),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.black.withOpacity(0.15),
//                       blurRadius: 10,
//                       offset: const Offset(0, -2)),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     height: height * 0.005,
//                     width: width * 0.15,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   SizedBox(height: height * 0.015),
//
//                   /// --- RIDE OPTIONS LIST ---
//                   _rideOption(
//                     width: width,
//                     image: Icons.directions_car,
//                     title: "Comfort",
//                     subtitle: "4 mins away • 11:21 PM",
//                     price: "₫ 174 - 219",
//                     selected: true,
//                   ),
//                   _rideOption(
//                     width: width,
//                     image: Icons.local_taxi,
//                     title: "Executive",
//                     subtitle: "3 mins away • 11:21 PM",
//                     price: "₫ 224.08",
//                     selected: false,
//                   ),
//                   _rideOption(
//                     width: width,
//                     image: Icons.directions_car_filled_outlined,
//                     title: "Hala Taxi",
//                     subtitle: "12 mins away • 11:35 PM",
//                     price: "₫ 116 - 142",
//                     selected: false,
//                   ),
//
//                   SizedBox(height: height * 0.02),
//
//                   /// --- PAYMENT SECTION ---
//                   InkWell(
//                     onTap: () async {
//                       final result = await context.pushNamed(AppRoute.paymentOptions);
//                       if (result != null) {
//                         // Handle the selected payment method
//                         print("Selected payment method: $result");
//                       }
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             const Icon(Icons.account_balance_wallet_outlined,
//                                 color: Colors.black87),
//                             SizedBox(width: width * 0.025),
//                             Text(
//                               "Cash",
//                               style: TextStyle(
//                                   fontSize: width * 0.04,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             const Icon(Icons.keyboard_arrow_down),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: height * 0.02),
//
//                   /// --- BUTTONS ---
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => const RideConfirmationPage(),
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xff0F6A43),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(width * 0.03),
//                             ),
//                             padding:
//                             EdgeInsets.symmetric(vertical: height * 0.018),
//                           ),
//                           child: Text(
//                             "Yalla!",
//                             style: TextStyle(
//                               fontSize: width * 0.045,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: width * 0.04),
//                       InkWell(
//                         onTap: () async {
//                           // Open Schedule Screen
//                           final result = await Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => const ScheduleScreen(),
//                             ),
//                           );
//
//                           // Get returned data
//                           if (result != null && result is Map) {
//                             setState(() {
//                               _scheduledDate = result['date'] as DateTime?;
//                               _scheduledTime = result['time'] as TimeOfDay?;
//                               _isScheduled = result['bookNow'] != true;
//                             });
//                           }
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: const Color(0xffE8F5E9),
//                             borderRadius: BorderRadius.circular(width * 0.03),
//                           ),
//                           padding: EdgeInsets.all(width * 0.025),
//                           child: Icon(
//                             Icons.calendar_today_outlined,
//                             color: const Color(0xff0F6A43),
//                             size: width * 0.06,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: height * 0.015),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// -------------------- WIDGETS --------------------
//
//   Widget _rideOption({
//     required double width,
//     required IconData image,
//     required String title,
//     required String subtitle,
//     required String price,
//     bool selected = false,
//   }) {
//     return Container(
//       margin: EdgeInsets.only(bottom: width * 0.03),
//       padding: EdgeInsets.all(width * 0.03),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: selected ? const Color(0xff0F6A43) : Colors.grey[300]!,
//           width: selected ? 1.8 : 1,
//         ),
//         borderRadius: BorderRadius.circular(width * 0.03),
//         color: selected ? const Color(0xffE8F5E9) : Colors.white,
//       ),
//       child: Row(
//         children: [
//           Icon(image, size: width * 0.12, color: const Color(0xff0F6A43)),
//           SizedBox(width: width * 0.04),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: width * 0.04,
//                       ),
//                     ),
//                     SizedBox(width: width * 0.01),
//                     const Icon(Icons.person_outline, size: 16),
//                     const Text(" 4"),
//                   ],
//                 ),
//                 SizedBox(height: width * 0.01),
//                 Text(
//                   subtitle,
//                   style: TextStyle(
//                     fontSize: width * 0.032,
//                     color: Colors.black54,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Text(
//             price,
//             style: TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: width * 0.04,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _mapInfoCard({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required double width,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(width * 0.03),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(width * 0.04),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.15),
//             blurRadius: 6,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: const Color(0xff0F6A43),
//               borderRadius: BorderRadius.circular(width * 0.02),
//             ),
//             padding: EdgeInsets.all(width * 0.015),
//             child: Icon(icon, color: Colors.white, size: width * 0.045),
//           ),
//           SizedBox(width: width * 0.03),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(title,
//                   style: TextStyle(
//                       fontWeight: FontWeight.w600, fontSize: width * 0.035)),
//               SizedBox(height: width * 0.01),
//               Text(subtitle,
//                   style: TextStyle(
//                       fontSize: width * 0.032, color: Colors.black54)),
//             ],
//           ),
//           SizedBox(width: width * 0.02),
//           const Icon(Icons.arrow_forward_ios_rounded,
//               size: 14, color: Colors.black54),
//         ],
//       ),
//     );
//   }
// }