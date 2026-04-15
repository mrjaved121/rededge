import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../provider/home_cleaing_provider.dart';

class PaymentSummaryWidget extends StatelessWidget {
  final BookingProvider provider;

  const PaymentSummaryWidget({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 20)),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(ResponsiveUtils.getBorderRadius(context, 12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Summary",
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(context, 18),
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),

          // ✅ Home Cleaning Specific Details
          if (provider.isHomeCleaningService) ...[
            Text(
              "• Home Cleaning, ${provider.selectedHours ?? 2} hours",
              style: TextStyle(
                fontSize: ResponsiveUtils.sp(context, 14),
                color: Colors.black,
              ),
            ),
            SizedBox(height: ResponsiveUtils.getSpacing(context, 4)),
            Text(
              "• ${provider.selectedProfessionals ?? 1} professional ${!provider.needMaterials ? 'without' : 'with'} cleaning material",
              style: TextStyle(
                fontSize: ResponsiveUtils.sp(context, 14),
                color: Colors.black,
              ),
            ),
            SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
          ] else ...[
            // ✅ Other Services - Show Selected Services List
            if (provider.selectedServices.isNotEmpty) ...[
              Text(
                "• ${provider.currentCategory?.name ?? 'Services'}:",
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 14),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
              ...provider.selectedServices.map((service) {
                final quantity = provider.getServiceQuantity(service);
                return Padding(
                  padding: EdgeInsets.only(
                    left: ResponsiveUtils.getSpacing(context, 12),
                    bottom: ResponsiveUtils.getSpacing(context, 4),
                  ),
                  child: Text(
                    "  - ${service.name}, ${quantity}x",
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(context, 13),
                      color: Colors.black87,
                    ),
                  ),
                );
              }).toList(),
              SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
            ],
          ],

          // ✅ Add-Ons Section (if any)
          if (provider.selectedAddOns.isNotEmpty) ...[
            Text(
              "• Add-ons:",
              style: TextStyle(
                fontSize: ResponsiveUtils.sp(context, 14),
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
            ...provider.selectedAddOns.map((addOn) {
              final quantity = provider.getAddOnQuantity(addOn);
              return Padding(
                padding: EdgeInsets.only(
                  left: ResponsiveUtils.getSpacing(context, 12),
                  bottom: ResponsiveUtils.getSpacing(context, 4),
                ),
                child: Text(
                  "  - ${addOn.title}, ${quantity}x",
                  style: TextStyle(
                    fontSize: ResponsiveUtils.sp(context, 13),
                    color: Colors.black87,
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
          ],

          // Divider
          Divider(
            color: Colors.black.withOpacity(0.1),
            height: 1,
            thickness: 1,
          ),
          SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),

          // ✅ Service Total for Home Cleaning
          if (provider.isHomeCleaningService && provider.subtotal > 0)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Service Total",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 14),
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "AED ${provider.subtotal.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 14),
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
              ],
            ),

          // ✅ Services Total for Other Services (only if services selected)
          if (!provider.isHomeCleaningService && provider.selectedServices.isNotEmpty)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Service Total",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 14),
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "AED ${provider.servicesTotal.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 14),
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
              ],
            ),

          // ✅ Add-Ons Total (only if add-ons selected)
          if (provider.selectedAddOns.isNotEmpty)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add-ons Total",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 14),
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "AED ${provider.addOnsTotal.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 14),
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
              ],
            ),

