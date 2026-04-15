import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../Serviesdatamodel/servvices_datamodel.dart';

class TabBannerWidget extends StatelessWidget {
  final TabBanner banner;

  const TabBannerWidget({
    Key? key,
    required this.banner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: banner.backgroundColor ?? AppColors.lightGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.darkGreen.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // ✅ Show Image OR Icon
          if (banner.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                banner.imageUrl!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.image, color: AppColors.darkGrey, size: 24),
                  );
                },
              ),
            )
          else if (banner.icon != null)
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.darkGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                banner.icon,
                color: AppColors.darkGreen,
                size: 26,
              ),
            ),

          SizedBox(width: 14),

          // ✅ Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  banner.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  banner.description,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.darkGrey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}