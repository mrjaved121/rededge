import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../home_cleaning/widgets/customappbar.dart';
import 'laundary_service.dart';

class LaundryHomePage extends StatefulWidget {
  const LaundryHomePage({Key? key}) : super(key: key);

  @override
  State<LaundryHomePage> createState() => _LaundryHomePageState();
}

class _LaundryHomePageState extends State<LaundryHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(showBackButton: true, title: 'Laundry'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPricingSection(context),
              SizedBox(height: ResponsiveUtils.getSpacing(context, 18)),
              _buildDiscoverSection(context),
              SizedBox(height: ResponsiveUtils.getSpacing(context, 15)),
              _buildHowItWorks(context),
              SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
              _buildTalkToAgent(context),
              SizedBox(height: ResponsiveUtils.getSpacing(context, 75)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildPricingSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pricing',
          style: TextStyle(
            fontSize: ResponsiveUtils.sp(context, 18),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
        SizedBox(
          height: ResponsiveUtils.adaptive(
            context,
            small: 110,
            medium: 117,
            large: 125,
            tablet: 140,
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildPriceCard(
                context,
                'View Price\nList',
                null,
                null,
                Colors.white,
                isAddButton: true,
              ),
              SizedBox(width: ResponsiveUtils.getSpacing(context, 9)),
              _buildPriceCard(
                context,
                'Clean & Press\nShirt',
                13,
                18,
                AppColors.lightGrey,
                icon: Icons.checkroom,
                iconColor: const Color(0xFF4CAF50),
                serviceType: 'hanger',
              ),
              SizedBox(width: ResponsiveUtils.getSpacing(context, 9)),
              _buildPriceCard(
                context,
                'Wash & Fold\nBags',
                55,
                75,
                AppColors.lightGrey,
                icon: Icons.shopping_bag,
                iconColor: const Color(0xFF00BCD4),
                serviceType: 'iron',
              ),
              SizedBox(width: ResponsiveUtils.getSpacing(context, 9)),
              _buildPriceCard(
                context,
                'Bed & Bath\nBags',
                66,
                85,
                AppColors.lightGrey,
                icon: Icons.bed,
                iconColor: const Color(0xFFFF4081),
                serviceType: 'pillow',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceCard(
      BuildContext context,
      String title,
      int? newPrice,
      int? oldPrice,
      Color bgColor, {
        IconData? icon,
        Color? iconColor,
        bool isAddButton = false,
        String? serviceType,
      }) {
    final double cardWidth = ResponsiveUtils.adaptive<double>(
      context,
      small: 85.5,
      medium: 93.0,
      large: 100.5,
      tablet: 115.5,
    );

    return GestureDetector(
      onTap: () {
        if (!isAddButton && serviceType != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LaundryServicePage(serviceType: serviceType),
            ),
          );
        }
      },
      child: Container(
        width: cardWidth,
        padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 9)),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.getBorderRadius(context, 12),
          ),
          border: Border.all(
            color: isAddButton ? Colors.grey.shade300 : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Container(
                padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 6)),
                decoration: BoxDecoration(
                  color: iconColor?.withOpacity(0.2) ?? Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: ResponsiveUtils.getIconSize(context, base: 21),
                  color: iconColor,
                ),
              ),
            if (isAddButton)
              Text(
                '+',
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 30),
                  fontWeight: FontWeight.w300,
                  color: Colors.grey.shade600,
                ),
              ),
            SizedBox(height: ResponsiveUtils.getSpacing(context, 4)),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveUtils.sp(context, 9),
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                height: 1.2,
              ),
            ),
            if (newPrice != null) ...[
              SizedBox(height: ResponsiveUtils.getSpacing(context, 3)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (oldPrice != null)
                    Text(
                      'AED $oldPrice',
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 7.5),
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  if (oldPrice != null)
                    SizedBox(width: ResponsiveUtils.getSpacing(context, 4)),
                  Text(
                    'AED $newPrice',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(context, 10.5),
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDiscoverSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Discover',
          style: TextStyle(
            fontSize: ResponsiveUtils.sp(context, 18),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
        SizedBox(
          height: ResponsiveUtils.adaptive(
            context,
            small: 135,
            medium: 142,
            large: 150,
            tablet: 172,
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildDiscoverCard(
                context,
                'Get AED 30 off',
                'your first order',
                'Use Code SUPR30',
                'assets/laundry1.png',
                const Color(0xFF7B1FA2),
              ),
              SizedBox(width: ResponsiveUtils.getSpacing(context, 9)),
              _buildDiscoverCard(
                context,
                'Shirts.',
                'Cleaned and Pressed.',
                '₽3 AED Only',
                'assets/laundry2.png',
                const Color(0xFF00796B),
              ),
              SizedBox(width: ResponsiveUtils.getSpacing(context, 9)),
              _buildDiscoverCard(
                context,
                'Wash & Fold bag',
                'only AED 26 AED 55',
                'Learn More',
                'assets/laundry3.png',
                const Color(0xFF0288D1),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDiscoverCard(
      BuildContext context,
      String title,
      String subtitle,
      String badge,
      String imagePath,
      Color bgColor,
      ) {
    final double cardWidth = ResponsiveUtils.adaptive<double>(
      context,
      small: 195.0,
      medium: 210.0,
      large: 225.0,
      tablet: 262.5,
    );

    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getBorderRadius(context, 12),
        ),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            bgColor.withOpacity(0.3),
            BlendMode.overlay,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [bgColor.withOpacity(0.9), bgColor.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.getBorderRadius(context, 12),
          ),
        ),
        padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: ResponsiveUtils.sp(context, 13.5),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: ResponsiveUtils.getSpacing(context, 3)),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: ResponsiveUtils.sp(context, 9.75),
                color: Colors.white,
              ),
            ),
            SizedBox(height: ResponsiveUtils.getSpacing(context, 9)),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.getSpacing(context, 9),
                vertical: ResponsiveUtils.getSpacing(context, 4.5),
              ),
              decoration: BoxDecoration(
                color: AppColors.lightGreen,
                borderRadius: BorderRadius.circular(
                  ResponsiveUtils.getBorderRadius(context, 15),
                ),
              ),
              child: Text(
                badge,
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 8.25),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHowItWorks(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getSpacing(context, 12),
        vertical: ResponsiveUtils.getSpacing(context, 12),
      ),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getBorderRadius(context, 9),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 7.5)),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.help_outline,
              color: AppColors.appGreen,
              size: ResponsiveUtils.getIconSize(context, base: 16.5),
            ),
          ),
          SizedBox(width: ResponsiveUtils.getSpacing(context, 9)),
          Expanded(
            child: Text(
              'How it Works',
              style: TextStyle(
                fontSize: ResponsiveUtils.sp(context, 11.25),
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.black54,
            size: ResponsiveUtils.getIconSize(context, base: 16.5),
          ),
        ],
      ),
    );
  }

  Widget _buildTalkToAgent(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getSpacing(context, 12),
        vertical: ResponsiveUtils.getSpacing(context, 12),
      ),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getBorderRadius(context, 9),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 7.5)),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.phone_outlined,
              color: AppColors.appGreen,
              size: ResponsiveUtils.getIconSize(context, base: 16.5),
            ),
          ),
          SizedBox(width: ResponsiveUtils.getSpacing(context, 9)),
          Expanded(
            child: Text(
              'Questions? Talk to a Laundry Agent',
              style: TextStyle(
                fontSize: ResponsiveUtils.sp(context, 11.25),
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.black54,
            size: ResponsiveUtils.getIconSize(context, base: 16.5),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 12)),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 7.5)),
              decoration: BoxDecoration(
                color: AppColors.appLightOrange,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.local_offer,
                size: ResponsiveUtils.getIconSize(context, base: 16.5),
                color: AppColors.appOrange,
              ),
            ),
            SizedBox(width: ResponsiveUtils.getSpacing(context, 9)),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AED 30 Promo',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(context, 10.5),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Use Code SUPR30',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(context, 9),
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => LaundryServicePage(serviceType: 'hanger'),
                //   ),
                // );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.getSpacing(context, 24),
                  vertical: ResponsiveUtils.getSpacing(context, 10.5),
                ),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getBorderRadius(context, 22.5),
                  ),
                ),
                child: Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.sp(context, 11.25),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}