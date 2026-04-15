import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../provider/home_cleaing_provider.dart';

class VoucherWidget extends StatefulWidget {
  final BookingProvider? provider;

  const VoucherWidget({
    Key? key,
    this.provider,
  }) : super(key: key);

  @override
  State<VoucherWidget> createState() => _VoucherWidgetState();
}

class _VoucherWidgetState extends State<VoucherWidget> {
  final List<String> _appliedVouchers = [];

  void _showVoucherModal(BuildContext context) {
    final TextEditingController _voucherController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ResponsiveUtils.getBorderRadius(context, 20)),
            topRight: Radius.circular(ResponsiveUtils.getBorderRadius(context, 20)),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: ResponsiveUtils.getSpacing(context, 24),
            right: ResponsiveUtils.getSpacing(context, 24),
            top: ResponsiveUtils.getSpacing(context, 24),
            bottom: MediaQuery.of(context).viewInsets.bottom + ResponsiveUtils.getSpacing(context, 24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add voucher code",
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(context, 18),
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: AppColors.darkGrey,
                      size: ResponsiveUtils.getIconSize(context, base: 24),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),
              TextField(
                controller: _voucherController,
                decoration: InputDecoration(
                  hintText: "Voucher Code",
                  hintStyle: TextStyle(
                    fontSize: ResponsiveUtils.sp(context, 16),
                    color: AppColors.darkGrey.withOpacity(0.5),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.getSpacing(context, 16),
                    vertical: ResponsiveUtils.getSpacing(context, 16),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getBorderRadius(context, 12),
                    ),
                    borderSide: BorderSide(color: AppColors.appGrey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getBorderRadius(context, 12),
                    ),
                    borderSide: BorderSide(color: AppColors.appGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getBorderRadius(context, 12),
                    ),
                    borderSide: BorderSide(color: AppColors.appGreen, width: 2),
                  ),
                ),
              ),
              SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_voucherController.text.trim().isNotEmpty) {
                      setState(() {
                        _appliedVouchers.add(_voucherController.text.trim());
                      });
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.appGreen,
                    padding: EdgeInsets.symmetric(
                      vertical: ResponsiveUtils.getSpacing(context, 16),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        ResponsiveUtils.getBorderRadius(context, 12),
                      ),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Apply",
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(context, 16),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _removeVoucher(int index) {
    setState(() {
      _appliedVouchers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Add Voucher Code",
          style: TextStyle(
            fontSize: ResponsiveUtils.sp(context, 18),
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),

        // Voucher Input Section - Just show Add button
        InkWell(
          onTap: () => _showVoucherModal(context),
          child: Container(
            padding: EdgeInsets.fromLTRB(
              ResponsiveUtils.getSpacing(context, 15),  // Less left padding
              ResponsiveUtils.getSpacing(context, 8),
              ResponsiveUtils.getSpacing(context, 55), // More right padding
              ResponsiveUtils.getSpacing(context, 15),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.appGrey),
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.getBorderRadius(context, 12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Voucher code",
                  style: TextStyle(
                    fontSize: ResponsiveUtils.sp(context, 14),
                    color:Colors.black,
                  ),
                ),
                SizedBox(height: ResponsiveUtils.getSpacing(context, 8)), // Spacing between text and row
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      color: AppColors.appGreen,
                      size: ResponsiveUtils.getIconSize(context, base: 18),
                    ),
                    SizedBox(width: ResponsiveUtils.getSpacing(context, 8)), // More space between icon and text
                    Text(
                      "Add",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 14),
                        fontWeight: FontWeight.w600,
                        color: AppColors.appGreen,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),


        // Applied Vouchers List
        if (_appliedVouchers.isNotEmpty) ...[
          SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
          Wrap(
            spacing: ResponsiveUtils.getSpacing(context, 8),
            runSpacing: ResponsiveUtils.getSpacing(context, 8),
            children: List.generate(
              _appliedVouchers.length,
                  (index) => _VoucherChip(
                voucherCode: _appliedVouchers[index],
                onRemove: () => _removeVoucher(index),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// Voucher Chip Widget
class _VoucherChip extends StatelessWidget {
  final String voucherCode;
  final VoidCallback onRemove;

  const _VoucherChip({
    required this.voucherCode,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getSpacing(context, 12),
        vertical: ResponsiveUtils.getSpacing(context, 8),
      ),
      decoration: BoxDecoration(
        color: AppColors.appGreen.withOpacity(0.1),
        border: Border.all(
          color: AppColors.appGreen,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getBorderRadius(context, 8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_offer,
            color: AppColors.appGreen,
            size: ResponsiveUtils.getIconSize(context, base: 16),
          ),
          SizedBox(width: ResponsiveUtils.getSpacing(context, 6)),
          Text(
            voucherCode,
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(context, 13),
              fontWeight: FontWeight.w600,
              color: AppColors.appGreen,
            ),
          ),
          SizedBox(width: ResponsiveUtils.getSpacing(context, 8)),
          InkWell(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              color: AppColors.appGreen,
              size: ResponsiveUtils.getIconSize(context, base: 16),
            ),
          ),
        ],
      ),
    );
  }
}