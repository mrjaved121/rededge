import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';

class TopPickItem extends StatelessWidget {
  final String image;
  final String discountText;
  final String title;
  final int oldPrice;
  final int newPrice;

  const TopPickItem({
    super.key,
    required this.image,
    required this.discountText,
    required this.title,
    required this.oldPrice,
    required this.newPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 165,
        height: 240,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),

            // Discount Badge
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: colorScheme(context).primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  discountText,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Plus Button
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.add,
                  size: 16,
                  color: Colors.green,
                ),
              ),
            ),

            // Details
            Positioned(
              top: 190,
              bottom: 0,
              left: 8,
              right: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme(context).surface),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '₹$oldPrice',
                        style: textTheme(context).bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme(context).surface),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '₹$newPrice',
                        style: textTheme(context).bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme(context).surface),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 220,
              right: 8,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: colorScheme(context).surface,
                  border: Border.all(
                      color: colorScheme(context).primary, width: 1.5),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 3,
                    backgroundColor: colorScheme(context).primary,
                  ),
                ),
              ),
            ),

            // Veg Icon
          ],
        ),
      ),
    );
  }
}
