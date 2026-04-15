import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';
import '../../controller/electronics_controller.dart';
import '../brand_card.dart';

class BrandsSection extends StatelessWidget {
  const BrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ElectronicsController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(context, 4.3),
          ),
          child: Text(
            'Shop by brand',
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: ResponsiveUtils.hp(context, 1.5)),
        SizedBox(
          height: ResponsiveUtils.hp(context, 12.3),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(context, 4.3),
            ),
            itemCount: controller.brands.length,
            itemBuilder: (context, index) {
              return BrandCard(brand: controller.brands[index]);
            },
          ),
        ),
      ],
    );
  }
}