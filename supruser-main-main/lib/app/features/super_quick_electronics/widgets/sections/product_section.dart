import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';
import '../../controller/electronics_controller.dart';
import '../../electronic_tabs_screen.dart';
import '../../models/product_model.dart';
import '../section_header.dart';
import '../product_card.dart';

class ProductSection extends StatelessWidget {
  final String title;
  final List<ProductModel> products;
  final double? customHeight;

  const ProductSection({
    super.key,
    required this.title,
    required this.products,
    this.customHeight,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ElectronicsController>();
    final height = customHeight ?? 220;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: title,
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
          height: ResponsiveUtils.getCardHeight(context, baseHeight: height),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(context, 4.3),
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
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