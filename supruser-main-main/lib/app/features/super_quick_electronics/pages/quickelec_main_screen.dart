import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';
import '../controller/electronics_controller.dart';
import '../widgets/electronics_app_bar.dart';
import '../widgets/address_delivery_bar.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/sections/apple_latest_section.dart';
import '../widgets/sections/trending_section.dart';
import '../widgets/sections/category_section.dart';
import '../widgets/sections/product_section.dart';
import '../widgets/sections/nutricook_section.dart';
import '../widgets/sections/brands_section.dart';

class QuickElectronicsScreen extends StatelessWidget {
  const QuickElectronicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ElectronicsController(),
      child: const _QuickElectronicsScreenBody(),
    );
  }
}

class _QuickElectronicsScreenBody extends StatelessWidget {
  const _QuickElectronicsScreenBody();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ElectronicsController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const ElectronicsAppBar(),
            const AddressDeliveryBar(),
            const ElectronicsSearchBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ResponsiveUtils.hp(context, 1.5)),

                    // Apple's latest releases
                    const AppleLatestSection(),
                    SizedBox(height: ResponsiveUtils.hp(context, 2.5)),

                    // Trending Now
                    const TrendingSection(),
                    SizedBox(height: ResponsiveUtils.hp(context, 2.5)),

                    // Shop by Category
                    const CategorySection(),
                    SizedBox(height: ResponsiveUtils.hp(context, 2.5)),

                    // Bestselling mobiles
                    ProductSection(
                      title: 'Bestselling mobiles for you',
                      products: controller.bestsellingProducts,
                    ),
                    SizedBox(height: ResponsiveUtils.hp(context, 2.5)),

                    // Nutricook Banner & Products
                    const NutricookSection(),
                    SizedBox(height: ResponsiveUtils.hp(context, 2.5)),

                    // Mobile accessories
                    ProductSection(
                      title: 'Mobile accessories must-haves',
                      products: controller.accessoryProducts,
                    ),
                    SizedBox(height: ResponsiveUtils.hp(context, 2.5)),

                    // Top gaming picks
                    ProductSection(
                      title: 'Top gaming picks',
                      products: controller.gamingProducts,
                    ),
                    SizedBox(height: ResponsiveUtils.hp(context, 2.5)),

                    // Top tablets
                    ProductSection(
                      title: 'Top tablets for you',
                      products: controller.tabletProducts,
                    ),
                    SizedBox(height: ResponsiveUtils.hp(context, 2.5)),

                    // Shop by brand
                    const BrandsSection(),
                    SizedBox(height: ResponsiveUtils.hp(context, 2.5)),

                    // Best of personal care
                    ProductSection(
                      title: 'Best of personal care',
                      products: controller.personalCareProducts,
                      customHeight: 200,
                    ),
                    SizedBox(height: ResponsiveUtils.hp(context, 2.5)),

                    // Laptops
                    ProductSection(
                      title: 'Laptops',
                      products: controller.laptopProducts,
                      customHeight: 180,
                    ),
                    SizedBox(height: ResponsiveUtils.hp(context, 3.7)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}