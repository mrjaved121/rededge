import 'package:flutter/material.dart';

class LoyaltyPointsWidget extends StatelessWidget {
  final int loyaltyPoints;
  final String tier;
  final int totalRides;
  final VoidCallback? onRewardsPressed;

  const LoyaltyPointsWidget({
    Key? key,
    required this.loyaltyPoints,
    required this.tier,
    required this.totalRides,
    this.onRewardsPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine tier color
    Color tierColor = _getTierColor(tier);
    Color tierBackgroundColor = _getTierBackgroundColor(tier);
    
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
          Row(
            children: [
              const Icon(
                Icons.card_membership,
                color: Colors.purple,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Loyalty Program',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: tierBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tier.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: tierColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatCard(
                icon: Icons.star,
                value: '$loyaltyPoints',
                label: 'Points',
                color: Colors.amber,
              ),
              const SizedBox(width: 16),
              _buildStatCard(
                icon: Icons.local_taxi,
                value: '$totalRides',
                label: 'Rides',
                color: Colors.blue,
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onRewardsPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'View Rewards',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getTierBenefits(tier),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTierColor(String tier) {
    switch (tier.toLowerCase()) {
      case 'bronze':
        return Colors.brown;
      case 'silver':
        return Colors.grey;
      case 'gold':
        return Colors.amber;
      case 'platinum':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Color _getTierBackgroundColor(String tier) {
    switch (tier.toLowerCase()) {
      case 'bronze':
        return Colors.brown.withOpacity(0.1);
      case 'silver':
        return Colors.grey.withOpacity(0.1);
      case 'gold':
        return Colors.amber.withOpacity(0.1);
      case 'platinum':
        return Colors.blue.withOpacity(0.1);
      default:
        return Colors.grey.withOpacity(0.1);
    }
  }

  String _getTierBenefits(String tier) {
    switch (tier.toLowerCase()) {
      case 'bronze':
        return 'Earn 10 points per ${1} spent. Unlock more benefits by upgrading to Silver.';
      case 'silver':
        return 'Earn 12 points per ${1} spent. Enjoy priority customer support.';
      case 'gold':
        return 'Earn 15 points per ${1} spent. Get exclusive discounts and priority support.';
      case 'platinum':
        return 'Earn 20 points per ${1} spent. Enjoy all benefits plus exclusive perks.';
      default:
        return 'Start earning points with every ride!';
    }
  }
}