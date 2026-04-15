import 'package:flutter/material.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';
import '../electronic_tabs_screen.dart';
import '../models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = ResponsiveUtils.isTablet(context) ? 110.0 : 90.0;

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
        width: ResponsiveUtils.wp(context, size * 100 / 375),
        margin: EdgeInsets.only(right: ResponsiveUtils.wp(context, 3.2)),
        child: Column(
          children: [
            Container(
              height: ResponsiveUtils.wp(context, size * 100 / 375),
              width: ResponsiveUtils.wp(context, size * 100 / 375),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(ResponsiveUtils.wp(context, 3.7)),
                child: Image.asset(category.image, fit: BoxFit.contain),
              ),
            ),
            SizedBox(height: ResponsiveUtils.hp(context, 1)),
            Text(
              category.name,
              style: TextStyle(
                fontSize: ResponsiveUtils.sp(context, 10),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}