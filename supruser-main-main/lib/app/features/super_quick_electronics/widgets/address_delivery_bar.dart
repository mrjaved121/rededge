import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';

class AddressDeliveryBar extends StatelessWidget {
  const AddressDeliveryBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.wp(context, 4.3),
        vertical: ResponsiveUtils.hp(context, 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'My apartment',
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 15),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: ResponsiveUtils.wp(context, 1)),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: ResponsiveUtils.sp(context, 18),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveUtils.hp(context, 0.25)),
                Text(
                  'My apartment, Villa 11, Al Barsha 3, Dubai',
                  style: TextStyle(
                      fontSize: ResponsiveUtils.sp(context, 11),
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: ResponsiveUtils.wp(context, 3.2)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Delivering in',
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 11),
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.bolt,
                    size: ResponsiveUtils.sp(context, 14),
                    color: const Color(0xff018D14),
                  ),
                  SizedBox(width: ResponsiveUtils.wp(context, 0.5)),
                  Text(
                    '35 mins',
                    style: TextStyle(
                      color: AppColors.hardGreen,
                      fontSize: ResponsiveUtils.sp(context, 15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}