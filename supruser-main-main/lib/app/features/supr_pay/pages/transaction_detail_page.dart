// import 'package:flutter/material.dart';
// import '../../../core/utils/responsive_utils.dart';
//
//
// class TransactionDetailPage extends StatelessWidget {
//   const TransactionDetailPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//             size: ResponsiveUtils.getIconSize(context, base: 24),
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: ResponsiveUtils.responsivePadding(
//             context,
//             horizontal: 20,
//             vertical: 20
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Amount and Icon
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'AED 0',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w900,
//                           fontSize: ResponsiveUtils.adaptive(
//                             context,
//                             small: 21,
//                             medium: 23,
//                             large: 25,
//                             tablet: 27,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
//                       Text(
//                         'Transport',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w600,
//                           fontSize: ResponsiveUtils.adaptive(
//                             context,
//                             small: 15,
//                             medium: 16,
//                             large: 17,
//                             tablet: 18,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: ResponsiveUtils.getSpacing(context, 4)),
//                       Text(
//                         '10:39 PM, 27 Oct 2025',
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                           fontSize: ResponsiveUtils.adaptive(
//                             context,
//                             small: 13,
//                             medium: 14,
//                             large: 15,
//                             tablet: 16,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: ResponsiveUtils.getIconSize(context, base: 56),
//                   height: ResponsiveUtils.getIconSize(context, base: 56),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Icons.directions_car,
//                     color: Colors.grey.shade600,
//                     size: ResponsiveUtils.getIconSize(context, base: 28),
//                   ),
//                 ),
//               ],
//             ),
//
//             SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),
//
//             // Split Expense Button
//             Container(
//               width: ResponsiveUtils.wp(context, 45), // 45% of screen width
//               padding: EdgeInsets.symmetric(
//                 horizontal: ResponsiveUtils.getSpacing(context, 16),
//                 vertical: ResponsiveUtils.getSpacing(context, 12),
//               ),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFE8F5E9),
//                 borderRadius: BorderRadius.circular(
//                     ResponsiveUtils.getBorderRadius(context, 19)
//                 ),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.call_split,
//                     color: Colors.green.shade700,
//                     size: ResponsiveUtils.getIconSize(context, base: 20),
//                   ),
//                   SizedBox(width: ResponsiveUtils.getSpacing(context, 8)),
//                   Text(
//                     'Split expense',
//                     style: TextStyle(
//                       color: Colors.green.shade700,
//                       fontWeight: FontWeight.w600,
//                       fontSize: ResponsiveUtils.adaptive(
//                         context,
//                         small: 13,
//                         medium: 14,
//                         large: 15,
//                         tablet: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),
//
//             // Category Section
//             Card(
//               elevation: 1,
//               child: Container(
//                 padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(
//                       ResponsiveUtils.getBorderRadius(context, 12)
//                   ),
//                   border: Border.all(color: Colors.grey.shade50),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Category',
//                       style: TextStyle(
//                         color: Colors.black45,
//                         fontSize: ResponsiveUtils.adaptive(
//                           context,
//                           small: 13,
//                           medium: 14,
//                           large: 15,
//                           tablet: 16,
//                         ),
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     Text(
//                       'Transport',
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontWeight: FontWeight.w900,
//                         fontSize: ResponsiveUtils.adaptive(
//                           context,
//                           small: 13,
//                           medium: 14,
//                           large: 15,
//                           tablet: 16,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
//
//             // Transaction Details Section
//             Card(
//               elevation: 1,
//               child: Container(
//                 padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade50,
//                   borderRadius: BorderRadius.circular(
//                       ResponsiveUtils.getBorderRadius(context, 12)
//                   ),
//                   border: Border.all(color: Colors.grey.shade50),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             'Transaction ID',
//                             style: TextStyle(
//                               color: Colors.grey.shade600,
//                               fontSize: ResponsiveUtils.adaptive(
//                                 context,
//                                 small: 13,
//                                 medium: 14,
//                                 large: 15,
//                                 tablet: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 3,
//                           child: Text(
//                             'd3ff900c-0a96-4b16-9abf-efca499d670d',
//                             textAlign: TextAlign.right,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: ResponsiveUtils.adaptive(
//                                 context,
//                                 small: 11,
//                                 medium: 12,
//                                 large: 13,
//                                 tablet: 14,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Paid by cash',
//                           style: TextStyle(
//                             color: Colors.black45,
//                             fontSize: ResponsiveUtils.adaptive(
//                               context,
//                               small: 13,
//                               medium: 14,
//                               large: 15,
//                               tablet: 16,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           '- AED 0',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600,
//                             fontSize: ResponsiveUtils.adaptive(
//                               context,
//                               small: 13,
//                               medium: 14,
//                               large: 15,
//                               tablet: 16,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
//
//             // Notes Section
//             Card(
//               elevation: 1,
//               child: Container(
//                 padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade50,
//                   borderRadius: BorderRadius.circular(
//                       ResponsiveUtils.getBorderRadius(context, 12)
//                   ),
//                   border: Border.all(color: Colors.grey.shade200),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Notes',
//                       style: TextStyle(
//                         color: Colors.grey.shade600,
//                         fontSize: ResponsiveUtils.adaptive(
//                           context,
//                           small: 13,
//                           medium: 14,
//                           large: 15,
//                           tablet: 16,
//                         ),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.edit_outlined,
//                           color: Colors.green.shade700,
//                           size: ResponsiveUtils.getIconSize(context, base: 18),
//                         ),
//                         SizedBox(width: ResponsiveUtils.getSpacing(context, 4)),
//                         Text(
//                           'Add note',
//                           style: TextStyle(
//                             color: Colors.green.shade700,
//                             fontWeight: FontWeight.w600,
//                             fontSize: ResponsiveUtils.adaptive(
//                               context,
//                               small: 13,
//                               medium: 14,
//                               large: 15,
//                               tablet: 16,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/supr_pay_provider.dart';  // ✅ PROVIDER IMPORT ADD
import '../../../core/utils/responsive_utils.dart';

class TransactionDetailPage extends StatelessWidget {
  final String transactionId;  // ✅ TRANSACTION ID AS PARAMETER

  const TransactionDetailPage({
    super.key,
    required this.transactionId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SuprPayProvider>(  // ✅ CONSUMER ADD KAREN
      builder: (context, provider, child) {
        // ✅ FIND TRANSACTION BY ID
        final transaction = provider.transactions.firstWhere(
              (t) => t['id'] == transactionId,
          orElse: () => {}, // Agar transaction nahi mile to empty map
        );

        // ✅ EXTRACT TRANSACTION DATA
        final amount = transaction['amount'] ?? 0.0;
        final description = transaction['description'] ?? 'Transaction';
        final date = transaction['date'] ?? DateTime.now();
        final type = transaction['type'] ?? 'debit';
        final category = _getCategoryFromDescription(description);
        final icon = _getCategoryIcon(category);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: ResponsiveUtils.getIconSize(context, base: 24),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            padding: ResponsiveUtils.responsivePadding(
                context,
                horizontal: 20,
                vertical: 20
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ DYNAMIC AMOUNT AND ICON
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${type == 'credit' ? '+' : '-'} AED $amount',  // ✅ DYNAMIC AMOUNT
                            style: TextStyle(
                              color: type == 'credit' ? Colors.green : Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: ResponsiveUtils.adaptive(
                                context,
                                small: 21,
                                medium: 23,
                                large: 25,
                                tablet: 27,
                              ),
                            ),
                          ),
                          SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
                          Text(
                            description,  // ✅ DYNAMIC DESCRIPTION
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: ResponsiveUtils.adaptive(
                                context,
                                small: 15,
                                medium: 16,
                                large: 17,
                                tablet: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: ResponsiveUtils.getSpacing(context, 4)),
                          Text(
                            _formatDate(date),  // ✅ DYNAMIC DATE
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: ResponsiveUtils.adaptive(
                                context,
                                small: 13,
                                medium: 14,
                                large: 15,
                                tablet: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: ResponsiveUtils.getIconSize(context, base: 56),
                      height: ResponsiveUtils.getIconSize(context, base: 56),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(category).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        color: _getCategoryColor(category),
                        size: ResponsiveUtils.getIconSize(context, base: 28),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),

                // ✅ SPLIT EXPENSE BUTTON (Only show for debit transactions)
                if (type == 'debit' && !description.contains('Split expense'))
                  Container(
                    width: ResponsiveUtils.wp(context, 45),
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.getSpacing(context, 16),
                      vertical: ResponsiveUtils.getSpacing(context, 12),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(
                          ResponsiveUtils.getBorderRadius(context, 19)
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.call_split,
                          color: Colors.green.shade700,
                          size: ResponsiveUtils.getIconSize(context, base: 20),
                        ),
                        SizedBox(width: ResponsiveUtils.getSpacing(context, 8)),
                        Text(
                          'Split expense',
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w600,
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 13,
                              medium: 14,
                              large: 15,
                              tablet: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                if (type == 'debit' && !description.contains('Split expense'))
                  SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),

                // ✅ DYNAMIC CATEGORY SECTION
                Card(
                  elevation: 1,
                  child: Container(
                    padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          ResponsiveUtils.getBorderRadius(context, 12)
                      ),
                      border: Border.all(color: Colors.grey.shade50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Category',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 13,
                              medium: 14,
                              large: 15,
                              tablet: 16,
                            ),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          category,  // ✅ DYNAMIC CATEGORY
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w900,
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 13,
                              medium: 14,
                              large: 15,
                              tablet: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),

                // ✅ DYNAMIC TRANSACTION DETAILS SECTION
                Card(
                  elevation: 1,
                  child: Container(
                    padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(
                          ResponsiveUtils.getBorderRadius(context, 12)
                      ),
                      border: Border.all(color: Colors.grey.shade50),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Transaction ID',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: ResponsiveUtils.adaptive(
                                    context,
                                    small: 13,
                                    medium: 14,
                                    large: 15,
                                    tablet: 16,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                transactionId,  // ✅ DYNAMIC TRANSACTION ID
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ResponsiveUtils.adaptive(
                                    context,
                                    small: 11,
                                    medium: 12,
                                    large: 13,
                                    tablet: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              type == 'credit' ? 'Received via' : 'Paid by',  // ✅ DYNAMIC TEXT
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: ResponsiveUtils.adaptive(
                                  context,
                                  small: 13,
                                  medium: 14,
                                  large: 15,
                                  tablet: 16,
                                ),
                              ),
                            ),
                            Text(
                              '${type == 'credit' ? '+' : '-'} AED $amount',  // ✅ DYNAMIC AMOUNT
                              style: TextStyle(
                                color: type == 'credit' ? Colors.green : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: ResponsiveUtils.adaptive(
                                  context,
                                  small: 13,
                                  medium: 14,
                                  large: 15,
                                  tablet: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),

                // ✅ NOTES SECTION
                Card(
                  elevation: 1,
                  child: Container(
                    padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(
                          ResponsiveUtils.getBorderRadius(context, 12)
                      ),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Notes',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 13,
                              medium: 14,
                              large: 15,
                              tablet: 16,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              color: Colors.green.shade700,
                              size: ResponsiveUtils.getIconSize(context, base: 18),
                            ),
                            SizedBox(width: ResponsiveUtils.getSpacing(context, 4)),
                            Text(
                              transaction['note'] != null ? 'Edit note' : 'Add note',  // ✅ DYNAMIC TEXT
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: ResponsiveUtils.adaptive(
                                  context,
                                  small: 13,
                                  medium: 14,
                                  large: 15,
                                  tablet: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ✅ HELPER METHODS

  String _formatDate(dynamic date) {
    if (date is DateTime) {
      return '${date.hour}:${date.minute} PM, ${date.day} ${_getMonthName(date.month)} ${date.year}';
    }
    return '10:39 PM, 27 Oct 2025'; // Fallback
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  String _getCategoryFromDescription(String description) {
    if (description.toLowerCase().contains('transport') || description.toLowerCase().contains('ride')) {
      return 'Transport';
    } else if (description.toLowerCase().contains('food')) {
      return 'Food';
    } else if (description.toLowerCase().contains('shopping')) {
      return 'Shopping';
    } else if (description.toLowerCase().contains('wallet')) {
      return 'Wallet';
    } else {
      return 'General';
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Transport':
        return Icons.directions_car;
      case 'Food':
        return Icons.restaurant;
      case 'Shopping':
        return Icons.shopping_bag;
      case 'Wallet':
        return Icons.account_balance_wallet;
      default:
        return Icons.receipt;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Transport':
        return Colors.blue;
      case 'Food':
        return Colors.orange;
      case 'Shopping':
        return Colors.purple;
      case 'Wallet':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}