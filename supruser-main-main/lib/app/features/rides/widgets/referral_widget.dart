import 'package:flutter/material.dart';

class ReferralWidget extends StatelessWidget {
  final String referralCode;
  final List<Referral> referrals;
  final List<ReferralReward> rewards;
  final VoidCallback? onSharePressed;

  const ReferralWidget({
    Key? key,
    required this.referralCode,
    this.referrals = const [],
    this.rewards = const [],
    this.onSharePressed,
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
                Icons.card_giftcard,
                color: Colors.purple,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'Refer Friends & Earn',
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
            'Share your referral code with friends and earn rewards when they sign up and take their first ride!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          _buildReferralCode(context),
          const SizedBox(height: 16),
          _buildRewardsInfo(context),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSharePressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Share Referral Code',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (referrals.isNotEmpty) ...[
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Your Referrals',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildReferralsList(context),
          ],
        ],
      ),
    );
  }

  Widget _buildReferralCode(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          const Text(
            'Your Referral Code',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                referralCode,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () {
                  // Copy to clipboard functionality would go here
                },
                icon: const Icon(Icons.copy, color: Colors.purple),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How It Works',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...rewards.map((reward) => _buildRewardItem(context, reward)).toList(),
      ],
    );
  }

  Widget _buildRewardItem(BuildContext context, ReferralReward reward) {
    IconData icon = Icons.card_giftcard;
    Color color = Colors.purple;
    
    if (reward.targetAction == "signup") {
      icon = Icons.person_add;
      color = Colors.blue;
    } else if (reward.targetAction == "first_ride") {
      icon = Icons.local_taxi;
      color = Colors.green;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reward.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reward.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _formatReward(reward.rewardType, reward.rewardValue),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralsList(BuildContext context) {
    return Column(
      children: referrals.map((referral) => _buildReferralItem(context, referral)).toList(),
    );
  }

  Widget _buildReferralItem(BuildContext context, Referral referral) {
    Color statusColor = Colors.grey;
    String statusText = 'Pending';
    
    switch (referral.status.toLowerCase()) {
      case 'signed_up':
        statusColor = Colors.blue;
        statusText = 'Signed Up';
        break;
      case 'completed_first_ride':
        statusColor = Colors.green;
        statusText = 'First Ride Completed';
        break;
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
                referral.referredEmail,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (referral.rewardClaimed)
            const Text(
              'Reward Claimed',
              style: TextStyle(
                fontSize: 12,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            )
          else
            const Text(
              'Reward Pending',
              style: TextStyle(
                fontSize: 12,
                color: Colors.orange,
              ),
            ),
        ],
      ),
    );
  }

  String _formatReward(String rewardType, double rewardValue) {
    switch (rewardType.toLowerCase()) {
      case 'points':
        return '${rewardValue.toInt()} pts';
      case 'cash':
        return '\$${rewardValue.toStringAsFixed(2)}';
      case 'discount':
        return '${rewardValue.toInt()}% off';
      default:
        return '$rewardValue';
    }
  }
}

class Referral {
  final int id;
  final int referrerId;
  final int? referredId;
  final String referralCode;
  final String referredEmail;
  final String status;
  final bool rewardClaimed;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;

  Referral({
    required this.id,
    required this.referrerId,
    this.referredId,
    required this.referralCode,
    required this.referredEmail,
    required this.status,
    required this.rewardClaimed,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
  });
}

class ReferralReward {
  final int id;
  final String name;
  final String description;
  final String rewardType;
  final double rewardValue;
  final String targetAction;
  final bool isActive;

  ReferralReward({
    required this.id,
    required this.name,
    required this.description,
    required this.rewardType,
    required this.rewardValue,
    required this.targetAction,
    required this.isActive,
  });
}