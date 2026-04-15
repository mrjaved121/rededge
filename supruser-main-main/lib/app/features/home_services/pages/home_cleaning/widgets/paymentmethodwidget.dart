import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../provider/home_cleaing_provider.dart';

class PaymentMethodWidget extends StatefulWidget {
  final BookingProvider? provider;

  const PaymentMethodWidget({
    Key? key,
    this.provider,
  }) : super(key: key);

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, _) {
        final activeProvider = widget.provider ?? bookingProvider;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment method",
              style: TextStyle(
                fontSize: ResponsiveUtils.sp(context, 18),
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
            InkWell(
              onTap: () => _showPaymentModal(context, activeProvider),
              child: Container(
                padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getBorderRadius(context, 12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.darkGrey.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.payment,
                      color: Colors.black,
                      size: ResponsiveUtils.getIconSize(context, base: 20),
                    ),
                    SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
                    Expanded(
                      child: Text(
                        activeProvider.paymentMethod,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.sp(context, 14),
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                      size: ResponsiveUtils.getIconSize(context, base: 22),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentModal(BuildContext context, BookingProvider provider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.45,
              minChildSize: 0.3,
              maxChildSize: 0.8,
              expand: false,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffF5F5F5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
                  child: Column(
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Change payment method",
                            style: TextStyle(
                              fontSize: ResponsiveUtils.sp(context, 18),
                              fontWeight: FontWeight.w900,
                              color: Colors.black87,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.close,
                              color: Colors.black87,
                              size: ResponsiveUtils.getIconSize(context, base: 24),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),

                      // Scrollable content
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            children: [
                              _buildPaymentTile(
                                context: context,
                                provider: provider,
                                method: "Pay with Supr Pay",
                                icon: Icons.payment,
                                setModalState: setModalState,
                              ),
                              _buildPaymentTile(
                                context: context,
                                provider: provider,
                                method: "Cash (+5 AED)",
                                icon: Icons.money,
                                setModalState: setModalState,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Bottom Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkGreen,
                            padding: EdgeInsets.symmetric(
                              vertical: ResponsiveUtils.getSpacing(context, 14),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                ResponsiveUtils.getBorderRadius(context, 12),
                              ),
                            ),
                          ),
                          child: Text(
                            "Select Payment Method",
                            style: TextStyle(
                              fontSize: ResponsiveUtils.sp(context, 16),
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildPaymentTile({
    required BuildContext context,
    required BookingProvider provider,
    required String method,
    required IconData icon,
    required StateSetter setModalState,
  }) {
    final isSelected = provider.paymentMethod == method;

    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveUtils.getSpacing(context, 12)),
      child: InkWell(
        onTap: () {
          provider.setPaymentMethod(method);
          setModalState(() {}); // Update modal UI
          setState(() {}); // Update main widget UI
        },
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getBorderRadius(context, 12),
        ),
        child: Container(
          padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 12)),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFDCFCE7) : Colors.white,
            border: Border.all(
              color: isSelected ? AppColors.appGreen : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.getBorderRadius(context, 12),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black87,
                size: ResponsiveUtils.getIconSize(context, base: 24),
              ),
              SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
              Expanded(
                child: Text(
                  method,
                  style: TextStyle(
                    fontSize: ResponsiveUtils.sp(context, 14),
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                width: ResponsiveUtils.wp(context, 6),
                height: ResponsiveUtils.wp(context, 6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.appGreen : Colors.grey.shade400,
                    width: 2,
                  ),
                  color: isSelected ? AppColors.appGreen : Colors.white,
                ),
                child: isSelected
                    ? Icon(
                  Icons.check,
                  color: Colors.white,
                  size: ResponsiveUtils.getIconSize(context, base: 12),
                )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}