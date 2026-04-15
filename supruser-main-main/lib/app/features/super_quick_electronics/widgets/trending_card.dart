import 'package:flutter/material.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';

import '../electronic_tabs_screen.dart';

class TrendingCard extends StatelessWidget {
  final IconData? icon;
  final String? image;
  final String label;
  final Color? color;
  final VoidCallback? onTap;

  const TrendingCard({
    super.key,
    this.icon,
    this.image,
    required this.label,
    this.color,
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
            if (icon != null)
              Container(
                height: ResponsiveUtils.hp(context, 4.9),
                width: ResponsiveUtils.hp(context, 4.9),
                decoration: BoxDecoration(
                  color: color ?? Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: ResponsiveUtils.sp(context, 22),
                ),
              )
            else if (image != null)
              Image.asset(
                image!,
                height: ResponsiveUtils.hp(context, 5.5),
              ),
            SizedBox(height: ResponsiveUtils.hp(context, 0.75)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.wp(context, 1.6),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 9),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}