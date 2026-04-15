import 'package:flutter/material.dart';
import '../../../core/constants/global_variables.dart';
import '../../../core/theme/text_theme.dart';
import '../../../core/utils/responsive_utils.dart';
import '../model/service_model.dart';

class ServiceGridItem extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback? onTap;

  const ServiceGridItem({
    Key? key,
    required this.service,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        ResponsiveUtils.getBorderRadius(context, 12),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF1F3F4),
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.getBorderRadius(context, 12),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image
            Container(
              height: ResponsiveUtils.getIconSize(context, base: 46),
              width: ResponsiveUtils.getIconSize(context, base: 46),
              alignment: Alignment.center,
              child: Image(
                image: AssetImage(service.imagePath),
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),

            // Title
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.getSpacing(context, 4),
              ),
              child: Text(
                service.title,
                style: textTheme(context).bodySmall?.copyWith(
                  fontSize: ResponsiveUtils.sp(context, 11),
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
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