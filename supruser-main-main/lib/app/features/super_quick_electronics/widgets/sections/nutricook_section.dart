import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';
import '../../controller/electronics_controller.dart';
import '../product_card.dart';

class NutricookSection extends StatelessWidget {
  const NutricookSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ElectronicsController>();

    return Column(
      children: [
        // Banner
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(context, 4.3),
          ),
          height: ResponsiveUtils.hp(context, 17.2),
          decoration: BoxDecoration(
            color: const Color(0xFFF89123),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(ResponsiveUtils.wp(context, 4.8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'nutricook',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ResponsiveUtils.sp(context, 18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Make every bite better',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ResponsiveUtils.sp(context, 10),
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.hp(context, 0.75)),
                      Text(
                        'Cook smarter\nand healthier',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ResponsiveUtils.sp(context, 15),
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/images/airfresher.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ResponsiveUtils.hp(context, 2)),
        // Products
        SizedBox(
          height: ResponsiveUtils.getCardHeight(context, baseHeight: 220),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(context, 4.3),
            ),
            itemCount: controller.nutricookProducts.length,
            itemBuilder: (context, index) {
              final product = controller.nutricookProducts[index];
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