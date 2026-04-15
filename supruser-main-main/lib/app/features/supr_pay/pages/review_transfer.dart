import 'package:flutter/material.dart';
import '../../../core/utils/responsive_utils.dart';

import 'add_card_page.dart';

class ReviewTransferScreen extends StatelessWidget {
  final String name;
  final String phone;
  final String amount;

  const ReviewTransferScreen({
    Key? key,
    required this.name,
    required this.phone,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F8F8),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: ResponsiveUtils.getIconSize(context, base: 24),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Review transfer details',
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ResponsiveUtils.wp(context, 4)),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getBorderRadius(context, 12)
                ),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: IconButton(
                icon: Icon(
                    Icons.info_outline,
                    color: Colors.black,
                    size: ResponsiveUtils.getIconSize(context, base: 20)
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top section with amount
            Container(
              width: double.infinity,
              color: const Color(0xFFF8F8F8),
              padding: EdgeInsets.symmetric(
                vertical: ResponsiveUtils.hp(context, 5),
                horizontal: ResponsiveUtils.wp(context, 6),
              ),
              child: Column(
                children: [
                  Text(
                    'AED $amount',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.adaptive(
                        context,
                        small: 36,
                        medium: 42,
                        large: 48,
                        tablet: 54,
                      ),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: -1,
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
                  Text(
                    'to $name',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.adaptive(
                        context,
                        small: 14,
                        medium: 15,
                        large: 16,
                        tablet: 17,
                      ),
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),

            // Recipient number container - FIXED LAYOUT
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.wp(context, 6)
              ),
              padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 20)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getBorderRadius(context, 12)
                ),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recipient number',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.adaptive(
                        context,
                        small: 12,
                        medium: 13,
                        large: 14,
                        tablet: 15,
                      ),
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Phone number on the left
                      Expanded(
                        child: Text(
                          phone,
                          style: TextStyle(
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 14,
                              medium: 15,
                              large: 16,
                              tablet: 17,
                            ),
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: ResponsiveUtils.getSpacing(context, 8)),
                      // Badge on the right
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.getSpacing(context, 12),
                          vertical: ResponsiveUtils.getSpacing(context, 6),
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(
                              ResponsiveUtils.getBorderRadius(context, 16)
                          ),
                        ),
                        child: Text(
                          'On Careem',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 11,
                              medium: 12,
                              large: 13,
                              tablet: 14,
                            ),
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Select payment method button
            Padding(
              padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 24)),
              child: SizedBox(
                width: double.infinity,
                height: ResponsiveUtils.getButtonHeight(context, base: 54),
                child: ElevatedButton(
                  onPressed: () {
                    _showPaymentMethodSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D3D2C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          ResponsiveUtils.getBorderRadius(context, 12)
                      ),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Select payment method',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.adaptive(
                        context,
                        small: 15,
                        medium: 16,
                        large: 17,
                        tablet: 18,
                      ),
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4DFFA6),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentMethodSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => PaymentMethodSheet(
        name: name,
        amount: amount,
      ),
    );
  }
}

class PaymentMethodSheet extends StatelessWidget {
  final String name;
  final String amount;

  const PaymentMethodSheet({
    Key? key,
    required this.name,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 20)),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(ResponsiveUtils.getBorderRadius(context, 20))
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with close button
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 8)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        ResponsiveUtils.getBorderRadius(context, 12)
                    ),
                  ),
                  child: Icon(
                      Icons.close,
                      size: ResponsiveUtils.getIconSize(context, base: 20)
                  ),
                ),
              ),
              SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
              Text(
                'Review and pay',
                style: TextStyle(
                  fontSize: ResponsiveUtils.adaptive(
                    context,
                    small: 15,
                    medium: 16,
                    large: 17,
                    tablet: 18,
                  ),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),

          // Transfer details card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                  ResponsiveUtils.getBorderRadius(context, 12)
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PKR $amount',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.adaptive(
                      context,
                      small: 18,
                      medium: 20,
                      large: 22,
                      tablet: 24,
                    ),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: ResponsiveUtils.getSpacing(context, 4)),
                Text(
                  'Transfer to $name',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.adaptive(
                      context,
                      small: 11,
                      medium: 12,
                      large: 13,
                      tablet: 14,
                    ),
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),

          // Add payment method section
          Text(
            'Add another payment method',
            style: TextStyle(
              fontSize: ResponsiveUtils.adaptive(
                context,
                small: 12,
                medium: 13,
                large: 14,
                tablet: 15,
              ),
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),

          // Credit or debit card option
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCardPage(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getBorderRadius(context, 12)
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 6)),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(
                          ResponsiveUtils.getBorderRadius(context, 6)
                      ),
                    ),
                    child: Icon(
                      Icons.credit_card,
                      size: ResponsiveUtils.getIconSize(context, base: 20),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
                  Text(
                    'Credit or debit card',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.adaptive(
                        context,
                        small: 13,
                        medium: 14,
                        large: 15,
                        tablet: 16,
                      ),
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                      Icons.add,
                      size: ResponsiveUtils.getIconSize(context, base: 20),
                      color: Colors.black
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),

          // Transfer button
          SizedBox(
            width: double.infinity,
            height: ResponsiveUtils.getButtonHeight(context, base: 48),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                print('Transfer with Careem Pay');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF006837),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getBorderRadius(context, 12)
                  ),
                ),
              ),
              child: Text(
                'Transfer with Careem Pay',
                style: TextStyle(
                  fontSize: ResponsiveUtils.adaptive(
                    context,
                    small: 13,
                    medium: 14,
                    large: 15,
                    tablet: 16,
                  ),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4DFFA6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}