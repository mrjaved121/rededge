// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:suprapp/app/features/groceries/models/item_model.dart';
// import 'package:suprapp/app/features/groceries/widgets/catagory_product_page.dart';

// class CategoryItem {
//   final String title;
//   final String imageUrl;
//   final List<ProductItem> products;

//   const CategoryItem({
//     required this.title,
//     required this.imageUrl,
//     required this.products,
//   });
// }

// class ShopByCategoryGrid extends StatelessWidget {
//   const ShopByCategoryGrid({
//     super.key,
//     required this.categories,
//   });

//   final List<CategoryItem> categories;

//   static const _tileBg = Color(0xFFFAF6EF);

//   @override
//   Widget build(BuildContext context) {
//     const double tileHeight = 100;
//     const double spacing = 10;

//     return Padding(
//       padding:
//           const EdgeInsets.symmetric(vertical: 10), // Add top & bottom padding
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics:
//             NeverScrollableScrollPhysics(), // Prevent GridView from scrolling
//         padding: const EdgeInsets.symmetric(horizontal: 0),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 4, // 4 items per row
//           mainAxisSpacing: spacing,
//           crossAxisSpacing: spacing,
//           childAspectRatio: 0.8, // Adjust based on your image/text layout
//         ),
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           final item = categories[index];
//           return InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => CategoryProductsScreen(
//                     categoryTitle: item.title,
//                     products: item.products,
//                   ),
//                 ),
//               );
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 color: _tileBg,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 50,
//                     width: double.infinity,
//                     child: CachedNetworkImage(
//                       imageUrl: item.imageUrl,
//                       fit: BoxFit.contain,
//                       placeholder: (context, url) => Shimmer.fromColors(
//                         baseColor: Colors.grey.shade300,
//                         highlightColor: Colors.grey.shade100,
//                         child: Container(
//                           width: double.infinity,
//                           height: 40,
//                           color: Colors.grey[300],
//                         ),
//                       ),
//                       errorWidget: (context, url, error) =>
//                           const Icon(Icons.error),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     item.title,
//                     textAlign: TextAlign.center,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:suprapp/app/features/groceries/models/item_model.dart';
import 'package:suprapp/app/features/groceries/widgets/catagory_product_page.dart';

class CategoryItem {
  final String title;
  final String imageUrl;
  final List<ProductItem> products;

  const CategoryItem({
    required this.title,
    required this.imageUrl,
    required this.products,
  });
}

class ShopByCategoryGrid extends StatelessWidget {
  const ShopByCategoryGrid({
    super.key,
    required this.categories,
  });

  final List<CategoryItem> categories;

  static const _tileBg = Color(0xFFFAF6EF);

  @override
  Widget build(BuildContext context) {
    const double spacing = 10;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          childAspectRatio: 0.7, // Adjusted for taller tiles
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item = categories[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryProductsScreen(
                    categoryTitle: item.title,
                    products: item.products,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: _tileBg,
                borderRadius: BorderRadius.circular(10),
              ),
              // Slightly more padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50, // Increased height for image
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          color: Colors.grey[300],
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
