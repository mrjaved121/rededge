import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuprPlusPromoSection extends StatelessWidget {
  const SuprPlusPromoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Get with Supr +',
            style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold, color: const Color(0xff0A0C0B)),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _promoCard(
                context,
                bgColor: const Color(0xFFFFF3CD),
                title: RichText(
                  text: TextSpan(
                    style: textTheme.bodyMedium?.copyWith(color: Colors.black),
                    children: const [
                      TextSpan(text: 'Order '),
                      TextSpan(
                        text: 'INR 100+',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text:
                              '\nand be 1 of lucky winners\nof an iPhone 16.'),
                    ],
                  ),
                ),
                imagePath: 'assets/images/mobileee.PNG',
              ),
              const SizedBox(width: 12),
              _promoCard(
                context,
                bgColor: const Color(0xFFFFF3CD),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "We've got your back",
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '50% off',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                imagePath: 'assets/images/pizzaheart.png',
              ),
            ],
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.black, width: 1),
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: const Color(0xFFFFF3CD),
            ),
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ComingSoonPage()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'View all Supr Plus benefits',
                  style: GoogleFonts.poppins(
                    color: const Color(0xff000000),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Color(0xff000000),
                  size: 30,
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _promoCard(
    BuildContext context, {
    required Color bgColor,
    required Widget title,
    required String imagePath,
  }) {
    return Expanded(
      child: Container(
        height: 170,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Expanded(flex: 3, child: title),
            const SizedBox(width: 8),
            Expanded(
              flex: 3, // Increased flex value for image
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                width: 100, // Set width directly to increase size
                height: 100, // Set height directly to increase size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
