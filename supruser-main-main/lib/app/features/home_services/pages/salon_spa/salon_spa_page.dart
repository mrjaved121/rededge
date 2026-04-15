import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../mixservicesmainetailpage/servicedetailpage.dart';
import '../../widgets/listviewdatastructure.dart';
import '../home_cleaning/widgets/customappbar.dart';

class SalonSpaCategory {
  final String id;
  final String title;
  final String imageUrl;

  SalonSpaCategory({
    required this.id,
    required this.title,
    required this.imageUrl,
  });
}

class SalonSpaPage extends StatelessWidget {
  final String? categoryId;

  const SalonSpaPage({
    super.key,
    this.categoryId,
  });

  // Data map - Add your categories here
  final Map<String, Map<String, dynamic>> categoryData = const {
    'main': {
      'title': 'Salon&Spa',
      'categories': [
        {
          'id': 'womens_salon',
          'title': "Women's Salon",
          'imageUrl': 'assets/images/womens_salon.jpg',
        },
        {
          'id': 'womens_spa',
          'title': "Women's Spa",
          'imageUrl': 'assets/images/womens_spa.jpg',
        },
        {
          'id': 'mens_salon',
          'title': "Men's Salon",
          'imageUrl': 'assets/images/mens_salon.jpg',
        },
        {
          'id': 'mens_spa',
          'title': "Men's Spa",
          'imageUrl': 'assets/images/mens_spa.jpg',
        },
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    // Get current data based on categoryId
    final currentKey = categoryId ?? 'main';
    final currentData = categoryData[currentKey] ?? categoryData['main'];
    final pageTitle = currentData?['title'] as String;
    final categoriesList = (currentData?['categories'] as List).cast<Map<String, dynamic>>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:CustomAppBar(showBackButton: false,title: "Salon And Spa",),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.getSpacing(context, 16),
          vertical: ResponsiveUtils.getSpacing(context, 16),
        ),
        itemCount: categoriesList.length,
        itemBuilder: (context, index) {
          final item = categoriesList[index];
          return Padding(
            padding: EdgeInsets.only(bottom: ResponsiveUtils.getSpacing(context, 16)),
            child: SalonSpaCategoryCard(
              title: item['title'] as String,
              imageUrl: item['imageUrl'] as String,
              onTap: () {
                // Navigate with category ID
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServiceDetailsPage ( categoryId: item['id'] as String,),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class SalonSpaCategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const SalonSpaCategoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        ResponsiveUtils.getBorderRadius(context, 12),
      ),
      child: Container(
        padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.appGrey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.getBorderRadius(context, 12),
          ),
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.getBorderRadius(context, 8),
              ),
              child: Container(
                width: ResponsiveUtils.wp(context, 22),
                height: ResponsiveUtils.wp(context, 22),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                ),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.lightGrey,
                      child: Icon(Icons.image, color: AppColors.darkGrey),
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: ResponsiveUtils.getSpacing(context, 16)),

            // Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 18),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),

            // Arrow Icon
            Icon(
              Icons.arrow_forward,
              color: Colors.black,
              size: ResponsiveUtils.getIconSize(context, base: 24),
            ),
          ],
        ),
      ),
    );
  }
}