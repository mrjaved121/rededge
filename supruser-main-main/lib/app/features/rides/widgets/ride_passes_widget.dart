import 'package:flutter/material.dart';

class RidePassesWidget extends StatelessWidget {
  final List<RidePass> availablePasses;
  final List<UserRidePass> userPasses;
  final VoidCallback? onPurchasePass;

  const RidePassesWidget({
    Key? key,
    this.availablePasses = const [],
    this.userPasses = const [],
    this.onPurchasePass,
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
                Icons.card_membership,
                color: Colors.purple,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'Ride Passes',
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
            'Save money with our ride passes. Get unlimited rides or ride bundles at discounted rates.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          if (userPasses.isNotEmpty)
            _buildActivePasses(context)
          else
            _buildNoActivePasses(context),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 16),
          const Text(
            'Available Passes',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...availablePasses.map((pass) => _buildPassCard(context, pass)).toList(),
        ],
      ),
    );
  }

  Widget _buildActivePasses(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Active Passes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...userPasses.map((pass) => _buildUserPassCard(context, pass)).toList(),
      ],
    );
  }

  Widget _buildNoActivePasses(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.card_membership_outlined,
            size: 48,
            color: Colors.grey,
          ),
          const SizedBox(height: 12),
          const Text(
            'No Active Passes',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Purchase a ride pass to save on your rides',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserPassCard(BuildContext context, UserRidePass userPass) {
    // Find the pass details
    final pass = availablePasses.firstWhere(
      (p) => p.id == userPass.passId,
      orElse: () => RidePass(
        id: 0,
        name: 'Unknown Pass',
        description: '',
        type: '',
        durationDays: 0,
        rideLimit: 0,
        price: 0,
        discountPercent: 0,
        isActive: false,
      ),
    );

    final daysRemaining = userPass.expiryDate.difference(DateTime.now()).inDays;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pass.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'ACTIVE',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            pass.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildPassDetail(
                context,
                icon: Icons.access_time,
                label: 'Expires in',
                value: '$daysRemaining days',
              ),
              const SizedBox(width: 16),
              _buildPassDetail(
                context,
                icon: Icons.local_taxi,
                label: 'Rides left',
                value: '${userPass.ridesRemaining}',
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: userPass.ridesUsed / (userPass.ridesUsed + userPass.ridesRemaining),
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
          ),
        ],
      ),
    );
  }

  Widget _buildPassCard(BuildContext context, RidePass pass) {
    Color passColor = Colors.purple;
    
    if (pass.type == 'daily') {
      passColor = Colors.blue;
    } else if (pass.type == 'weekly') {
      passColor = Colors.green;
    } else if (pass.type == 'monthly') {
      passColor = Colors.purple;
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pass.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: passColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: passColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${pass.discountPercent.toInt()}% OFF',
                  style: TextStyle(
                    fontSize: 12,
                    color: passColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            pass.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPassFeature(
                context,
                icon: Icons.access_time,
                label: '${pass.durationDays} days',
              ),
              _buildPassFeature(
                context,
                icon: Icons.local_taxi,
                label: pass.rideLimit == 999999 ? 'Unlimited rides' : '${pass.rideLimit} rides',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${pass.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: passColor,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Purchase pass functionality would go here
                  if (onPurchasePass != null) {
                    onPurchasePass!();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: passColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text('Purchase'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPassDetail(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          '$label: $value',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildPassFeature(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.green),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class RidePass {
  final int id;
  final String name;
  final String description;
  final String type;
  final int durationDays;
  final int rideLimit;
  final double price;
  final double discountPercent;
  final bool isActive;

  RidePass({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.durationDays,
    required this.rideLimit,
    required this.price,
    required this.discountPercent,
    required this.isActive,
  });
}

class UserRidePass {
  final int id;
  final int userId;
  final int passId;
  final DateTime purchaseDate;
  final DateTime expiryDate;
  final int ridesUsed;
  final int ridesRemaining;
  final bool isActive;

  UserRidePass({
    required this.id,
    required this.userId,
    required this.passId,
    required this.purchaseDate,
    required this.expiryDate,
    required this.ridesUsed,
    required this.ridesRemaining,
    required this.isActive,
  });
}