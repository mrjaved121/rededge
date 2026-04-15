import 'package:flutter/material.dart';

class SurgePricingWidget extends StatelessWidget {
  final double surgeMultiplier;
  final String surgeReason;
  final String zoneName;
  final bool isDiscount;

  const SurgePricingWidget({
    Key? key,
    required this.surgeMultiplier,
    required this.surgeReason,
    required this.zoneName,
    this.isDiscount = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine color based on surge type
    Color surgeColor = isDiscount ? Colors.green : Colors.orange;
    Color backgroundColor = isDiscount ? Colors.green[50]! : Colors.orange[50]!;
    
    // Determine icon based on surge type
    IconData surgeIcon = isDiscount ? Icons.discount : Icons.trending_up;
    
    // Format surge text
    String surgeText = isDiscount 
        ? '${(1 - surgeMultiplier).toStringAsFixed(2)}% OFF' 
        : '${surgeMultiplier.toStringAsFixed(1)}x Surge';

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: surgeColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                surgeIcon,
                color: surgeColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                isDiscount ? 'Discount Applied' : 'Surge Pricing',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: surgeColor,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: surgeColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  surgeText,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: surgeColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            surgeReason,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Zone: $zoneName',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            isDiscount 
                ? 'Enjoy lower fares in this area due to low demand' 
                : 'Fares are higher due to increased demand in this area',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}