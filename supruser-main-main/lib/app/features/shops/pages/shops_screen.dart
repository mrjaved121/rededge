import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/home/widgets/top_sheet.dart';
import 'package:suprapp/app/features/shops/models/all_shops_model.dart';
import 'package:suprapp/app/features/shops/models/shop_spec_model.dart';
import 'package:suprapp/app/features/shops/models/specific_shop_model.dart';
import 'package:suprapp/app/features/shops/pages/cateogory_shops.dart';
import 'package:suprapp/app/features/shops/services/products_page.dart';
import 'package:suprapp/app/features/shops/services/shops_service.dart';

class ShopsScreen extends StatefulWidget {
  const ShopsScreen({super.key});

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  late Future<List<AllShopsModel>> _shopsFuture;
  late Future<List<AllShopsModel>> _recommendedShopsFuture;
  List<String> addressList = ["My apartment", "My Villa", "My Home"];
  String selectedAddress = "My apartment";

  // Category items matching the screenshot
  final List<Map<String, String>> categoryItems = [
    {"image": AppImages.pharmacy, "label": "Pharmacy"},
    {"image": AppImages.giftsFlowers, "label": "Gifts &\nFlowers"},
    {"image": AppImages.specialityGrocery, "label": "Speciality"},
    {"image": AppImages.coffeeSweets, "label": "Coffee &\nSweets"},
    {"image": AppImages.superMarket, "label": "Super\nmarket"},
    {"image": AppImages.butchery, "label": "Butchery &\nSeafood"},
    {"image": AppImages.petShops, "label": "Pet\nSupplies"},
    {"image": AppImages.electronics, "label": "Health &\nBeauty"},
    // Add more categories if needed
    {"image": AppImages.pharmacy, "label": "Electronics"},
    {"image": AppImages.giftsFlowers, "label": "Home\nDecor"},
    {"image": AppImages.coffeeSweets, "label": "Coffee &\nSweets"},
    {"image": AppImages.superMarket, "label": "Super\nmarket"},
    {"image": AppImages.butchery, "label": "Butchery &\nSeafood"},
    {"image": AppImages.petShops, "label": "Pet\nSupplies"},
    {"image": AppImages.electronics, "label": "Health &\nBeauty"},
  ];

