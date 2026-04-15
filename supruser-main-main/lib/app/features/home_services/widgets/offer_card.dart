import 'package:flutter/material.dart';
import '../../../core/constants/global_variables.dart';
import '../../../core/theme/text_theme.dart';
import '../../../core/utils/responsive_utils.dart';
import '../model/offer_model.dart';


class OfferCard extends StatelessWidget {
  final OfferModel offer;
  final VoidCallback? onTap;

  const OfferCard({
    Key? key,
    required this.offer,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        ResponsiveUtils.getBorderRadius(context, 16),
      ),
      child: Container(
        width: ResponsiveUtils.adaptive(context,
            small: 120, medium: 160, large: 180, tablet: 200),
        decoration: BoxDecoration(
          color: offer.backgroundColor,
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.getBorderRadius(context, 16),
          ),
        ),
        child: Stack(
          children: [
            // Discount Badge
            Positioned(
              top: ResponsiveUtils.getSpacing(context, 16),
              left: ResponsiveUtils.getSpacing(context, 16),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.getSpacing(context, 12),
                  vertical: ResponsiveUtils.getSpacing(context, 6),
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF00CBA9),
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getBorderRadius(context, 8),
                  ),
                ),
                child: Text(
                  offer.discount,
                  style: textTheme(context).labelMedium?.copyWith(
                    fontSize: ResponsiveUtils.sp(context, 11),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Content
            Padding(
              padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Title
                  Text(
                    offer.title,
                    style: textTheme(context).titleMedium?.copyWith(
                      fontSize: ResponsiveUtils.sp(context, 16),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: ResponsiveUtils.getSpacing(context, 4)),

                  // Subtitle
                  Text(
                    offer.subtitle,
                    style: textTheme(context).headlineSmall?.copyWith(
                      fontSize: ResponsiveUtils.sp(context, 20),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),

                  SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),

                  // Code
                  Text(
                    offer.code,
                    style: textTheme(context).bodyMedium?.copyWith(
                      fontSize: ResponsiveUtils.sp(context, 13),
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}