import 'package:flutter/material.dart';
import 'package:suprapp/app/features/groceries/models/product_model.dart';
import 'package:suprapp/app/features/groceries/widgets/product_section.dart';

class TopPicksTab extends StatefulWidget {
  const TopPicksTab({super.key});

  @override
  State<TopPicksTab> createState() => _TopPicksTabState();
}

class _TopPicksTabState extends State<TopPicksTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductSection(
                title: 'Our Top Picks',
                products: items,
                isHerbal: false,
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSection(
                title: 'Fresh Produce',
                products: myherbalList,
                isHerbal: true,
                onSectionTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSection(
                title: 'Milk & Yogurt Essentials',
                products: milkAndYogurt,
                isHerbal: false,
                onSectionTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSection(
                title: 'Drinks & Sips',
                products: beverages,
                isHerbal: false,
                onSectionTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSection(
                title: 'Sugar Rush',
                products: reducedToClear,
                isHerbal: false,
                onSectionTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSection(
                title: 'Bakery Picks',
                products: myherbalList,
                isHerbal: true,
                onSectionTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSection(
                title: 'Cheese Spreads',
                products: bundleOffers,
                isHerbal: true,
                onSectionTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSection(
                title: 'Fresh Eggs',
                products: milkAndYogurt,
                isHerbal: false,
                onSectionTap: () {},
              ),
            ],
          )),
    );
  }
}
