import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:suprapp/app/features/rides/pages/rideoptionPage.dart';
import 'package:suprapp/app/features/rides/pages/schedule_screen.dart';
import 'package:intl/intl.dart';

class ConfirmPickupPage extends StatefulWidget {
  const ConfirmPickupPage({super.key});

  @override
  State<ConfirmPickupPage> createState() => _ConfirmPickupPageState();
}

class _ConfirmPickupPageState extends State<ConfirmPickupPage> {
  late GoogleMapController _mapController;

  final LatLng _initialPosition = const LatLng(25.2048, 55.2708);

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
              zoom: 14.5,
            ),
            myLocationEnabled: true,
            zoomControlsEnabled: false,
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
                child: Icon(
                  Icons.arrow_back,
                  size: width * 0.06,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          /// -------------------- BOTTOM CARD --------------------
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: width,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.025,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(width * 0.06),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),

              /// -------------------- CONTENT --------------------
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      /// 🔁 UPDATED DESIGN: Icon replaced with Container + Image
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xff0F6A43), // green background
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/images/meniconwave.png", // 🔁 your image path
                            width: 22,
                            height: 22,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Safestway Supermarket",
                              style: TextStyle(
                                fontSize: width * 0.045,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * 0.005),
                            Text(
                              "R-Block, Model Town, Lahore",
                              style: TextStyle(
                                fontSize: width * 0.035,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.favorite_border,
                          color: Colors.redAccent, size: width * 0.06),
                    ],
                  ),

                  // Show scheduled time if set
                  if (_isScheduled && _scheduledDate != null && _scheduledTime != null)
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.015),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.03,
                          vertical: height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffE8F5E9),
                          borderRadius: BorderRadius.circular(width * 0.02),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.schedule,
                              size: width * 0.04,
                              color: const Color(0xff0F6A43),
                            ),
                            SizedBox(width: width * 0.02),
                            Text(
                              'Scheduled: ${DateFormat('MMM d, h:mm a').format(
                                DateTime(
                                  _scheduledDate!.year,
                                  _scheduledDate!.month,
                                  _scheduledDate!.day,
                                  _scheduledTime!.hour,
                                  _scheduledTime!.minute,
                                ),
                              )}',
                              style: TextStyle(
                                fontSize: width * 0.032,
                                color: const Color(0xff0F6A43),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  SizedBox(height: height * 0.025),

                  /// ----------- BUTTONS ------------
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RideOptionsPage(),
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
                            "Confirm Pick-up",
                            style: TextStyle(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:suprapp/app/features/rides/pages/rideoptionPage.dart';
// import 'package:suprapp/app/features/rides/pages/schedule_screen.dart';
// import 'package:intl/intl.dart';
//
// class ConfirmPickupPage extends StatefulWidget {
//   const ConfirmPickupPage({super.key});
//
//   @override
//   State<ConfirmPickupPage> createState() => _ConfirmPickupPageState();
// }
//
// class _ConfirmPickupPageState extends State<ConfirmPickupPage> {
//   late GoogleMapController _mapController;
//
//   final LatLng _initialPosition = const LatLng(25.2048, 55.2708);
//
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
//               zoom: 14.5,
//             ),
//             myLocationEnabled: true,
//             zoomControlsEnabled: false,
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
//                 child: Icon(
//                   Icons.arrow_back,
//                   size: width * 0.06,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//           ),
//
//           /// -------------------- BOTTOM CARD --------------------
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               width: width,
//               padding: EdgeInsets.symmetric(
//                 horizontal: width * 0.05,
//                 vertical: height * 0.025,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(
//                   top: Radius.circular(width * 0.06),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.15),
//                     blurRadius: 10,
//                     offset: const Offset(0, -2),
//                   ),
//                 ],
//               ),
//
//               /// -------------------- CONTENT --------------------
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.location_on,
//                           color: const Color(0xff0F6A43), size: width * 0.06),
//                       SizedBox(width: width * 0.03),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Safestway Supermarket",
//                               style: TextStyle(
//                                 fontSize: width * 0.045,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             SizedBox(height: height * 0.005),
//                             Text(
//                               "R-Block, Model Town, Lahore",
//                               style: TextStyle(
//                                 fontSize: width * 0.035,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Icon(Icons.favorite_border,
//                           color: Colors.redAccent, size: width * 0.06),
//                     ],
//                   ),
//
//                   // Show scheduled time if set
//                   if (_isScheduled && _scheduledDate != null && _scheduledTime != null)
//                     Padding(
//                       padding: EdgeInsets.only(top: height * 0.015),
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: width * 0.03,
//                           vertical: height * 0.01,
//                         ),
//                         decoration: BoxDecoration(
//                           color: const Color(0xffE8F5E9),
//                           borderRadius: BorderRadius.circular(width * 0.02),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(
//                               Icons.schedule,
//                               size: width * 0.04,
//                               color: const Color(0xff0F6A43),
//                             ),
//                             SizedBox(width: width * 0.02),
//                             Text(
//                               'Scheduled: ${DateFormat('MMM d, h:mm a').format(
//                                 DateTime(
//                                   _scheduledDate!.year,
//                                   _scheduledDate!.month,
//                                   _scheduledDate!.day,
//                                   _scheduledTime!.hour,
//                                   _scheduledTime!.minute,
//                                 ),
//                               )}',
//                               style: TextStyle(
//                                 fontSize: width * 0.032,
//                                 color: const Color(0xff0F6A43),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                   SizedBox(height: height * 0.025),
//
//                   /// ----------- BUTTONS ------------
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => RideOptionsPage(),
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
//                             "Confirm Pick-up",
//                             style: TextStyle(
//                               fontSize: width * 0.04,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
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
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:suprapp/app/features/rides/pages/rideoptionPage.dart';
//
//
// class ConfirmPickupPage extends StatefulWidget {
//   const ConfirmPickupPage({super.key});
//
//   @override
//   State<ConfirmPickupPage> createState() => _ConfirmPickupPageState();
// }
//
// class _ConfirmPickupPageState extends State<ConfirmPickupPage> {
//   late GoogleMapController _mapController;
//
//   final LatLng _initialPosition = const LatLng(31.5204, 74.3587); // Lahore default
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
//               zoom: 14.5,
//             ),
//             myLocationEnabled: true,
//             zoomControlsEnabled: false,
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
//                 child: Icon(
//                   Icons.arrow_back,
//                   size: width * 0.06,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//           ),
//
//           /// -------------------- BOTTOM CARD --------------------
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               width: width,
//               padding: EdgeInsets.symmetric(
//                 horizontal: width * 0.05,
//                 vertical: height * 0.025,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(
//                   top: Radius.circular(width * 0.06),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.15),
//                     blurRadius: 10,
//                     offset: const Offset(0, -2),
//                   ),
//                 ],
//               ),
//
//               /// -------------------- CONTENT --------------------
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.location_on,
//                           color: const Color(0xff0F6A43), size: width * 0.06),
//                       SizedBox(width: width * 0.03),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Safestway Supermarket",
//                               style: TextStyle(
//                                 fontSize: width * 0.045,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             SizedBox(height: height * 0.005),
//                             Text(
//                               "R-Block, Model Town, Lahore",
//                               style: TextStyle(
//                                 fontSize: width * 0.035,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Icon(Icons.favorite_border,
//                           color: Colors.redAccent, size: width * 0.06),
//                     ],
//                   ),
//                   SizedBox(height: height * 0.025),
//
//                   /// ----------- BUTTONS ------------
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             /// 👇 Yahan apna route lagana hai
//                             /// Example:
//                             Navigator.push(context, MaterialPageRoute(builder: (_) => RideOptionsPage()));
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
//                             "Confirm Pick-up",
//                             style: TextStyle(
//                               fontSize: width * 0.04,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: width * 0.04),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: const Color(0xffE8F5E9),
//                           borderRadius: BorderRadius.circular(width * 0.03),
//                         ),
//                         padding: EdgeInsets.all(width * 0.025),
//                         child: Icon(
//                           Icons.calendar_today_outlined,
//                           color: const Color(0xff0F6A43),
//                           size: width * 0.06,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }