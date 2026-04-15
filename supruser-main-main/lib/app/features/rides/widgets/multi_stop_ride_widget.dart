import 'package:flutter/material.dart';

class MultiStopRideWidget extends StatelessWidget {
  final List<RideStop> stops;
  final double? totalDistance;
  final double? totalDuration;
  final double? totalFare;
  final VoidCallback? onAddStop;
  final VoidCallback? onOptimizeRoute;
  final Function(int)? onRemoveStop;

  const MultiStopRideWidget({
    Key? key,
    this.stops = const [],
    this.totalDistance,
    this.totalDuration,
    this.totalFare,
    this.onAddStop,
    this.onOptimizeRoute,
    this.onRemoveStop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.route,
                color: Colors.purple,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'Multi-Stop Ride',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(Icons.info_outline, color: Colors.grey, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Add multiple stops to your ride and we\'ll optimize the route for the most efficient journey.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          _buildStopsList(context),
          const SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton(
                onPressed: onAddStop,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: const Text('Add Stop'),
              ),
              const SizedBox(width: 12),
              if (stops.length > 2)
                ElevatedButton(
                  onPressed: onOptimizeRoute,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  child: const Text('Optimize Route'),
                ),
            ],
          ),
          if (totalDistance != null || totalDuration != null || totalFare != null) ...[
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),
            _buildRideSummary(context),
          ],
        ],
      ),
    );
  }

  Widget _buildStopsList(BuildContext context) {
    if (stops.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        child: const Column(
          children: [
            Icon(
              Icons.add_location_alt_outlined,
              size: 48,
              color: Colors.grey,
            ),
            SizedBox(height: 12),
            Text(
              'No Stops Added',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Add your pickup and destination to get started',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: List.generate(stops.length, (index) {
        final stop = stops[index];
        return _buildStopItem(context, stop, index);
      }),
    );
  }

  Widget _buildStopItem(BuildContext context, RideStop stop, int index) {
    Color stopColor = Colors.blue;
    IconData stopIcon = Icons.location_on;
    
    if (index == 0) {
      stopColor = Colors.green;
      stopIcon = Icons.location_on;
    } else if (index == stops.length - 1) {
      stopColor = Colors.red;
      stopIcon = Icons.flag;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: stopColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  stopIcon,
                  color: stopColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      index == 0 
                          ? 'Pickup Location' 
                          : index == stops.length - 1 
                              ? 'Final Destination' 
                              : 'Stop ${index}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: stopColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stop.location['address'] ?? 'Address not specified',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (index != 0 && index != stops.length - 1)
                IconButton(
                  onPressed: () => onRemoveStop?.call(index),
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
            ],
          ),
          if (stop.status != 'pending') ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    stop.status == 'arrived' 
                        ? 'Driver has arrived' 
                        : 'Stop completed',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRideSummary(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ride Summary',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        if (totalDistance != null)
          _buildSummaryItem(
            context,
            icon: Icons.linear_scale,
            label: 'Distance',
            value: '${totalDistance!.toStringAsFixed(1)} km',
          ),
        if (totalDuration != null)
          _buildSummaryItem(
            context,
            icon: Icons.access_time,
            label: 'Duration',
            value: '${totalDuration!.toStringAsFixed(0)} min',
          ),
        if (totalFare != null)
          _buildSummaryItem(
            context,
            icon: Icons.attach_money,
            label: 'Estimated Fare',
            value: '\$${totalFare!.toStringAsFixed(2)}',
          ),
      ],
    );
  }

  Widget _buildSummaryItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey, size: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class RideStop {
  final int id;
  final int rideId;
  final int stopOrder;
  final Map<String, dynamic> location;
  final String status;

  RideStop({
    required this.id,
    required this.rideId,
    required this.stopOrder,
    required this.location,
    required this.status,
  });
}