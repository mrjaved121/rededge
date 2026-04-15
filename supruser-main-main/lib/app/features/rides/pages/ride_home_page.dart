import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/features/rides/pages/confirm_pick_up.dart';
import 'package:suprapp/app/features/rides/pages/schedule_bottom_sheet.dart';
import 'package:suprapp/app/features/rides/pages/schedule_screen.dart';
import 'School_rides_pages.dart';
import 'city_to_city.dart';
import 'enter_pick_up_location.dart';
import 'dart:async';
import 'dart:html' as html;
import 'dart:js' as js;

class RideHomePage extends StatefulWidget {
  const RideHomePage({super.key});

  @override
  State<RideHomePage> createState() => _RideHomePageState();
}

class _RideHomePageState extends State<RideHomePage> {
  GoogleMapController? _mapController;
  bool _mapsLoaded = false;

  final List<Map<String, String>> rideOptions = [
    {
      "title": "Schedule",
      "imagePath": "assets/images/cariconschedule.png"
    },
    {
      "title": "School Rides",
      "imagePath": "assets/images/carpthmen.png"
    },
    {
      "title": "City to City",
      "imagePath": "assets/images/citytocity.png"
    },
  ];

  @override
  void initState() {
    super.initState();
    _checkMapsLoaded();
  }

  // Check if Google Maps is loaded
  void _checkMapsLoaded() {
    // For web, check if Google Maps API is loaded
    if (html.window.navigator.userAgent.contains('Chrome') || 
        html.window.navigator.userAgent.contains('Firefox') ||
        html.window.navigator.userAgent.contains('Safari')) {
      // Web platform
      // Use js_util to check for googleMapsLoaded property
      try {
        // Check if googleMapsLoaded property exists on window object
        final googleMapsLoaded = js.context.hasProperty('googleMapsLoaded');
        if (googleMapsLoaded) {
          setState(() {
            _mapsLoaded = true;
          });
        } else {
          // Listen for Google Maps loaded event
          html.window.addEventListener('google-maps-loaded', (event) {
            setState(() {
              _mapsLoaded = true;
            });
          });
          
          // Fallback timeout
          Future.delayed(const Duration(seconds: 5), () {
            if (!_mapsLoaded) {
              setState(() {
                _mapsLoaded = true; // Force load after 5 seconds
              });
            }
          });
        }
      } catch (e) {
        // Fallback for any errors
        Future.delayed(const Duration(seconds: 5), () {
          if (!_mapsLoaded) {
            setState(() {
              _mapsLoaded = true; // Force load after 5 seconds
            });
          }
        });
      }
    } else {
      // For mobile platforms, Google Maps is always available
      setState(() {
        _mapsLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: CustomScrollView(
        slivers: [
          /// ✅ Collapsing Header (Green)
          SliverAppBar(
            expandedHeight: screenHeight * 0.35,
            pinned: true,
            backgroundColor: const Color(0xff00342C),
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,

                  /// ✅ Two clickable, scrollable images
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      /// 🖼 First clickable image
                      InkWell(
                        onTap: () {
                          /* Navigator.pushNamed(context, '/firstScreen');*/
                          // OR Get.to(FirstScreen());
                        },
                        child: Image.asset(
                          'assets/images/rideheader1stbanner.jpg', // first image
                          fit: BoxFit.fill,
                          width: screenWidth, // full screen width
                          height: double.infinity,
                        ),
                      ),

                      /// 🖼 Second clickable image
                      InkWell(
                        onTap: () {
                          /* Navigator.pushNamed(context, '/secondScreen');*/
                          // OR Get.to(SecondScreen());
                        },
                        child: Image.asset(
                          'assets/images/ride2ndbanner.jpg', // second image
                          fit: BoxFit.fill,
                          width: screenWidth,
                          height: double.infinity,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),


          /// ✅ Scrollable Body
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.00),

                /// ✅ Map with Overlay SearchPanel
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.00),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25),bottomRight:Radius.zero,bottomLeft: Radius.zero),
                        child: SizedBox(
                          height: screenHeight * 0.38,
                          width: double.infinity,
                          child: _mapsLoaded 
                            ? GoogleMap(
                                initialCameraPosition: const CameraPosition(
                                  target: LatLng(25.0772, 55.1332), // Dubai
                                  zoom: 13,
                                ),
                                onMapCreated: (controller) {
                                  _mapController = controller;
                                },
                                myLocationEnabled: true,
                                myLocationButtonEnabled: true,
                                zoomControlsEnabled: false,
                              )
                            : Container(
                                color: Colors.grey[300],
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                        ),
                      ),

                      /// ✅ Combined container (Search + Apartment)
                      Positioned(
                        top: 16,
                        left: 16,
                        right: 16,
                        child: SearchPanel(),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                /// ✅ Rides Header
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Rides for every need",
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),

                /// ✅ Ride Options
                SizedBox(
                  height: screenHeight * 0.12,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    scrollDirection: Axis.horizontal,
                    itemCount: rideOptions.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final ride = rideOptions[index];


                      return InkWell(
                        onTap: () {
                          // 👉 Navigation logic here
                          if (ride["title"] == "Schedule") {
                            ScheduleBottomSheet.show(context);
                          } else if (ride["title"] == "School Rides") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SchoolRidesPage()),
                            );
                          } else if (ride["title"] == "City to City") {
                            CityToCityBottomSheet.show(context);
                          }
                        },
                        child: RideCard(
                          title: ride["title"]??"",
                          imagePath: ride["imagePath"]??"",
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                /// ✅ Dummy Offers
                ...List.generate(
                  3, // 3 widgets total: card1, text, card2
                      (i) {
                    final offerImages = [
                      'assets/images/offercard1.jpg',
                      'assets/images/offercard2.jpg',
                    ];

                    // If index == 1, show "Offers" text in between
                    if (i == 1) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child:
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Offers",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }

                    // Adjust image index (0 for first card, 1 for second)
                    final imageIndex = i == 0 ? 0 : 1;

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      height: 99,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        offerImages[imageIndex],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    );
                  },
                ),



                SizedBox(height: screenHeight * 0.06),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}

/// ✅ Widget: SearchPanel (combined container like your image)
class SearchPanel extends StatelessWidget {
  const SearchPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// Where To field
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EnterPickUpLocationPage()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8), // spacing around green box
                    decoration: BoxDecoration(
                      color: AppColors.darkGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "Where to?",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// Apartment info row
          Row(
            children: [
              Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.apartment, color: Colors.black54),
              ),
              SizedBox(width: screenWidth * 0.03),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My apartment",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "bajb - bainq - Al Barsha 3 - Dubai",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

/// ✅ Widget: RideCard (already clean and simple)
class RideCard extends StatelessWidget {
  final String title;
  final String imagePath;
  const RideCard({required this.title, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: Color(0xffE8E8E8),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          /*BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),*/
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imagePath.isNotEmpty)
            Image.asset(imagePath, height: 50, width: 80, fit: BoxFit.contain)
          else
            const Icon(Icons.error,size:40,color:Colors.red),
          const SizedBox(height: 8),

          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}