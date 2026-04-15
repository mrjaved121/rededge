import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/responsive_utils.dart';


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
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Review and pay',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.adaptive(
                      context,
                      small: 18,
                      medium: 20,
                      large: 22,
                      tablet: 24,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(
                      Icons.close,
                      size: ResponsiveUtils.getIconSize(context, base: 24)
                  ),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),

            SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),

            // Amount and recipient details
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
              decoration: BoxDecoration(
                color: Colors.grey[50],
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
                        small: 20,
                        medium: 22,
                        large: 24,
                        tablet: 26,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.getSpacing(context, 4)),
                  Text(
                    'Transfer to $name',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.adaptive(
                        context,
                        small: 13,
                        medium: 14,
                        large: 15,
                        tablet: 16,
                      ),
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),

            // Add payment method section
            Text(
              'Add another payment method',
              style: TextStyle(
                fontSize: ResponsiveUtils.adaptive(
                  context,
                  small: 15,
                  medium: 16,
                  large: 17,
                  tablet: 18,
                ),
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),

            // Credit/Debit card option
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getBorderRadius(context, 12)
                ),
              ),
              child: ListTile(
                leading: Container(
                  width: ResponsiveUtils.getIconSize(context, base: 40),
                  height: ResponsiveUtils.getIconSize(context, base: 40),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(
                        ResponsiveUtils.getBorderRadius(context, 8)
                    ),
                  ),
                  child: Icon(
                    Icons.credit_card,
                    size: ResponsiveUtils.getIconSize(context, base: 24),
                    color: Colors.black54,
                  ),
                ),
                title: Text(
                  'Credit or debit card',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.adaptive(
                      context,
                      small: 15,
                      medium: 16,
                      large: 17,
                      tablet: 18,
                    ),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Icon(
                  Icons.add,
                  color: const Color(0xFF00A859),
                  size: ResponsiveUtils.getIconSize(context, base: 24),
                ),
                onTap: () {
                  _showAddCardDialog(context);
                },
                contentPadding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.getSpacing(context, 16),
                  vertical: ResponsiveUtils.getSpacing(context, 8),
                ),
                minLeadingWidth: ResponsiveUtils.wp(context, 12),
              ),
            ),

            SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),

            // Transfer button
            SizedBox(
              width: double.infinity,
              height: ResponsiveUtils.getButtonHeight(context, base: 56),
              child: ElevatedButton(
                onPressed: () {
                  _processPayment(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A859),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        ResponsiveUtils.getBorderRadius(context, 12)
                    ),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Transfer with Careem Pay',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.adaptive(
                      context,
                      small: 16,
                      medium: 17,
                      large: 18,
                      tablet: 19,
                    ),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
          ],
        ),
      ),
    );
  }

  void _processPayment(BuildContext context) {
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Payment processing...',
          style: TextStyle(
            fontSize: ResponsiveUtils.adaptive(
              context,
              small: 14,
              medium: 15,
              large: 16,
              tablet: 17,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF00A859),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              ResponsiveUtils.getBorderRadius(context, 8)
          ),
        ),
      ),
    );
  }

  void _showAddCardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add Card',
          style: TextStyle(
            fontSize: ResponsiveUtils.adaptive(
              context,
              small: 18,
              medium: 20,
              large: 22,
              tablet: 24,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  hintText: '1234 5678 9012 3456',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        ResponsiveUtils.getBorderRadius(context, 8)
                    ),
                  ),
                  contentPadding: EdgeInsets.all(
                      ResponsiveUtils.getSpacing(context, 12)
                  ),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: ResponsiveUtils.adaptive(
                    context,
                    small: 14,
                    medium: 15,
                    large: 16,
                    tablet: 17,
                  ),
                ),
              ),
              SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Expiry Date',
                        hintText: 'MM/YY',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ResponsiveUtils.getBorderRadius(context, 8)
                          ),
                        ),
                        contentPadding: EdgeInsets.all(
                            ResponsiveUtils.getSpacing(context, 12)
                        ),
                      ),
                      style: TextStyle(
                        fontSize: ResponsiveUtils.adaptive(
                          context,
                          small: 14,
                          medium: 15,
                          large: 16,
                          tablet: 17,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ResponsiveUtils.getSpacing(context, 16)),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'CVV',
                        hintText: '123',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              ResponsiveUtils.getBorderRadius(context, 8)
                          ),
                        ),
                        contentPadding: EdgeInsets.all(
                            ResponsiveUtils.getSpacing(context, 12)
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: ResponsiveUtils.adaptive(
                          context,
                          small: 14,
                          medium: 15,
                          large: 16,
                          tablet: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Cardholder Name',
                  hintText: 'John Doe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        ResponsiveUtils.getBorderRadius(context, 8)
                    ),
                  ),
                  contentPadding: EdgeInsets.all(
                      ResponsiveUtils.getSpacing(context, 12)
                  ),
                ),
                style: TextStyle(
                  fontSize: ResponsiveUtils.adaptive(
                    context,
                    small: 14,
                    medium: 15,
                    large: 16,
                    tablet: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.black54,
                fontSize: ResponsiveUtils.adaptive(
                  context,
                  small: 14,
                  medium: 15,
                  large: 16,
                  tablet: 17,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Card added successfully',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.adaptive(
                        context,
                        small: 14,
                        medium: 15,
                        large: 16,
                        tablet: 17,
                      ),
                    ),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00A859),
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.getSpacing(context, 20),
                vertical: ResponsiveUtils.getSpacing(context, 12),
              ),
            ),
            child: Text(
              'Add Card',
              style: TextStyle(
                fontSize: ResponsiveUtils.adaptive(
                  context,
                  small: 14,
                  medium: 15,
                  large: 16,
                  tablet: 17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}