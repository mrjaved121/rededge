import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';

class TopOffersSection extends StatelessWidget {
  const TopOffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Offers',
                  style: textTheme(
                    context,
                  ).headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff0A0C0B)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildOfferCard(
                  bgColor: const Color(0xFFFFF3CD),
                  title: 'Up to 30% offer',
                  subtitle: 'Enjoy our big offer',
                  imagePath: 'assets/images/vegetables.png',
                  buttonColor: const Color(0xFF007E33),
                  textColor: Colors.black87,
                  buttonTextColor: Colors.white,
                ),
                const SizedBox(width: 16),
                _buildOfferCard(
                  bgColor: const Color(0xFFFFF3CD),
                  title: 'Get Same day Deliver',
                  subtitle: 'On orders above \$20',
                  imagePath: 'assets/images/cleaner.png',
                  buttonColor: const Color(0xFF007E33),
                  textColor: Colors.black,
                  buttonTextColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard({
    required Color bgColor,
    required String title,
    required String subtitle,
    required String imagePath,
    required Color buttonColor,
    required Color textColor,
    required Color buttonTextColor,
  }) {
    return Container(
      width: 280,
      height: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Text and Button
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: textColor.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Shop Now',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: buttonTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Image
          Expanded(
            flex: 2,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
