import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/features/rides/provider/map_provider.dart';
import 'package:suprapp/app/features/rides/provider/ride_provider.dart';

import 'package:suprapp/app/features/rides/widgets/ride_status_widget.dart';
import 'package:suprapp/app/features/rides/widgets/vehicle_selection_widget.dart';
import 'package:suprapp/app/features/rides/widgets/driver_rating_widget.dart';
import 'package:suprapp/app/features/rides/model/vehicle_type.dart';
import 'package:suprapp/app/features/rides/model/driver.dart'; // Add this import

class RideManagementPage extends StatefulWidget {
  const RideManagementPage({Key? key}) : super(key: key);

  @override
  State<RideManagementPage> createState() => _RideManagementPageState();
}

class _RideManagementPageState extends State<RideManagementPage> {
  GoogleMapController? _mapController;
  late MapProvider _mapProvider;
  late RideProvider _rideProvider;
  LatLng? _pickupLocation;
  LatLng? _dropoffLocation;
  bool _showRating = false;

  @override
  void initState() {
    super.initState();
    _mapProvider = MapProvider();
    _rideProvider = RideProvider();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _mapProvider),
        ChangeNotifierProvider.value(value: _rideProvider),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ride Management'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _refreshData,
            ),
          ],
        ),
        body: Column(
          children: [
            // Map Section
            Expanded(
              flex: 2,
              child: _buildMapSection(),
            ),
            // Controls Section
            Expanded(
              flex: 1,
              child: _buildControlsSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection() {
    return Consumer<MapProvider>(
      builder: (context, mapProvider, child) {
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: mapProvider.currentPosition ?? const LatLng(25.197197, 55.274376),
                zoom: 13,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
                mapProvider.onMapCreated(controller);
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              polylines: mapProvider.polylines,
              markers: _buildMarkers(mapProvider),
            ),
            // Map Controls
            Positioned(
              top: 16,
              right: 16,
              child: Column(
                children: [
                  FloatingActionButton(
                    mini: true,
                    onPressed: _centerOnCurrentLocation,
                    child: const Icon(Icons.my_location),
                  ),
                  const SizedBox(height: 8),

                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Set<Marker> _buildMarkers(MapProvider mapProvider) {
    Set<Marker> markers = <Marker>{};
    
    // Add current location marker
    if (mapProvider.currentPosition != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: mapProvider.currentPosition!,
          infoWindow: const InfoWindow(title: 'Your Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }
    

    
    return markers;
  }

  Widget _buildControlsSection() {
    return Consumer2<MapProvider, RideProvider>(
      builder: (context, mapProvider, rideProvider, child) {
        if (_showRating && rideProvider.currentRide != null) {
          // Show rating widget after ride completion
          // Fix the driver selection logic
          Driver? driverToRate;
          if (rideProvider.driver != null) {
            driverToRate = rideProvider.driver;
          }
          
          if (driverToRate != null) {
            return DriverRatingWidget(
              driver: driverToRate,
              onRatingSubmitted: _submitRating,
            );
          }
        }
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vehicle Selection
              VehicleSelectionWidget(
                pickupLocation: _pickupLocation,
                dropoffLocation: _dropoffLocation,
                onVehicleSelected: _onVehicleSelected,
              ),
              const SizedBox(height: 16),
              
              // Ride Status
              RideStatusWidget(
                onAcceptRide: _acceptRide,
                onStartRide: _startRide,
                onCompleteRide: _completeRide,
                onCancelRide: _cancelRide,
              ),
              const SizedBox(height: 16),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _getCurrentRide,
                      child: const Text('Refresh Ride Status'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _onVehicleSelected(VehicleType vehicleType) {
    // Handle vehicle selection
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selected ${vehicleType.name}')),
    );
  }

  void _acceptRide() async {
    final rideProvider = context.read<RideProvider>();
    if (rideProvider.currentRide != null) {
      await rideProvider.acceptRide(
        orderId: rideProvider.currentRide!.id,
        driverId: 1, // In a real app, this would be the current driver's ID
      );
    }
  }

  void _startRide() async {
    final rideProvider = context.read<RideProvider>();
    if (rideProvider.currentRide != null) {
      await rideProvider.startRide(
        orderId: rideProvider.currentRide!.id,
      );
    }
  }

  void _completeRide() async {
    final rideProvider = context.read<RideProvider>();
    if (rideProvider.currentRide != null) {
      await rideProvider.completeRide(
        orderId: rideProvider.currentRide!.id,
      );
      setState(() {
        _showRating = true;
      });
    }
  }

  void _cancelRide() async {
    final rideProvider = context.read<RideProvider>();
    if (rideProvider.currentRide != null) {
      await rideProvider.cancelRide(rideProvider.currentRide!.id);
    }
  }

  void _getCurrentRide() async {
    final rideProvider = context.read<RideProvider>();
    await rideProvider.getCurrentRide();
  }

  void _refreshData() {
    // Refresh current ride
    _getCurrentRide();
  }

  void _centerOnCurrentLocation() {
    final mapProvider = context.read<MapProvider>();
    if (mapProvider.currentPosition != null && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(mapProvider.currentPosition!, 14),
      );
    }
  }



  void _submitRating(double rating, String review) async {
    final rideProvider = context.read<RideProvider>();
    if (rideProvider.currentRide != null) {
      await rideProvider.rateDriver(
        orderId: rideProvider.currentRide!.id,
        driverId: rideProvider.currentRide!.driverId ?? 1,
        rating: rating,
        review: review,
      );
      
      setState(() {
        _showRating = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rating submitted successfully')),
      );
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}