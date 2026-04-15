import 'package:flutter/material.dart';

class GamificationWidget extends StatelessWidget {
  final List<DriverIncentive> dailyIncentives;
  final List<DriverIncentive> weeklyIncentives;
  final List<DriverIncentive> milestoneIncentives;
  final List<DriverProgress> progressList;
  final List<DriverAchievement> achievements;
  final Map<String, dynamic> driverStats;

  const GamificationWidget({
    Key? key,
    this.dailyIncentives = const [],
    this.weeklyIncentives = const [],
    this.milestoneIncentives = const [],
    this.progressList = const [],
    this.achievements = const [],
    this.driverStats = const {},
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
                Icons.emoji_events,
                color: Colors.amber,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'Driver Challenges',
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
          _buildStatsSummary(context),
          const SizedBox(height: 20),
          if (dailyIncentives.isNotEmpty)
            _buildIncentiveSection(
              context,
              title: 'Daily Challenges',
              incentives: dailyIncentives,
              icon: Icons.today,
              color: Colors.blue,
            ),
          if (weeklyIncentives.isNotEmpty)
            _buildIncentiveSection(
              context,
              title: 'Weekly Challenges',
              incentives: weeklyIncentives,
              icon: Icons.calendar_today,
              color: Colors.green,
            ),
          if (milestoneIncentives.isNotEmpty)
            _buildIncentiveSection(
              context,
              title: 'Milestone Challenges',
              incentives: milestoneIncentives,
              icon: Icons.flag,
              color: Colors.purple,
            ),
          if (achievements.isNotEmpty)
            _buildAchievementsSection(context),
        ],
      ),
    );
  }

  Widget _buildStatsSummary(BuildContext context) {
    final totalRides = driverStats['total_rides'] as int? ?? 0;
    final achievementsCount = driverStats['achievements'] as int? ?? 0;
    final averageRating = driverStats['average_rating'] as double? ?? 0.0;

    return Row(
      children: [
        _buildStatCard(
          context,
          icon: Icons.local_taxi,
          value: '$totalRides',
          label: 'Total Rides',
          color: Colors.blue,
        ),
        const SizedBox(width: 16),
        _buildStatCard(
          context,
          icon: Icons.emoji_events,
          value: '$achievementsCount',
          label: 'Achievements',
          color: Colors.amber,
        ),
        const SizedBox(width: 16),
        _buildStatCard(
          context,
          icon: Icons.star,
          value: averageRating.toStringAsFixed(1),
          label: 'Rating',
          color: Colors.orange,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
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

  Widget _buildIncentiveSection(
    BuildContext context, {
    required String title,
    required List<DriverIncentive> incentives,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...incentives.map((incentive) => _buildIncentiveCard(context, incentive)).toList(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildIncentiveCard(BuildContext context, DriverIncentive incentive) {
    // Find progress for this incentive
    final progress = progressList.firstWhere(
      (p) => p.incentiveId == incentive.id,
      orElse: () => DriverProgress(
        id: 0,
        driverId: 0,
        incentiveId: incentive.id,
        currentValue: 0,
        isCompleted: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    final progressPercent = incentive.targetValue > 0
        ? (progress.currentValue / incentive.targetValue).clamp(0.0, 1.0)
        : 0.0;

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
              Expanded(
                child: Text(
                  incentive.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (progress.isCompleted)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'COMPLETED',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            incentive.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progressPercent,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              progress.isCompleted ? Colors.green : Colors.blue,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${progress.currentValue}/${incentive.targetValue}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                _formatReward(incentive.rewardType, incentive.rewardValue),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.emoji_events, color: Colors.amber, size: 20),
            SizedBox(width: 8),
            Text(
              'Your Achievements',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: achievements.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final achievement = achievements[index];
              return _buildAchievementBadge(context, achievement);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementBadge(BuildContext context, DriverAchievement achievement) {
    return Container(
      width: 70,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.emoji_events,
            color: Colors.amber,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            achievement.name,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String _formatReward(String rewardType, double rewardValue) {
    switch (rewardType.toLowerCase()) {
      case 'points':
        return '$rewardValue pts';
      case 'cash':
        return '\$${rewardValue.toStringAsFixed(2)}';
      case 'bonus':
        return '$rewardValue bonus';
      default:
        return '$rewardValue';
    }
  }
}

class DriverIncentive {
  final int id;
  final String name;
  final String description;
  final String type;
  final int targetValue;
  final String rewardType;
  final double rewardValue;

  DriverIncentive({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.targetValue,
    required this.rewardType,
    required this.rewardValue,
  });
}

class DriverProgress {
  final int id;
  final int driverId;
  final int incentiveId;
  final int currentValue;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  DriverProgress({
    required this.id,
    required this.driverId,
    required this.incentiveId,
    required this.currentValue,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });
}

class DriverAchievement {
  final int id;
  final int driverId;
  final String name;
  final String description;
  final int pointsAwarded;
  final DateTime unlockedAt;

  DriverAchievement({
    required this.id,
    required this.driverId,
    required this.name,
    required this.description,
    required this.pointsAwarded,
    required this.unlockedAt,
  });
}