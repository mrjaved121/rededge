import 'package:flutter/material.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';
import '../trending_card.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(context, 4.3),
          ),
          child: Text(
            'Trending now',
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: ResponsiveUtils.hp(context, 1.5)),
        SizedBox(
          height: ResponsiveUtils.hp(context, 13.0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(context, 4.3),
            ),
            children: const [
              TrendingCard(
                icon: Icons.percent,
                label: 'All deals',
                color: Color(0xff018D14),
              ),
              TrendingCard(
                image: 'assets/images/fc24.png',
                label: 'FC26',
              ),
              TrendingCard(
                image: 'assets/images/controller.png',
                label: 'Everyday laptop accessories',
              ),
              TrendingCard(
                icon: Icons.percent,
                label: 'All deals',
                color: Color(0xff018D14),
              ),
              TrendingCard(
                image: 'assets/images/fc24.png',
                label: 'FC26',
              ),
              TrendingCard(
                image: 'assets/images/controller.png',
                label: 'Everyday laptop accessories',
              ),

            ],
          ),
        ),
      ],
    );
  }
}