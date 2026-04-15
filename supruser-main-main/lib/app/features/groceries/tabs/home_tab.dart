import 'package:flutter/material.dart';
import 'package:suprapp/app/features/groceries/models/product_model.dart';
import 'package:suprapp/app/features/groceries/widgets/product_section.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductSection(
                title: 'Detergent liquid',
                products: liquid,
                isHerbal: false,
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSection(
                title: 'Detergent powder',
                products: powder,
                isHerbal: true,
                onSectionTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSection(
                title: 'Detergent tabs',
                products: toab,
                isHerbal: false,
                onSectionTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSection(
                title: 'Fabric softners',
                products: fabricSoftners,
                isHerbal: false,
                onSectionTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSection(
                title: 'Stain Removers',
                products: stainRemover,
                isHerbal: false,
                onSectionTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSection(
                title: 'Bleach & Starch',
                products: powder,
                isHerbal: true,
                onSectionTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSection(
                title: 'Surface Cleaners',
                products: surfaceCleaners,
                isHerbal: true,
                onSectionTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSection(
                title: 'Cleaning Materials',
                products: fabricSoftners,
                isHerbal: false,
                onSectionTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSection(
                title: 'Dish Cleaners',
                products: stainRemover,
                isHerbal: false,
                onSectionTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              ProductSection(
                title: 'Bathroom Cleaners',
                products: surfaceCleaners,
                isHerbal: true,
                onSectionTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )),
    );
  }
}
