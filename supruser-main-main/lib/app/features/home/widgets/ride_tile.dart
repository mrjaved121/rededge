import 'package:flutter/material.dart';

class RideTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String time;
  final String fare;
  final String status;
  final Color statusColor;
  final VoidCallback? onTap;
  final VoidCallback? onStatusTap;

  const RideTile({
    super.key,
    required this.imagePath,
    required this.title,
    required this.time,
    required this.fare,
    required this.status,
    required this.statusColor,
    this.onTap,
    this.onStatusTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      theme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  time,
                  style: theme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  fare,
                  style: theme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.timer_outlined,
                        size: 20, color: Colors.grey[700]),
                    TextButton(
                      onPressed: onStatusTap,
                      child: Text(
                        status,
                        style: theme.titleSmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward, size: 16),
        ],
      ),
    );
  }
}
