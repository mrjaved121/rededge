import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/features/home/widgets/categories_gridview.dart';
import 'package:suprapp/app/features/home/widgets/home_header.dart';
import 'package:suprapp/app/features/home/widgets/home_product_categories.dart';
import 'package:suprapp/app/features/home/widgets/suggestions_tiles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    // 🔹 Yahan dono — SVG aur normal images ka mix hai
    final List<Map<String, String>> items = [
      {'name': 'Rides', 'pictureUrl': AppImages.rides},
      {'name': 'Hala Taxi', 'pictureUrl': AppImages.car1},
      {'name': 'Food', 'pictureUrl': AppImages.food},
      {'name': 'DineOut', 'pictureUrl': AppImages.dineout},
      {'name': 'Groceries', 'pictureUrl': AppImages.groceries},
      {'name': 'Shops', 'pictureUrl': AppImages.shops},
      {'name': 'Send Money', 'pictureUrl': AppImages.sendmoney},
      {'name': 'Electronics', 'pictureUrl': AppImages.electronics},
      {'name': 'Home Services', 'pictureUrl': AppImages.allservices},
    ];

    final List<Map<String, String>> suggestionsItems = [
      {'imagePath': AppImages.creamlastbanner, 'title': ''},
      {'imagePath': AppImages.creamlastbanner, 'title': ''},
      {'imagePath': AppImages.creamlastbanner, 'title': ''},
      {'imagePath': AppImages.creamlastbanner, 'title': ''},
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Header with Pay, Logo, Menu and City Selection
              const HomeHeader(),

              // Categories Grid (SVG + normal)
              CategoriesGridview(items: items),

              // Product Categories
              HomeProductCategories(),

              // Suggestions Section
              SuggestionTile(
                suggestionsItems: suggestionsItems,
              ),

              // Bottom spacing
              SizedBox(height: isSmallScreen ? 16 : 20),
            ],
          ),
        ),
      ),
    );
  }
}

class AppIcons {
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:suprapp/app/core/constants/app_images.dart';
// import 'package:suprapp/app/features/home/widgets/categories_gridview.dart';
// import 'package:suprapp/app/features/home/widgets/home_header.dart';
// import 'package:suprapp/app/features/home/widgets/home_product_categories.dart';
// import 'package:suprapp/app/features/home/widgets/suggestions_tiles.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isSmallScreen = screenWidth < 360;
//
//     final List<Map<String, String>> items = [
//       {'name': 'Rides', 'pictureUrl': AppImages.rides},
//       {'name': 'Box', 'pictureUrl': AppImages.box},
//       {'name': 'Food', 'pictureUrl': AppImages.food},
//       {'name': 'DineOut', 'pictureUrl': AppImages.dineout},
//       {'name': 'Groceries', 'pictureUrl': AppImages.groceries},
//       {'name': 'Shops', 'pictureUrl': AppImages.shops},
//       {'name': 'Send Money', 'pictureUrl': AppImages.sendmoney},
//       {'name': 'Electronics', 'pictureUrl': AppImages.electronics},
//       {'name': 'Home Services', 'pictureUrl': AppImages.allservices},
//
//     ];
//
//     final List<Map<String, String>> suggestionsItems = [
//       {'imagePath': AppImages.creamlastbanner, 'title': ''},
//       {'imagePath': AppImages.creamlastbanner, 'title': ''},
//       {'imagePath': AppImages.creamlastbanner, 'title': ''},
//       {'imagePath': AppImages.creamlastbanner, 'title': ''},
//     ];
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               // Header with Pay, Logo, Menu and City Selection
//               HomeHeader(),
//
//               // Categories Grid
//               CategoriesGridview(items: items),
//
//               // Product Categories
//               HomeProductCategories(),
//
//               // Suggestions Section
//               SuggestionTile(
//                 suggestionsItems: suggestionsItems,
//               ),
//
//               // Bottom spacing
//               SizedBox(height: isSmallScreen ? 16 : 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }