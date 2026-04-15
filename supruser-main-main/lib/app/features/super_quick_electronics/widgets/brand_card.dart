import 'package:flutter/material.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';
import '../electronic_tabs_screen.dart';
import '../models/brand_model.dart';

class BrandCard extends StatelessWidget {
  final BrandModel brand;
  final VoidCallback? onTap;

  const BrandCard({
    super.key,
    required this.brand,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = ResponsiveUtils.isTablet(context) ? 130.0 : 110.0;

    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ElectronicTabScreen(),
            ),
        );
      },
      child: Container(
        width: ResponsiveUtils.wp(context, cardWidth * 100 / 375),
        margin: EdgeInsets.only(right: ResponsiveUtils.wp(context, 3.2)),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (brand.icon != null)
              Icon(
                brand.icon,
                size: ResponsiveUtils.sp(context, 30),
                color: const Color(0xff018D14),
              )
            else
              Text(
                brand.name,
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 16),
                  fontWeight: FontWeight.bold,
                ),
              ),
            SizedBox(height: ResponsiveUtils.hp(context, 0.75)),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.wp(context, 3.2),
                vertical: ResponsiveUtils.hp(context, 0.75),
              ),
              decoration: BoxDecoration(
                color: brand.offer.contains('Shop')
                    ? Colors.grey.shade300
                    : const Color(0xff00D66C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                brand.offer,
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 11),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}