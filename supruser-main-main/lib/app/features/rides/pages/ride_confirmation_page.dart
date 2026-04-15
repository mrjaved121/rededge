import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:suprapp/app/features/rides/model/ride_order.dart';
import 'package:suprapp/app/features/rides/model/driver.dart';
import 'package:suprapp/app/features/rides/model/vehicle_type.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';

class RideConfirmationPage extends StatefulWidget {
  final RideOrder rideOrder;
  
  const RideConfirmationPage({super.key, required this.rideOrder});

  @override
  State<RideConfirmationPage> createState() => _RideConfirmationPageState();
}

class _RideConfirmationPageState extends State<RideConfirmationPage> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = <Marker>{};
  
  // Generate random realistic driver data if not provided
  late Driver _driver;
  late VehicleType _vehicleType;

  @override
  void initState() {
    super.initState();
    _initializeDriverData();
    _initializeMarkers();
  }

  void _initializeDriverData() {
    // If driver data is not available, generate random data
    if (widget.rideOrder.driver != null) {
      _driver = widget.rideOrder.driver!;
    } else {
      // Generate random driver data
      final randomNames = [
        'Michael Johnson',
        'David Smith',
        'James Wilson',
        'Robert Brown',
        'John Davis',
        'William Miller',
        'Thomas Moore',
        'Christopher Taylor'
      ];
      
      final randomCarMakes = [
        'Toyota',
        'Honda',
        'Ford',
        'BMW',
        'Mercedes',
        'Audi',
        'Hyundai',
        'Kia'
      ];
      
      final randomCarModels = [
        'Camry',
        'Accord',
        'Focus',
        '3 Series',
        'C-Class',
        'A4',
        'Elantra',
        'Sorento'
      ];
      
      final randomColors = [
        'White',
        'Black',
        'Silver',
        'Blue',
        'Red',
        'Gray',
        'Green',
        'Beige'
      ];
      
      final random = Random();
      
      _driver = Driver(
        id: random.nextInt(1000),
        name: randomNames[random.nextInt(randomNames.length)],
        phone: '+1${random.nextInt(9000000000) + 1000000000}',
        rating: 4.0 + random.nextDouble() * 1.0, // Random rating between 4.0 and 5.0
        vehicle: Vehicle(
          id: random.nextInt(1000),
          regNo: '${String.fromCharCode(random.nextInt(26) + 65)}${String.fromCharCode(random.nextInt(26) + 65)}${random.nextInt(9000) + 1000}',
          color: randomColors[random.nextInt(randomColors.length)],
          carMake: randomCarMakes[random.nextInt(randomCarMakes.length)],
          carModel: randomCarModels[random.nextInt(randomCarModels.length)],
        ),
        latitude: widget.rideOrder.pickupLatitude + (random.nextDouble() - 0.5) * 0.01,
        longitude: widget.rideOrder.pickupLongitude + (random.nextDouble() - 0.5) * 0.01,
      );
    }
    
    // If vehicle type is not available, use default
    _vehicleType = widget.rideOrder.vehicleType ?? VehicleType(
      id: 1,
      name: 'Economy',
      slug: 'economy',
      baseFare: 2.5,
      distanceFare: 1.2,
      timeFare: 0.3,
      minFare: 5.0,
      total: 12.5,
      tax: 1.25,
      photo: '',
      icon: '',
      seater: 4,
    );
  }

  void _initializeMarkers() {
    final Set<Marker> markers = <Marker>{};
    
    // Add pickup marker
    markers.add(
      Marker(
        markerId: const MarkerId('pickup'),
        position: LatLng(widget.rideOrder.pickupLatitude, widget.rideOrder.pickupLongitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: 'Pickup', snippet: widget.rideOrder.pickupAddress),
      ),
    );
    
    // Add driver marker if location is available
    if (_driver.latitude != null && _driver.longitude != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('driver'),
          position: LatLng(_driver.latitude!, _driver.longitude!),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: 'Driver', snippet: _driver.name),
        ),
      );
    }
    
    setState(() {
      _markers = markers;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    // Center the map on the pickup location
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(widget.rideOrder.pickupLatitude, widget.rideOrder.pickupLongitude),
        15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map view
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.rideOrder.pickupLatitude, widget.rideOrder.pickupLongitude),
              zoom: 15,
            ),
            onMapCreated: _onMapCreated,
            markers: _markers,
            myLocationEnabled: !kIsWeb, // Disable on web due to permission issues
            myLocationButtonEnabled: !kIsWeb, // Disable on web due to permission issues
            zoomControlsEnabled: false,
          ),
          
          // Header
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Booking Confirmed!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.appGreen,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Your ride is confirmed. The driver is on the way.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom sheet with driver and ride info
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Handle bar
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    
                    // Driver card
                    _buildDriverCard(),
                    
                    const SizedBox(height: 16),
                    
                    // Ride info card
                    _buildRideInfoCard(),
                    
                    const SizedBox(height: 16),
                    
                    // Action buttons
                    _buildActionButtons(),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Driver',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          Row(
            children: [
              // Driver avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.appGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  Icons.person,
                  color: AppColors.appGreen,
                  size: 30,
                ),
              ),
              const SizedBox(width: 12),
              
              // Driver info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _driver.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _driver.rating!.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Vehicle info
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${_driver.vehicle!.carMake} ${_driver.vehicle!.carModel}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _driver.vehicle!.regNo,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Contact buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Call driver functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Calling driver...')),
                  );
                },
                icon: const Icon(Icons.call, color: Colors.white),
                label: const Text('Call', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Message driver functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Messaging driver...')),
                  );
                },
                icon: const Icon(Icons.message, color: Colors.white),
                label: const Text('Message', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRideInfoCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ride Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _vehicleType.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '\$${widget.rideOrder.total?.toStringAsFixed(2) ?? _vehicleType.total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.appGreen,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Vehicle Plate',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                _driver.vehicle!.regNo,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Status indicator
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.appGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: AppColors.appGreen,
                  size: 16,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Driver is on the way',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.appGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Cancel Ride button
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                // Cancel ride functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ride cancelled'),
                    backgroundColor: Colors.red,
                  ),
                );
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Cancel Ride',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Track Ride button
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Track ride functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tracking ride...'),
                    backgroundColor: AppColors.appGreen,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Track Ride',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}