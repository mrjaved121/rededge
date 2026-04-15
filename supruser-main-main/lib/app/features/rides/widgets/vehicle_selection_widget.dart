import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/features/rides/provider/ride_provider.dart';
import 'package:suprapp/app/features/rides/model/vehicle_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:suprapp/app/features/rides/widgets/surge_pricing_widget.dart';

class VehicleSelectionWidget extends StatelessWidget {
  final Function(VehicleType)? onVehicleSelected;
  final LatLng? pickupLocation;
  final LatLng? dropoffLocation;

  const VehicleSelectionWidget({
    Key? key,
    this.onVehicleSelected,
    this.pickupLocation,
    this.dropoffLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RideProvider>(
      builder: (context, rideProvider, child) {
        if (rideProvider.isLoading && rideProvider.vehicleTypes.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (rideProvider.error != null) {
          return Container(
            padding: const EdgeInsets.all(16),
            color: Colors.red[100],
            child: Column(
              children: [
                Text('Error: ${rideProvider.error}'),
                ElevatedButton(
                  onPressed: rideProvider.clearError,
                  child: const Text('Clear'),
                ),
                if (pickupLocation != null && dropoffLocation != null)
                  ElevatedButton(
                    onPressed: () {
                      rideProvider.getVehicleTypesWithPricing(
                        pickupLat: pickupLocation!.latitude,
                        pickupLng: pickupLocation!.longitude,
                        dropoffLat: dropoffLocation!.latitude,
                        dropoffLng: dropoffLocation!.longitude,
                      );
                    },
                    child: const Text('Retry'),
                  ),
              ],
            ),
          );
        }

        if (rideProvider.vehicleTypes.isEmpty) {
          return const Center(child: Text('No vehicle types available'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Vehicle Type',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            // Show surge pricing information if available
            if (rideProvider.vehicleTypes.isNotEmpty && 
                rideProvider.vehicleTypes.first.surgeRate != null)
              SurgePricingWidget(
                surgeMultiplier: rideProvider.vehicleTypes.first.surgeRate ?? 1.0,
                surgeReason: rideProvider.vehicleTypes.first.surgeRate != null && 
                             rideProvider.vehicleTypes.first.surgeRate! > 1.0
                    ? 'High demand in your area'
                    : 'Low demand in your area',
                zoneName: 'Current Location',
                isDiscount: rideProvider.vehicleTypes.first.surgeRate != null && 
                            rideProvider.vehicleTypes.first.surgeRate! < 1.0,
              ),
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: rideProvider.vehicleTypes.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final vehicleType = rideProvider.vehicleTypes[index];
                  return _VehicleTypeCard(
                    vehicleType: vehicleType,
                    onTap: () => onVehicleSelected?.call(vehicleType),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _VehicleTypeCard extends StatelessWidget {
  final VehicleType vehicleType;
  final VoidCallback? onTap;

  const _VehicleTypeCard({
    required this.vehicleType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (vehicleType.icon != null)
              Image.network(
                vehicleType.icon!,
                height: 40,
                width: 40,
                fit: BoxFit.contain,
              )
            else
              const Icon(Icons.directions_car, size: 40),
            const SizedBox(height: 8),
            Text(
              vehicleType.name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              '\$${vehicleType.total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            if (vehicleType.surgeRate != null && vehicleType.surgeRate! > 1.0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${vehicleType.surgeRate!.toStringAsFixed(1)}x Surge',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else if (vehicleType.surgeRate != null && vehicleType.surgeRate! < 1.0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${((1 - vehicleType.surgeRate!) * 100).toStringAsFixed(0)}% OFF',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}