import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/features/all_services/all_services.dart';
import 'package:suprapp/app/features/all_services/coming_soon_page.dart';
import 'package:suprapp/app/features/super_quick_electronics/pages/quickelec_main_screen.dart';
import 'package:suprapp/app/routes/go_router.dart';
import '../../home_services/pages/homepage.dart';

class CategoriesGridview extends StatelessWidget {
  const CategoriesGridview({super.key, required this.items});

  final List<Map<String, String>> items;

  // Filter out 'All Services' item
  List<Map<String, String>> get _filteredItems =>
      items.where((item) => item['name'] != 'All Services').toList();

  void _handleNavigation(BuildContext context, String categoryName) {
    switch (categoryName) {
      case 'Rides':
        context.pushNamed(AppRoute.rideHome);
        break;
      case 'Electronics':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const QuickElectronicsScreen()));
        break;
      case 'Food':
        context.pushNamed(AppRoute.foodPage);
        break;
      case 'DineOut':
        context.pushNamed(AppRoute.dineOutPage);
        break;
      case 'Groceries':
        context.pushNamed(AppRoute.groceryHomeScreen);
        break;
      case 'Shops':
        context.pushNamed(AppRoute.shopScreen);
        break;
      case 'Send Money':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ComingSoonPage()));
        break;
      case 'Home Services':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeServicesPage()));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No screen defined for $categoryName')),
        );
    }
  }

  Widget _buildCategoryItem(
      BuildContext context,
      Map<String, String> item,
      double tileWidth,
      double tileHeight,
      ) {
    final name = item['name']!;
    final imageUrl = item['pictureUrl']!;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    // 🔹 check if file is svg
    final bool isSvg = imageUrl.toLowerCase().endsWith('.svg');

    return InkWell(
      onTap: () => _handleNavigation(context, name),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: tileWidth,
        height: tileHeight,
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 4 : 6,
          vertical: isSmallScreen ? 6 : 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 3 : 5),
                child: isSvg
                    ? SvgPicture.asset(
                  imageUrl,
                  fit: BoxFit.contain,
                )
                    : Image.asset(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Title
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 8.5 : 9.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = _filteredItems;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive calculations
    final isSmallScreen = screenWidth < 360;
    final horizontalPadding = screenWidth * 0.04; // 4% of screen width
    const numberOfColumns = 4.2; // Shows 4 full + partial 5th column
    const columnSpacing = 10.0;

    // Calculate available width
    final totalHorizontalPadding = horizontalPadding * 2;
    final totalSpacing = columnSpacing * (numberOfColumns - 1);
    final availableWidth = screenWidth - totalHorizontalPadding - totalSpacing;
    final columnWidth = availableWidth / numberOfColumns;

    // Tile dimensions with proper aspect ratio
    final tileWidth = columnWidth;
    final tileHeight = isSmallScreen ? 99.0 : 106.0;
    final rowSpacing = isSmallScreen ? 10.0 : 12.0;

    // Total height calculation
    final totalHeight = (tileHeight * 2) + rowSpacing;

    return Container(
      height: totalHeight,
      margin: const EdgeInsets.only(top: 8, bottom: 12),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: (filteredItems.length / 2).ceil(),
        itemBuilder: (context, columnIndex) {
          final topItemIndex = columnIndex * 2;
          final bottomItemIndex = topItemIndex + 1;

          return Container(
            width: tileWidth,
            margin: const EdgeInsets.only(right: columnSpacing),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Top tile
                if (topItemIndex < filteredItems.length)
                  _buildCategoryItem(
                    context,
                    filteredItems[topItemIndex],
                    tileWidth,
                    tileHeight,
                  ),

                SizedBox(height: rowSpacing),

                // Bottom tile
                if (bottomItemIndex < filteredItems.length)
                  _buildCategoryItem(
                    context,
                    filteredItems[bottomItemIndex],
                    tileWidth,
                    tileHeight,
                  )
                else
                  const SizedBox(), // Placeholder to maintain alignment
              ],
            ),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:suprapp/app/core/constants/app_colors.dart';
// import 'package:suprapp/app/features/all_services/all_services.dart';
// import 'package:suprapp/app/features/all_services/coming_soon_page.dart';
// import 'package:suprapp/app/features/super_quick_electronics/pages/quickelec_main_screen.dart';
// import 'package:suprapp/app/routes/go_router.dart';
//
// import '../../home_services/pages/homepage.dart';
//
// class CategoriesGridview extends StatelessWidget {
//   const CategoriesGridview({super.key, required this.items});
//
//   final List<Map<String, String>> items;
//
//   // Filter out 'All Services' item
//   List<Map<String, String>> get _filteredItems =>
//       items.where((item) => item['name'] != 'All Services').toList();
//
//   void _handleNavigation(BuildContext context, String categoryName) {
//     switch (categoryName) {
//       case 'Rides':
//         context.pushNamed(AppRoute.rideHome);
//         break;
//       case 'Electronics':
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => QuickElectronicsScreen()));
//         break;
//       case 'Food':
//         context.pushNamed(AppRoute.foodPage);
//         break;
//       case 'DineOut':
//         context.pushNamed(AppRoute.dineOutPage);
//         break;
//       case 'Groceries':
//         context.pushNamed(AppRoute.groceryHomeScreen);
//         break;
//       case 'Shops':
//         context.pushNamed(AppRoute.shopScreen);
//         break;
//       case 'Send Money':
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => ComingSoonPage()));
//         break;
//       case 'Home Services':
//         Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => HomeServicesPage()));
//         break;
//       default:
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('No screen defined for $categoryName')),
//         );
//     }
//   }
//
//   Widget _buildCategoryItem(
//       BuildContext context,
//       Map<String, String> item,
//       double tileWidth,
//       double tileHeight,
//       ) {
//     final name = item['name']!;
//     final imageUrl = item['pictureUrl']!;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isSmallScreen = screenWidth < 360;
//
//     return InkWell(
//       onTap: () => _handleNavigation(context, name),
//       borderRadius: BorderRadius.circular(8),
//       child: Container(
//         width: tileWidth,
//         height: tileHeight,
//         decoration: BoxDecoration(
//           color: AppColors.lightGrey,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.03),
//               blurRadius: 2,
//               offset: const Offset(0, 1),
//             ),
//           ],
//         ),
//         padding: EdgeInsets.symmetric(
//           horizontal: isSmallScreen ? 4 : 6,
//           vertical: isSmallScreen ? 6 : 8,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               flex: 6,
//               child: Padding(
//                 padding: EdgeInsets.all(isSmallScreen ? 3 : 5),
//                 child: Image.asset(
//                   imageUrl,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//
//             // Title
//             Expanded(
//               flex: 3,
//               child: Center(
//                 child: Text(
//                   name,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: isSmallScreen ? 8.5 : 9.5,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                     height: 1.2,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final filteredItems = _filteredItems;
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     // Responsive calculations
//     final isSmallScreen = screenWidth < 360;
//     final horizontalPadding = screenWidth * 0.04; // 4% of screen width
//     const numberOfColumns = 4.2; // Shows 4 full + partial 5th column
//     const columnSpacing = 10.0;
//
//     // Calculate available width
//     final totalHorizontalPadding = horizontalPadding * 2;
//     final totalSpacing = columnSpacing * (numberOfColumns - 1);
//     final availableWidth = screenWidth - totalHorizontalPadding - totalSpacing;
//     final columnWidth = availableWidth / numberOfColumns;
//
//     // Tile dimensions with proper aspect ratio
//     final tileWidth = columnWidth;
//     final tileHeight = isSmallScreen ? 99.0 : 106.0;
//     final rowSpacing = isSmallScreen ? 10.0 : 12.0;
//
//     // Total height calculation
//     final totalHeight = (tileHeight * 2) + rowSpacing;
//
//     return Container(
//       height: totalHeight,
//       margin: EdgeInsets.only(top: 8, bottom: 12),
//       child: ListView.builder(
//         padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         itemCount: (filteredItems.length / 2).ceil(),
//         itemBuilder: (context, columnIndex) {
//           final topItemIndex = columnIndex * 2;
//           final bottomItemIndex = topItemIndex + 1;
//
//           return Container(
//             width: tileWidth,
//             margin: const EdgeInsets.only(right: columnSpacing),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 // Top tile
//                 if (topItemIndex < filteredItems.length)
//                   _buildCategoryItem(
//                     context,
//                     filteredItems[topItemIndex],
//                     tileWidth,
//                     tileHeight,
//                   ),
//
//                 SizedBox(height: rowSpacing),
//
//                 // Bottom tile
//                 if (bottomItemIndex < filteredItems.length)
//                   _buildCategoryItem(
//                     context,
//                     filteredItems[bottomItemIndex],
//                     tileWidth,
//                     tileHeight,
//                   )
//                 else
//                 // Placeholder to maintain alignment
//                   SizedBox(),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }