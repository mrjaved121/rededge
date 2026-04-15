import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';
import '../../controller/electronics_controller.dart';
import '../../electronic_tabs_screen.dart';
import '../section_header.dart';
import '../product_card.dart';


class AppleLatestSection extends StatelessWidget {
  const AppleLatestSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ElectronicsController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Apple's latest releases",
          onSeeAllTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ElectronicTabScreen(),
              ),
            );
          },
        ),
        SizedBox(height: ResponsiveUtils.hp(context, 1.5)),
        SizedBox(
          height: ResponsiveUtils.getCardHeight(context, baseHeight: 220),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(context, 4.3),
            ),
            itemCount: controller.appleProducts.length,
            itemBuilder: (context, index) {
              final product = controller.appleProducts[index];
              return AppleProductCard(
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