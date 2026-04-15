import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/bike_ride/sheets/enter_location_sheet.dart';
import 'package:suprapp/app/features/home/widgets/top_sheet.dart';
import 'package:suprapp/app/features/rides/provider/map_provider.dart';
import 'package:suprapp/app/features/rides/widgets/appbar_seet.dart';
import 'package:suprapp/app/features/rides/widgets/custom_drage_able_bottom_sheet.dart';

class BikeRidePage extends StatefulWidget {
  const BikeRidePage({super.key});

  @override
  State<BikeRidePage> createState() => _BikeRidePageState();
}

class _BikeRidePageState extends State<BikeRidePage> {
  void showTopSheet(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "TopSheet",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return const Material(
          color: Colors.transparent,
          child: CareemTopSheet(),
        );
      },
      transitionBuilder: (_, animation, __, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MapProvider>(
        builder: (context, provider, child) {
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
              Positioned(
                top: 40,
                left: 10,
                right: 10,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.appGrey),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppColors.darkGrey,
                            size: 20,
                          ),
                        ),
                      ),
                      Text(
                        'Bike Rides',
                        style: textTheme(context).headlineLarge?.copyWith(
                              color: colorScheme(context).primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showGeneralDialog(
                            context: context,
                            barrierDismissible: true,
                            barrierLabel: 'TopSheet',
                            transitionDuration:
                                const Duration(milliseconds: 300),
                            pageBuilder: (_, __, ___) =>
                                const SizedBox.shrink(),
                            transitionBuilder: (_, animation, __, ___) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, -1),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: const Align(
                                  alignment: Alignment.topCenter,
                                  child: TopSheetWidget(),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: colorScheme(context).primary,
                            border: Border.all(color: AppColors.appGrey),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Icon(
                            Icons.menu,
                            color: Color.fromARGB(255, 20, 188, 96),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const EnterLocationSheet(),
            ],
          );
        },
      ),
    );
  }
}
