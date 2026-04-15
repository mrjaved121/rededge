import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';
import 'package:suprapp/app/routes/go_router.dart';

class PaymentOptionsScreen extends StatefulWidget {
  const PaymentOptionsScreen({super.key});

  @override
  State<PaymentOptionsScreen> createState() => _PaymentOptionsScreenState();
}

class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {
  String selectedPaymentMethod = 'cash';

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Dimmed background overlay
            Positioned.fill(
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),

            // Payment options sheet
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffF5F5F5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    // Header with back button and title - REDUCED SIZE
                    Container(
                      padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 12)), // Reduced from 16
                      decoration: BoxDecoration(
                        color: Color(0xffF5F5F5),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: Container(
                              padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 6)), // Reduced from 8
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColors.appGrey, width: 1),
                                borderRadius: BorderRadius.circular(
                                  ResponsiveUtils.getBorderRadius(context, 10), // Reduced from 12
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                size: ResponsiveUtils.getIconSize(context, base: 18), // Reduced from 20
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          SizedBox(width: ResponsiveUtils.getSpacing(context, 12)), // Reduced from 16
                          Text(
                            'Payment options',
                            style: TextStyle(
                              fontSize: ResponsiveUtils.sp(context, 18), // Reduced from 20
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Scrollable content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveUtils.getSpacing(context, 16),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: ResponsiveUtils.getSpacing(context, 4)), // Reduced from 8

                              // Wallet Option
                              _buildPaymentTile(
                                context: context,
                                leadingWidget: _buildPayIcon(context),
                                title: 'Wallet',
                                subtitle: 'Balance: PKR 0',
                                isSelected: selectedPaymentMethod == 'wallet',
                                onTap: () {
                                  setState(() {
                                    selectedPaymentMethod = 'wallet';
                                  });
                                },
                              ),

                              SizedBox(height: ResponsiveUtils.getSpacing(context, 10)), // Reduced from 12

                              // Add Card Option
                              _buildPaymentTile(
                                context: context,
                                leadingWidget: Icon(
                                  Icons.credit_card,
                                  size: ResponsiveUtils.getIconSize(context, base: 24), // Reduced from 28
                                  color: Colors.black87,
                                ),
                                title: 'Add card',
                                subtitle: null,
                                isSelected: false,
                                showAddIcon: true,
                                onTap: () {
                                  context.pushNamed(AppRoute.addCard);
                                },
                              ),

                              SizedBox(height: ResponsiveUtils.getSpacing(context, 10)), // Reduced from 12

                              // Cash Option
                              _buildPaymentTile(
                                context: context,
                                leadingWidget: Icon(
                                  Icons.money,
                                  size: ResponsiveUtils.getIconSize(context, base: 24), // Reduced from 28
                                  color: Colors.black87,
                                ),
                                title: 'Cash',
                                subtitle: null,
                                isSelected: selectedPaymentMethod == 'cash',
                                onTap: () {
                                  setState(() {
                                    selectedPaymentMethod = 'cash';
                                  });
                                },
                              ),

                              SizedBox(height: ResponsiveUtils.getSpacing(context, 20)), // Reduced from 100
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Fixed Bottom Button - REDUCED SIZE
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 12)), // Reduced from 16
                      decoration: BoxDecoration(
                        color: Color(0xffF5F5F5),
                      ),
                      child: SafeArea(
                        child: SizedBox(
                          width: double.infinity,
                          height: ResponsiveUtils.getButtonHeight(context, base: 48), // Reduced from 56
                          child: ElevatedButton(
                            onPressed: () {
                              context.pop(selectedPaymentMethod);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.darkGreen,
                              foregroundColor: AppColors.lightGreen,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  ResponsiveUtils.getBorderRadius(context, 8),
                                ),
                              ),
                            ),
                            child: Text(
                              'Confirm',
                              style: TextStyle(
                                fontSize: ResponsiveUtils.sp(context, 15), // Reduced from 16
                                fontWeight: FontWeight.w500,
                                color: AppColors.lightGreen,
                              ),
                            ),
                          ),
                        ),
                      ),
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

  Widget _buildPayIcon(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getSpacing(context, 4), // Reduced from 6
        vertical: ResponsiveUtils.getSpacing(context, 2), // Reduced from 3
      ),
      decoration: BoxDecoration(
        color: AppColors.darkBlue,
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getBorderRadius(context, 3), // Reduced from 4
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.account_balance_wallet,
            color: Colors.white,
            size: ResponsiveUtils.getIconSize(context, base: 10), // Reduced from 12
          ),
          SizedBox(width: ResponsiveUtils.getSpacing(context, 2)), // Kept at 2
          Text(
            'Pay',
            style: TextStyle(
              color: Colors.white,
              fontSize: ResponsiveUtils.sp(context, 10), // Reduced from 11
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTile({
    required BuildContext context,
    required Widget leadingWidget,
    required String title,
    String? subtitle,
    required bool isSelected,
    bool showAddIcon = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 12)), // Reduced from 16
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.getBorderRadius(context, 8),
          ),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Leading Icon - REDUCED SIZE
            SizedBox(
              width: ResponsiveUtils.adaptive(
                context,
                small: 35.0, // Reduced from 45
                medium: 40.0, // Reduced from 50
                large: 45.0, // Reduced from 55
              ),
              child: leadingWidget,
            ),

            SizedBox(width: ResponsiveUtils.getSpacing(context, 12)), // Reduced from 16

            // Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(context, 15), // Reduced from 16
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: ResponsiveUtils.getSpacing(context, 2)),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 13), // Reduced from 14
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Trailing - REDUCED SIZE
            if (showAddIcon)
              Icon(
                Icons.add,
                size: ResponsiveUtils.getIconSize(context, base: 24), // Reduced from 28
                color: Colors.black87,
              )
            else
              Container(
                width: ResponsiveUtils.adaptive(
                  context,
                  small: 20.0, // Reduced from 22
                  medium: 22.0, // Reduced from 24
                  large: 24.0, // Reduced from 26
                ),
                height: ResponsiveUtils.adaptive(
                  context,
                  small: 20.0, // Reduced from 22
                  medium: 22.0, // Reduced from 24
                  large: 24.0, // Reduced from 26
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.black87 : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? Colors.black87 : Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Icon(
                  Icons.circle,
                  color: Colors.white,
                  size: ResponsiveUtils.getIconSize(context, base: 10), // Reduced from 12
                )
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}