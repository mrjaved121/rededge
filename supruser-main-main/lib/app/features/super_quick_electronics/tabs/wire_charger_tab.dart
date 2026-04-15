import 'package:flutter/material.dart';
import 'package:suprapp/app/features/super_quick_electronics/product_detail_Screen.dart';

class WiresAndChargersTab extends StatefulWidget {
  const WiresAndChargersTab({super.key});

  @override
  State<WiresAndChargersTab> createState() => _WiresAndChargersTabState();
}

class _WiresAndChargersTabState extends State<WiresAndChargersTab> {
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Expanded(
        child: SingleChildScrollView(
          child: Column(children: [_buildAccessoriesGrid()]),
        ),
      ),
    );
  }

  Widget _buildAccessoriesGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildGridProductCard(
            image: 'assets/cable.png',
            title: 'Blekin Gold Plated High',
            subtitle: 'Speed Hdmi Cable Wit...',
            originalPrice: 'AED 5,117.80',
            discountedPrice: 'AED 3,787.20',
            currencyChanged: true,
          ),
        ],
      ),
    );
  }

  Widget _buildGridProductCard({
    required String image,
    required String title,
    required String subtitle,
    required String discountedPrice,
    String? originalPrice,
    int? discountPercent,
    bool currencyChanged = false,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              productImage: image,
              productName: title,
            //  productDescription: subtitle,
              price: discountedPrice,
              originalPrice: originalPrice,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Hero(
                  // Use the image path as the tag since it's unique
                  tag: image,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(child: Image.asset(image, height: 110)),
                  ),
                ),
                if (discountPercent != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '-$discountPercent%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => print('Add to cart tapped for $title'),
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: const Center(child: Icon(Icons.add, size: 20)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              if (originalPrice != null) ...[
                Text(
                  originalPrice,
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey.shade600,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(width: 4),
              ],
              Text(
                discountedPrice,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Container(
            height: 23,
            width: 120,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Color(0xff066316),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Supr + INR 3,787.20',
                  style: TextStyle(fontSize: 10, color: Color(0xff00FF2D)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