          // Service Fee
          if (provider.serviceFee > 0)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Service Fee",
                          style: TextStyle(
                            fontSize: ResponsiveUtils.sp(context, 14),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: ResponsiveUtils.getSpacing(context, 4)),
                        Icon(
                          Icons.info_outline,
                          color: Colors.black,
                          size: ResponsiveUtils.getIconSize(context, base: 16),
                        ),
                      ],
                    ),
                    Text(
                      "AED ${provider.serviceFee.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 14),
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
              ],
            ),

          // Discount (if any)
          if (provider.discountAmount > 0)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Discount",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 14),
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      "- AED ${provider.discountAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 14),
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
              ],
            ),

          // Divider before total
          Divider(
            color: Colors.black.withOpacity(0.1),
            height: 1,
            thickness: 1,
          ),
          SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 16),
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              Text(
                "AED ${provider.total.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 16),
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/utils/responsive_utils.dart';
// import '../provider/home_cleaing_provider.dart';
//
// class PaymentSummaryWidget extends StatelessWidget {
//   final BookingProvider provider;
//
//   const PaymentSummaryWidget({Key? key, required this.provider}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 20)),
//       decoration: BoxDecoration(
//         color: AppColors.lightGrey,
//         borderRadius: BorderRadius.circular(ResponsiveUtils.getBorderRadius(context, 12)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Payment Summary",
//             style: TextStyle(
//               fontSize: ResponsiveUtils.sp(context, 18),
//               fontWeight: FontWeight.w700,
//               color: Colors.black,
//             ),
//           ),
//           SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
//
//           // ✅ Home Cleaning Specific Details
//           if (provider.isHomeCleaningService) ...[
//             Text(
//               "• Home Cleaning, ${provider.selectedHours ?? 2} hours",
//               style: TextStyle(
//                 fontSize: ResponsiveUtils.sp(context, 14),
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: ResponsiveUtils.getSpacing(context, 4)),
//             Text(
//               "• ${provider.selectedProfessionals ?? 1} professional ${!provider.needMaterials ? 'without' : 'with'} cleaning material",
//               style: TextStyle(
//                 fontSize: ResponsiveUtils.sp(context, 14),
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
//           ] else ...[
//             // ✅ Other Services - Show Selected Services List
//             if (provider.selectedServices.isNotEmpty) ...[
//               Text(
//                 "• ${provider.currentCategory?.name ?? 'Services'}:",
//                 style: TextStyle(
//                   fontSize: ResponsiveUtils.sp(context, 14),
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
//               ...provider.selectedServices.map((service) {
//                 final quantity = provider.getServiceQuantity(service);
//                 return Padding(
//                   padding: EdgeInsets.only(
//                     left: ResponsiveUtils.getSpacing(context, 12),
//                     bottom: ResponsiveUtils.getSpacing(context, 4),
//                   ),
//                   child: Text(
//                     "  - ${service.name}, ${quantity}x",
//                     style: TextStyle(
//                       fontSize: ResponsiveUtils.sp(context, 13),
//                       color: Colors.black87,
//                     ),
//                   ),
//                 );
//               }).toList(),
//               SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
//             ],
//           ],
//
//           // ✅ Add-Ons Section (if any)
//           if (provider.selectedAddOns.isNotEmpty) ...[
//             Text(
//               "• Add-ons:",
//               style: TextStyle(
//                 fontSize: ResponsiveUtils.sp(context, 14),
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
//             ...provider.selectedAddOns.map((addOn) {
//               final quantity = provider.getAddOnQuantity(addOn);
//               return Padding(
//                 padding: EdgeInsets.only(
//                   left: ResponsiveUtils.getSpacing(context, 12),
//                   bottom: ResponsiveUtils.getSpacing(context, 4),
//                 ),
//                 child: Text(
//                   "  - ${addOn.title}, ${quantity}x",
//                   style: TextStyle(
//                     fontSize: ResponsiveUtils.sp(context, 13),
//                     color: Colors.black87,
//                   ),
//                 ),
//               );
//             }).toList(),
//             SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
//           ],
//
//           // Divider
//           Divider(
//             color: Colors.black.withOpacity(0.1),
//             height: 1,
//             thickness: 1,
//           ),
//           SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
//
//           // Subtotal
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Subtotal",
//                 style: TextStyle(
//                   fontSize: ResponsiveUtils.sp(context, 14),
//                   color: Colors.black,
//                 ),
//               ),
//               Text(
//                 "AED ${provider.subtotal.toStringAsFixed(2)}",
//                 style: TextStyle(
//                   fontSize: ResponsiveUtils.sp(context, 14),
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
//
//           // Services Total (only if services selected)
//           if (provider.selectedServices.isNotEmpty)
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Services Total",
//                       style: TextStyle(
//                         fontSize: ResponsiveUtils.sp(context, 14),
//                         color: Colors.black,
//                       ),
//                     ),
//                     Text(
//                       "AED ${provider.servicesTotal.toStringAsFixed(2)}",
//                       style: TextStyle(
//                         fontSize: ResponsiveUtils.sp(context, 14),
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
//               ],
//             ),
//
//           // Add-Ons Total (only if add-ons selected)
//           if (provider.selectedAddOns.isNotEmpty)
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Add-ons Total",
//                       style: TextStyle(
//                         fontSize: ResponsiveUtils.sp(context, 14),
//                         color: Colors.black,
//                       ),
//                     ),
//                     Text(
//                       "AED ${provider.addOnsTotal.toStringAsFixed(2)}",
//                       style: TextStyle(
//                         fontSize: ResponsiveUtils.sp(context, 14),
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
//               ],
//             ),
//
//           // Service Fee
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     "Service Fee",
//                     style: TextStyle(
//                       fontSize: ResponsiveUtils.sp(context, 14),
//                       color: Colors.black,
//                     ),
//                   ),
//                   SizedBox(width: ResponsiveUtils.getSpacing(context, 4)),
//                   Icon(
//                     Icons.info_outline,
//                     color: Colors.black,
//                     size: ResponsiveUtils.getIconSize(context, base: 16),
//                   ),
//                 ],
//               ),
//               Text(
//                 "AED ${provider.serviceFee.toStringAsFixed(2)}",
//                 style: TextStyle(
//                   fontSize: ResponsiveUtils.sp(context, 14),
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
//
//           // Discount (if any)
//           if (provider.discountAmount > 0)
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Discount",
//                       style: TextStyle(
//                         fontSize: ResponsiveUtils.sp(context, 14),
//                         color: Colors.green,
//                       ),
//                     ),
//                     Text(
//                       "- AED ${provider.discountAmount.toStringAsFixed(2)}",
//                       style: TextStyle(
//                         fontSize: ResponsiveUtils.sp(context, 14),
//                         color: Colors.green,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
//               ],
//             ),
//
//           // Divider before total
//           Divider(
//             color: Colors.black.withOpacity(0.1),
//             height: 1,
//             thickness: 1,
//           ),
//           SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
//
//           // Total
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Total",
//                 style: TextStyle(
//                   fontSize: ResponsiveUtils.sp(context, 16),
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black,
//                 ),
//               ),
//               Text(
//                 "AED ${provider.total.toStringAsFixed(2)}",
//                 style: TextStyle(
//                   fontSize: ResponsiveUtils.sp(context, 16),
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.darkGreen,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
