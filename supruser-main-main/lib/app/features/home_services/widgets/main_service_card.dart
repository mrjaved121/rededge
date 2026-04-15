import 'package:flutter/material.dart';
import '../../../core/constants/global_variables.dart';
import '../../../core/theme/text_theme.dart';
import '../../../core/utils/responsive_utils.dart';
import '../model/service_model.dart';

class MainServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback? onTap;

  const MainServiceCard({
    Key? key,
    required this.service,
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
        height: ResponsiveUtils.adaptive(context,
            small: 120, medium: 130, large: 140, tablet: 180),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F3F4),
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.getBorderRadius(context, 16),
          ),
        ),
        child: Stack(
          children: [
            // Offer Badge
            if (service.hasOffer && service.offerText != null)
              Positioned(
                top: ResponsiveUtils.getSpacing(context, 12),
                right: ResponsiveUtils.getSpacing(context, 12),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.getSpacing(context, 10),
                    vertical: ResponsiveUtils.getSpacing(context, 6),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00CBA9),
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getBorderRadius(context, 8),
                    ),
                  ),
                  child: Text(
                    service.offerText!,
                    style: textTheme(context).labelMedium?.copyWith(
                      fontSize: ResponsiveUtils.sp(context, 10),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

            // Content
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(
                  ResponsiveUtils.getSpacing(context, 8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image
                    Container(
                      height: ResponsiveUtils.adaptive(context,
                          small: 70, medium: 80, large: 90, tablet: 100),
                      width: ResponsiveUtils.adaptive(context,
                          small: 70, medium: 80, large: 90, tablet: 100),
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage(service.imagePath),
                        fit: BoxFit.contain,
                      ),
                    ),

                    SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),

                    // Title
                    Text(
                      service.title,
                      style: textTheme(context).titleMedium?.copyWith(
                        fontSize: ResponsiveUtils.sp(context, 14),
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}