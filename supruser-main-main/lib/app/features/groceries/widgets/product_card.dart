import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/groceries/controllers/product_quantity_provider.dart';

class ProductCard extends StatelessWidget {
  final String id;
  final String title;
  final String price;
  final String discount;
  final String imageUrl;
  final String? oldPrice;
  final bool showOldPrice;
  final VoidCallback? onTap;
  final Widget? addWidget;

  const ProductCard({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.discount,
    required this.imageUrl,
    this.oldPrice,
    this.showOldPrice = false,
    this.onTap,
    this.addWidget,
  });

  @override
  Widget build(BuildContext context) {
    final quantity = context.watch<QuantityProvider>().getQuantity(id);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Product Image with placeholder shimmer
                Container(
                  width: 170,
                  height: 110,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF6EF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(color: Colors.grey.shade300),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),

                // Discount badge
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      discount,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Quantity controls or Add button with smooth animation
                addWidget ?? SizedBox(),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF179C52),
              ),
            ),
            if (showOldPrice && oldPrice != null)
              Text(
                oldPrice!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black38,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
