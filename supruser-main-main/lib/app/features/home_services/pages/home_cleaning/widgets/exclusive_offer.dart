import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../provider/home_cleaing_provider.dart';

class ExclusiveOfferWidget extends StatelessWidget {
  final BookingProvider provider;

  const ExclusiveOfferWidget({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 1)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveUtils.getBorderRadius(context, 0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Exclusive offer for you!",
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(context, 14),
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          // Promo Code Box
      Container(

        decoration: BoxDecoration(
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),

            ClipRRect(
              borderRadius: BorderRadius.circular(ResponsiveUtils.getBorderRadius(context, 8)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFE5E7EB),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    // Top Box - Promo Code
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.getSpacing(context, 12),
                        vertical: ResponsiveUtils.getSpacing(context, 10),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 5)),
                            decoration: BoxDecoration(
                              color: Color(0xFFEF4444),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.local_offer,
                              color: AppColors.white,
                              size: ResponsiveUtils.getIconSize(context, base: 14),
                            ),
                          ),
                          SizedBox(width: ResponsiveUtils.getSpacing(context, 10)),
                          Text(
                            "Code: 50OFFER",
                            style: TextStyle(
                              fontSize: ResponsiveUtils.sp(context, 10),
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFEF4444),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () => provider.applyVoucher("50OFFER"),
                            child: Container(
                              padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 4)),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                border: Border.all(
                                  color: Color(0xFFE5E7EB),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(ResponsiveUtils.getBorderRadius(context, 6)),
                              ),
                              child: Icon(
                                Icons.add,
                                color: AppColors.darkGrey,
                                size: ResponsiveUtils.getIconSize(context, base: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Middle Divider Line
                    Container(
                      height: 1,
                      color: Color(0xFFE5E7EB),
                    ),
                    // Bottom Box - Discount Amount
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.getSpacing(context, 10),
                        vertical: ResponsiveUtils.getSpacing(context, 14),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                      ),
                      child: Text(
                        "50 AED Off",
                        style: TextStyle(
                          fontSize: ResponsiveUtils.sp(context, 10),
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
        ],
      ),
    );
  }
}