import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/electronics_controller.dart';
import '../../electronic_tabs_screen.dart';
import '../section_header.dart';
import '../product_card.dart';


class BestsellingSection extends StatelessWidget {
  const BestsellingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ElectronicsController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Bestselling mobiles for you',
          onSeeAllTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ElectronicTabScreen(),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.bestsellingProducts.length,
            itemBuilder: (context, index) {
              final product = controller.bestsellingProducts[index];
              return ProductCard(
                item: product,
                onAddToCart: () => controller.addToCart(product),
              );
            },
          ),
        ),
      ],
    );
  }
}