  @override
  void initState() {
    super.initState();
    _shopsFuture = ShopService().getAllShops();
    _recommendedShopsFuture = ShopService().getRecommendedShops();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16.0),
          child: InkWell(
            onTap: () => context.pop(),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFE0E0E0)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 8),
            Text(
              "Shops",
              style: TextStyle(
                color: Color(0xFF0D5F4E),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 16.0),
            child: InkWell(
              onTap: () {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: 'TopSheet',
                  transitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (_, __, ___) => const SizedBox.shrink(),
                  transitionBuilder: (_, animation, __, ___) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: const Align(
                        alignment: Alignment.topCenter,
                        child: TopSheetWidget(),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Color(0xFF0D5F4E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Deliver to section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Deliver to ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedAddress,
                    items: addressList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedAddress = newValue!;
                      });
                    },
                    icon: Icon(Icons.keyboard_arrow_down, size: 20),
                  ),
                ),
              ],
            ),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFE0E0E0)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search all shops and products",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF9E9E9E),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Icon(Icons.search, color: Colors.black54, size: 22),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 12),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Halloween Banner
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 105,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF4A1A6B), Color(0xFF6B2A8B)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Stack(
                          clipBehavior: Clip.hardEdge,
                          children: [
                            Positioned(
                              left: 15,
                              top: 22,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Boo-tiful",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "treats await.",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 15,
                              bottom: 8,
                              child: Container(
                                height: 75,
                                width: 75,
                                child: Image.asset(
                                  AppImages.mainBanner,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      SizedBox(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // Fixed Category Grid - Horizontal scroll with proper layout
                  Container(
                    height: 180,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: (categoryItems.length / 2).ceil(),
                      itemBuilder: (context, columnIndex) {
                        final startIndex = columnIndex * 2;
                        final endIndex = startIndex + 2;

                        return Container(
                          width: 85,
                          margin: EdgeInsets.only(right: 12),
                          child: Column(
                            children: [
                              // First item in column
                              if (startIndex < categoryItems.length)
                                Expanded(
                                  child: _buildCategoryItem(categoryItems[startIndex]),
                                ),
                              SizedBox(height: 12),
                              // Second item in column
                              if (endIndex - 1 < categoryItems.length)
                                Expanded(
                                  child: _buildCategoryItem(categoryItems[endIndex - 1]),
                                ),
                              if (endIndex - 1 >= categoryItems.length)
                                Expanded(child: SizedBox()),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 15),



                  // Promotional Banners Row
                  Container(
                    height: 70,
                    child: PageView(
                      children: [
                        // First Banner
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              color: Color(0xFFFDE8E8),
                              child: Image.asset(
                                AppImages.shampoBanner,
                                fit: BoxFit.fill, // This will fill the container
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: Color(0xFFFDE8E8),
                                  child: Center(
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.grey[400],
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Second Banner
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFFB8F3D8), Color(0xFF7AE5B8)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Image.asset(
                                AppImages.mainBanner,
                                fit: BoxFit.fill, // This will fill the container
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Color(0xFFB8F3D8), Color(0xFF7AE5B8)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.white.withOpacity(0.7),
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Third Banner
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              color: Color(0xFFFDE8E8),
                              child: Image.asset(
                                AppImages.shampoBanner,
                                fit: BoxFit.fill, // This will fill the container
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: Color(0xFFFDE8E8),
                                  child: Center(
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.grey[400],
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),// Promotional Cards
                  // Promotional Cards - Images only
                  SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildPromoImageCard(
                          color: Color(0xFFFDE8E8),
                          imageAsset: AppImages.cakeBanner,
                        ),
                        SizedBox(width: 9),
                        _buildPromoImageCard(
                          color: Color(0xFFB8F3E8),
                          imageAsset: AppImages.mainBanner,
                        ),
                        SizedBox(width: 9),
                        _buildPromoImageCard(
                          color: Color(0xFFFFE8D8),
                          imageAsset: AppImages.shampoBanner,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 18),

                  // Recommended Shops Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Recommended Shops",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  SizedBox(height: 12),

                  // Recommended Shops Grid
                  FutureBuilder<List<AllShopsModel>>(
                    future: _recommendedShopsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return _buildDefaultRecommendedShops();
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 0.9,
                            crossAxisSpacing: 9,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: snapshot.data!.length > 8 ? 8 : snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final shop = snapshot.data![index];
                            return _buildRecommendedShopItem(shop);
                          },
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 18),

                  // All Shops Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "All Shops",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  SizedBox(height: 12),

                  // All Shops List
                  /*
                  FutureBuilder<List<AllShopsModel>>(
                    future: _shopsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return _buildDefaultAllShops();
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: snapshot.data!.map((shop) {
                            return _buildShopListItem(shop);
                          }).toList(),
                        ),
                      );
                    },
                  ),
                  */

                  // Directly call the method to show dummy data instead
                  _buildDefaultAllShops(),


                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // New method for building category items
  Widget _buildCategoryItem(Map<String, String> item) {
    return InkWell(
      onTap: () {
        // Navigate to category
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 32,
              width: 32,
              child: Image.asset(
                item["image"]!,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.image, color: Colors.grey, size: 20),
              ),
            ),
            SizedBox(height: 6),
            Text(
              item["label"]!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                height: 1.1,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildPromoImageCard({
    required Color color,
    required String imageAsset,
  }) {
    return Container(
      width: 195,
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          imageAsset,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) => Container(
            color: color,
            child: Center(
              child: Icon(
                Icons.image,
                color: Colors.grey[400],
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendedShopItem(AllShopsModel shop) {
    return InkWell(
      onTap: () {
        print("Shop ID: ${shop.shopId}");
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: shop.shopImage.isNotEmpty
              ? CachedNetworkImage(
            imageUrl: shop.shopImage,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            errorWidget: (context, url, error) => Icon(Icons.store, size: 30),
          )
              : Icon(Icons.store, size: 30),
        ),
      ),
    );
  }

  Widget _buildDefaultRecommendedShops() {
    final List<String> recommendedLogos = [
      AppImages.recommendedOne,
      AppImages.recommendedTwo,
      AppImages.recommendedThree,
      AppImages.recommendedFour,
      AppImages.recommendedFive,
      AppImages.recommendedSix,
      AppImages.recommendedSeven,
      AppImages.recommendedEight,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.9,
          crossAxisSpacing: 9,
          mainAxisSpacing: 12,
        ),
        itemCount: recommendedLogos.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFE0E0E0)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  recommendedLogos[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.store, size: 30),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShopListItem(AllShopsModel shop) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          print("Shop ID: ${shop.shopId}");
        },
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFE0E0E0)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: shop.shopImage.isNotEmpty
                    ? CachedNetworkImage(
                  imageUrl: shop.shopImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.store),
                )
                    : Icon(Icons.store, size: 40),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shop.shopname,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Color(0xFF0D5F4E),
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "4.5 (1000+)",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "35 - 45 mins",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Color(0xFF0D5F4E),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.delivery_dining,
                              color: Colors.white,
                              size: 10,
                            ),
                            SizedBox(width: 2),
                            Text(
                              "+",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultAllShops() {
    final List<Map<String, dynamic>> defaultShops = [
      {
        "name": "Lana One Pharmacy",
        "logo": AppImages.allShopsOne,
        "rating": "4.4",
        "reviews": "1500+",
        "time": "35 - 45 mins",
        "discount": "Upto 80% off"
      },
      {
        "name": "Baladi Butchery",
        "logo": AppImages.allShopsTwo,
        "rating": "4.6",
        "reviews": "1000+",
        "time": "40 - 50 mins",
        "discount": ""
      },
      {
        "name": "Gift A Flowers",
        "logo": AppImages.allShopsThree,
        "rating": "4.3",
        "reviews": "1200+",
        "time": "35 - 45 mins",
        "discount": "50% Off"
      },
      {
        "name": "Buy Any Flowers",
        "logo": AppImages.allShopsFour,
        "rating": "4.3",
        "reviews": "1900+",
        "time": "35 - 45 mins",
        "discount": "50% Off"
      },
      {
        "name": "800 Pharma",
        "logo": AppImages.allShopsFive,
        "rating": "4.7",
        "reviews": "1500+",
        "time": "30 - 40 mins",
        "discount": "Upto 80% off"
      },
      {
        "name": "Acacia Community Pharmacy",
        "logo": AppImages.allShopsSix,
        "rating": "4.8",
        "reviews": "93",
        "time": "35 - 45 mins",
        "discount": "Up to 50%"
      },
      {
        "name": "Faith Acacia Pharmacy",
        "logo": AppImages.allShopsSeven,
        "rating": "4.4",
        "reviews": "112",
        "time": "30 - 40 mins",
        "discount": ""
      },
      {
        "name": "Green Valley Supermarket",
        "logo": AppImages.superMarket,
        "rating": "4.5",
        "reviews": "2000+",
        "time": "25 - 35 mins",
        "discount": "Free Delivery"
      },
      {
        "name": "Pet Paradise",
        "logo": AppImages.petShops,
        "rating": "4.9",
        "reviews": "850+",
        "time": "30 - 40 mins",
        "discount": "20% Off"
      },
      {
        "name": "Beauty & Wellness Hub",
        "logo": AppImages.electronics,
        "rating": "4.2",
        "reviews": "1100+",
        "time": "35 - 45 mins",
        "discount": "Buy 1 Get 1"
      },
    ];

    // Use Column instead of ListView.builder
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: defaultShops.map((shop) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: InkWell(
              onTap: () {},
              child: Row(
                children: [
                  // Shop Logo
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xFFE0E0E0)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        shop["logo"],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.store, size: 40),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  // Shop Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shop["name"],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Color(0xFF0D5F4E),
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${shop["rating"]} (${shop["reviews"]})",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              shop["time"],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                color: Color(0xFF0D5F4E),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delivery_dining,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "+",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (shop["discount"].isNotEmpty) ...[
                              SizedBox(width: 6),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                decoration: BoxDecoration(
                                  color: shop["discount"] == "Free Delivery"
                                      ? Color(0xFF4CAF50)
                                      : shop["discount"] == "Buy 1 Get 1"
                                      ? Color(0xFF9C27B0)
                                      : Color(0xFFE91E63),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  shop["discount"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:suprapp/app/core/constants/app_colors.dart';
// import 'package:suprapp/app/core/constants/app_images.dart';
// import 'package:suprapp/app/core/constants/global_variables.dart';
// import 'package:suprapp/app/features/home/widgets/top_sheet.dart';
// import 'package:suprapp/app/features/shops/models/all_shops_model.dart';
// import 'package:suprapp/app/features/shops/models/shop_spec_model.dart';
// import 'package:suprapp/app/features/shops/models/specific_shop_model.dart';
// import 'package:suprapp/app/features/shops/pages/cart_page.dart';
// import 'package:suprapp/app/features/shops/pages/cateogory_shops.dart';
// import 'package:suprapp/app/features/shops/services/products_page.dart';
// import 'package:suprapp/app/features/shops/services/shops_service.dart';
// import 'package:suprapp/app/shared/widgets/custom_back_button.dart';
//
// class ShopsScreen extends StatefulWidget {
//   const ShopsScreen({super.key});
//
//   @override
//   State<ShopsScreen> createState() => _ShopsScreenState();
// }
//
// class _ShopsScreenState extends State<ShopsScreen> {
//   late Future<List<AllShopsModel>> _shopsFuture;
//   late Future<List<AllShopsModel>> _recommendedShopsFuture;
//   late Future<List<SpecificShopModel>> _allshopsFuture;
//   List<String> addressList = ["villa 13", "villa 14", "villa 15"];
//   String selectedAddress = "villa 13";
//
//   @override
//   void initState() {
//     super.initState();
//     _shopsFuture = ShopService().getAllShops();
//     _recommendedShopsFuture = ShopService().getRecommendedShops();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           forceMaterialTransparency: true,
//           leading: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: InkWell(
//               onTap: () {
//                 context.pop();
//               },
//               child: Container(
//                 height: 30,
//                 width: 30,
//                 decoration: BoxDecoration(
//                     border: Border.all(color: AppColors.appGrey),
//                     borderRadius: BorderRadius.circular(7)),
//                 child: const Icon(
//                   Icons.arrow_back,
//                   color: AppColors.darkGrey,
//                   size: 20,
//                 ),
//               ),
//             ),
//           ),
//           centerTitle: true,
//           title: Text(
//             "Shops",
//             style: textTheme(context)
//                 .headlineLarge
//                 ?.copyWith(fontWeight: FontWeight.bold),
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: InkWell(
//                 onTap: () {
//                   showGeneralDialog(
//                     context: context,
//                     barrierDismissible: true,
//                     barrierLabel: 'TopSheet',
//                     transitionDuration: const Duration(milliseconds: 300),
//                     pageBuilder: (_, __, ___) => const SizedBox.shrink(),
//                     transitionBuilder: (_, animation, __, ___) {
//                       return SlideTransition(
//                         position: Tween<Offset>(
//                           begin: const Offset(0, -1),
//                           end: Offset.zero,
//                         ).animate(animation),
//                         child: const Align(
//                           alignment: Alignment.topCenter,
//                           child: TopSheetWidget(),
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 child: Container(
//                   height: 50,
//                   width: 40,
//                   decoration: BoxDecoration(
//                       color: colorScheme(context).primary,
//                       border: Border.all(color: AppColors.appGrey),
//                       borderRadius: BorderRadius.circular(7)),
//                   child: const Icon(
//                     Icons.menu,
//                     color: Color.fromARGB(255, 20, 188, 96),
//                     size: 15,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CustomBackButton(
//                       onPressed: () {
//                         context.pop(context);
//                       },
//                     ),
//                     Row(
//                       children: [
//                         Icon(Icons.location_on_outlined, size: 18),
//                         Text(
//                           "Deliver to ",
//                           style: textTheme(context)
//                               .bodySmall
//                               ?.copyWith(fontWeight: FontWeight.w400),
//                         ),
//                         DropdownButtonHideUnderline(
//                           child: DropdownButton<String>(
//                             value: selectedAddress,
//                             items: addressList.map((String value) {
//                               return DropdownMenuItem<String>(
//                                 value: value,
//                                 child: Text(
//                                   value,
//                                   style: textTheme(context).bodySmall?.copyWith(
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                 ),
//                               );
//                             }).toList(),
//                             onChanged: (newValue) {
//                               setState(() {
//                                 selectedAddress = newValue!;
//                               });
//                             },
//                             icon: Icon(Icons.keyboard_arrow_down_outlined,
//                                 size: 20),
//                             style: textTheme(context).bodySmall?.copyWith(
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.black,
//                                 ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (_) => CartPage(),
//                         ));
//                       },
//                       icon: Icon(Icons.shopping_cart_outlined),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 30.0,
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     hintText: "Search all shops and products",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(9.0),
//                       ),
//                       borderSide: BorderSide(
//                         color: Color(0xffBDBABA),
//                       ),
//                     ),
//                     hintStyle: textTheme(context).titleMedium?.copyWith(
//                           color: Color(0xff9C9C9C),
//                         ),
//                     suffixIcon: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: SvgPicture.asset(
//                         AppIcon.searchIcon,
//                       ),
//                     ),
//                     suffixIconConstraints: BoxConstraints(
//                       maxHeight: 16,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 FutureBuilder<List<AllShopsModel>>(
//                   future: _shopsFuture,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting)
//                       return Center(child: CircularProgressIndicator());
//                     if (snapshot.hasError)
//                       return Center(child: Text("Error fetching shops"));
//                     if (!snapshot.hasData || snapshot.data!.isEmpty)
//                       return Center(child: Text("No shops available"));
//
//                     final shopItems = snapshot.data!;
//
//                     return GridView.count(
//                       crossAxisCount: 4,
//                       crossAxisSpacing: 8,
//                       mainAxisSpacing: 10,
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       childAspectRatio: 0.9,
//                       children: shopItems.map((item) {
//                         return InkWell(
//                           onTap: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (context) => CateogoryShops(
//                                   categoryId: item.shopId,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: AppColors.stickerGrey,
//                               borderRadius: BorderRadius.circular(5.0),
//                             ),
//                             padding: EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 SizedBox(height: 5),
//                                 Flexible(
//                                   flex: 2,
//                                   child: SizedBox(
//                                     child: CachedNetworkImage(
//                                       imageUrl: item.shopImage,
//                                       fit: BoxFit.contain,
//                                       placeholder: (context, url) =>
//                                           const Center(
//                                               child:
//                                                   CircularProgressIndicator()),
//                                       errorWidget: (context, url, error) =>
//                                           const Icon(Icons.error),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 5.0),
//                                 Flexible(
//                                   flex: 1,
//                                   child: Text(
//                                     overflow: TextOverflow.ellipsis,
//                                     item.shopname,
//                                     textAlign: TextAlign.center,
//                                     style: textTheme(context)
//                                         .bodySmall
//                                         ?.copyWith(fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 SizedBox(
//                   height: 200,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: ClipRRect(
//                             borderRadius: BorderRadius.all(Radius.circular(
//                               30,
//                             )),
//                             child: Image.asset(
//                               AppImages.storeWideSale,
//                             )),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: ClipRRect(
//                             borderRadius: BorderRadius.all(Radius.circular(
//                               30,
//                             )),
//                             child: Image.asset(AppImages.grocerySale)),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 15.0),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "Recommended Shops",
//                       style: textTheme(context).headlineSmall?.copyWith(
//                             fontWeight: FontWeight.w600,
//                           ),
//                     ),
//                   ),
//                 ),
//                 FutureBuilder<List<AllShopsModel>>(
//                   future: _recommendedShopsFuture,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting)
//                       return Center(child: CircularProgressIndicator());
//
//                     if (snapshot.hasError)
//                       return Center(
//                           child: Text("Error loading recommended shops"));
//
//                     if (!snapshot.hasData || snapshot.data!.isEmpty)
//                       return Center(child: Text("No recommended shops"));
//
//                     final shops = snapshot.data!;
//                     return SizedBox(
//                       height: 100,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: shops.length,
//                         itemBuilder: (context, index) {
//                           final shop = shops[index];
//                           return Padding(
//                             padding: EdgeInsets.only(right: 10.0),
//                             child: GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                     builder: (context) => CateogoryShops(
//                                       categoryId: shop.shopId,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Container(
//                                 height: 100,
//                                 width: 100,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12.0),
//                                   image: DecorationImage(
//                                     image: NetworkImage(shop.shopImage),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 15.0),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "All Shops",
//                       style: textTheme(context).headlineSmall?.copyWith(
//                             fontWeight: FontWeight.w600,
//                           ),
//                     ),
//                   ),
//                 ),
//                 FutureBuilder<List<ShopWithSpecifics>>(
//                     future: ShopService().getShopsWithSpecifics(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return CircularProgressIndicator();
//                       }
//
//                       if (snapshot.hasError) {
//                         return Text("Error loading data");
//                       }
//
//                       final shops = snapshot.data!;
//
//                       return ListView.builder(
//                         itemCount: shops.length,
//                         physics: NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemBuilder: (context, index) {
//                           final shop = shops[index].shop;
//                           final specificShops = shops[index].specificShops;
//                           if (specificShops.isEmpty) {
//                             return ListTile(
//                               title: Text(shop.shopname),
//                               subtitle: Text("No specific shops available"),
//                             );
//                           }
//
//                           return Padding(
//                             padding: const EdgeInsets.only(bottom: 12.0),
//                             child: ListTile(
//                               onTap: () {
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                     builder: (context) => ProductsPage(
//                                       specId: specificShops[0].idSpecificShop,
//                                       shopid: shop.shopId,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               contentPadding: EdgeInsets.zero,
//                               isThreeLine: true,
//                               leading: ClipRRect(
//                                 borderRadius: BorderRadius.circular(12.0),
//                                 child: Image.network(
//                                   specificShops[0].shopImage,
//                                   height: 80.0,
//                                   width: 60.0,
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                               title: Text(
//                                 specificShops[0].shopName,
//                                 style: textTheme(context)
//                                     .titleLarge
//                                     ?.copyWith(fontWeight: FontWeight.w600),
//                               ),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Icon(Icons.star,
//                                           color: AppColors.darkGreen, size: 16),
//                                       RichText(
//                                         text: TextSpan(
//                                           text: specificShops[0].rating,
//                                           style: textTheme(context)
//                                               .bodyLarge
//                                               ?.copyWith(
//                                                   color: AppColors.darkGreen,
//                                                   fontWeight: FontWeight.w600),
//                                           children: [
//                                             TextSpan(
//                                               text:
//                                                   " (${specificShops[0].rating}) ",
//                                               style: textTheme(context)
//                                                   .bodyLarge
//                                                   ?.copyWith(
//                                                       fontWeight:
//                                                           FontWeight.w600),
//                                             ),
//                                             TextSpan(
//                                               text:
//                                                   ".${specificShops[0].arriveTime}",
//                                               style: textTheme(context)
//                                                   .bodyLarge
//                                                   ?.copyWith(
//                                                       color:
//                                                           AppColors.darkGreen,
//                                                       fontWeight:
//                                                           FontWeight.w600),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       SvgPicture.asset(AppIcon.happyIcon,
//                                           width: 28, height: 18),
//                                       SizedBox(width: 5),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           color: colorScheme(context).error,
//                                           borderRadius:
//                                               BorderRadius.circular(5.0),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 2.0, horizontal: 4.0),
//                                         child: RichText(
//                                           text: TextSpan(
//                                             text: '40% off',
//                                             style: textTheme(context)
//                                                 .labelMedium
//                                                 ?.copyWith(
//                                                     color: colorScheme(context)
//                                                         .onPrimary),
//                                             children: [TextSpan(text: "% off")],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     }),
//               ])),
//         ));
//   }
// }
