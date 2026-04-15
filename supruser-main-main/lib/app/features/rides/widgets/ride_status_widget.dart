import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/features/rides/provider/ride_provider.dart';
import 'package:suprapp/app/features/rides/model/ride_order.dart';

class RideStatusWidget extends StatelessWidget {
  final Function()? onAcceptRide;
  final Function()? onStartRide;
  final Function()? onCompleteRide;
  final Function()? onCancelRide;

  const RideStatusWidget({
    Key? key,
    this.onAcceptRide,
    this.onStartRide,
    this.onCompleteRide,
    this.onCancelRide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RideProvider>(
      builder: (context, rideProvider, child) {
        if (rideProvider.isLoading) {
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
              ],
            ),
          );
        }

        if (rideProvider.currentRide == null) {
          return const Center(child: Text('No active ride'));
        }

        final ride = rideProvider.currentRide!;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ride Status: ${_getStatusText(ride.status)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text('Order ID: ${ride.code ?? ride.id}'),
              const SizedBox(height: 8),
              Text('Pickup: ${ride.pickupAddress}'),
              const SizedBox(height: 8),
              Text('Dropoff: ${ride.dropoffAddress}'),
              if (ride.driverId != null) ...[
                const SizedBox(height: 8),
                Text('Driver ID: ${ride.driverId}'),
              ],
              const SizedBox(height: 16),
              _buildActionButtons(ride, context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(RideOrder ride, BuildContext context) {
    switch (ride.status) {
      case 'pending':
        return Row(
          children: [
            ElevatedButton(
              onPressed: onAcceptRide,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Accept Ride'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: onCancelRide,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Cancel'),
            ),
          ],
        );
      case 'accepted':
        return Row(
          children: [
            ElevatedButton(
              onPressed: onStartRide,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Start Ride'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: onCancelRide,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Cancel'),
            ),
          ],
        );
      case 'started':
        return Row(
          children: [
            ElevatedButton(
              onPressed: onCompleteRide,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Complete Ride'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: onCancelRide,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Cancel'),
            ),
          ],
        );
      case 'completed':
        return const Text('Ride completed');
      case 'cancelled':
        return const Text('Ride cancelled');
      default:
        return const Text('Unknown status');
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'Looking for driver';
      case 'accepted':
        return 'Driver assigned';
      case 'started':
        return 'Ride in progress';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }
}