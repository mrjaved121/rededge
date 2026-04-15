import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/global_variables.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../shared/widgets/custom_elevated_button.dart';
import 'add_card_page.dart';
import 'add_fund_page.dart';


class ManageWalletPage extends StatelessWidget {
  const ManageWalletPage({super.key});

  void _showAddFundsBottomSheet(BuildContext context) {
    // Track the selected option
    String selectedOption = 'Card'; // Default selection

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              margin: EdgeInsets.only(top: ResponsiveUtils.hp(context, 6)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ResponsiveUtils.getBorderRadius(context, 20)),
                  topRight: Radius.circular(ResponsiveUtils.getBorderRadius(context, 20)),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with close button
                  Container(
                    padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: ResponsiveUtils.getSpacing(context, 40)),
                        Expanded(
                          child: Text(
                            'Add funds from',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: ResponsiveUtils.adaptive(
                                context,
                                small: 15,
                                medium: 16,
                                large: 17,
                                tablet: 18,
                              ),
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ResponsiveUtils.getSpacing(context, 40),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.grey.shade600,
                              size: ResponsiveUtils.getIconSize(context, base: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Card Option with Radio
                  _buildOptionWithRadio(
                    context,
                    icon: Icons.credit_card,
                    title: 'Card',
                    isSelected: selectedOption == 'Card',
                    onTap: () {
                      setState(() {
                        selectedOption = 'Card';
                      });
                    },
                  ),

                  // Voucher Option with Radio
                  _buildOptionWithRadio(
                    context,
                    icon: Icons.card_giftcard,
                    title: 'Voucher',
                    isSelected: selectedOption == 'Voucher',
                    onTap: () {
                      setState(() {
                        selectedOption = 'Voucher';
                      });
                    },
                  ),

                  SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),

                  // Next Button
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.getSpacing(context, 16),
                      vertical: ResponsiveUtils.getSpacing(context, 8),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: ResponsiveUtils.getButtonHeight(context, base: 50),
                      child: ElevatedButton(
                        onPressed: () {
                          // First close the current bottom sheet
                          Navigator.pop(context);

                          // Handle navigation based on selection
                          if (selectedOption == 'Card') {
                            // Navigate to AddFundsPage for card
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddFundsPage(),
                              ),
                            );
                          } else {
                            // Show voucher bottom sheet
                            _showVoucherBottomSheet(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D4D3D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                ResponsiveUtils.getBorderRadius(context, 12)
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Next',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 15,
                              medium: 16,
                              large: 17,
                              tablet: 18,
                            ),
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Voucher bottom sheet method
  void _showVoucherBottomSheet(BuildContext context) {
    TextEditingController voucherController = TextEditingController();
    bool isButtonActive = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              margin: EdgeInsets.only(top: ResponsiveUtils.hp(context, 6)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ResponsiveUtils.getBorderRadius(context, 20)),
                  topRight: Radius.circular(ResponsiveUtils.getBorderRadius(context, 20)),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with close button
                  Container(
                    padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: ResponsiveUtils.getSpacing(context, 40)),
                        Expanded(
                          child: Text(
                            'Apply Voucher',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: ResponsiveUtils.adaptive(
                                context,
                                small: 15,
                                medium: 16,
                                large: 17,
                                tablet: 18,
                              ),
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ResponsiveUtils.getSpacing(context, 40),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.grey.shade600,
                              size: ResponsiveUtils.getIconSize(context, base: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Voucher input section
                  Padding(
                    padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Bold "Apply Voucher" text
                        Text(
                          'Apply Voucher',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 17,
                              medium: 18,
                              large: 19,
                              tablet: 20,
                            ),
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),

                        // Description text
                        Text(
                          'Enter voucher code to add money to your Careem wallet',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 13,
                              medium: 14,
                              large: 15,
                              tablet: 16,
                            ),
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: ResponsiveUtils.getSpacing(context, 20)),

                        // Voucher input field
                        Container(
                          height: ResponsiveUtils.getButtonHeight(context, base: 50),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(
                                ResponsiveUtils.getBorderRadius(context, 8)
                            ),
                          ),
                          child: TextField(
                            controller: voucherController,
                            decoration: InputDecoration(
                              hintText: 'Type here ...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: ResponsiveUtils.getSpacing(context, 12)
                              ),
                              hintStyle: TextStyle(
                                fontSize: ResponsiveUtils.adaptive(
                                  context,
                                  small: 14,
                                  medium: 15,
                                  large: 16,
                                  tablet: 17,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                isButtonActive = value.trim().isNotEmpty;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
                        Text(
                          'Enter or paste voucher code',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 11,
                              medium: 12,
                              large: 13,
                              tablet: 14,
                            ),
                            color: Colors.grey.shade500,
                          ),
                        ),
                        SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),

                        // Apply code button
                        SizedBox(
                          width: double.infinity,
                          height: ResponsiveUtils.getButtonHeight(context, base: 50),
                          child: ElevatedButton(
                            onPressed: isButtonActive
                                ? () {
                              // Handle voucher application logic here
                              String voucherCode = voucherController.text.trim();
                              if (voucherCode.isNotEmpty) {
                                // Apply voucher logic
                                print('Applying voucher: $voucherCode');
                                // You can add your voucher validation and application logic here

                                // Close the bottom sheet after applying
                                Navigator.pop(context);

                                // Show success message or navigate accordingly
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Voucher applied: $voucherCode'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isButtonActive
                                  ? const Color(0xFF0D4D3D) // Green when active
                                  : Colors.grey.shade400, // Grey when inactive
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.getBorderRadius(context, 12)
                                ),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Apply code',
                              style: TextStyle(
                                fontSize: ResponsiveUtils.adaptive(
                                  context,
                                  small: 15,
                                  medium: 16,
                                  large: 17,
                                  tablet: 18,
                                ),
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.getSpacing(context, 30)),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildOptionWithRadio(
      BuildContext context, {
        required IconData icon,
        required String title,
        required bool isSelected,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.getSpacing(context, 16),
          vertical: ResponsiveUtils.getSpacing(context, 16),
        ),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          children: [
            // Icon without background color
            Icon(
              icon,
              color: Colors.grey.shade700,
              size: ResponsiveUtils.getIconSize(context, base: 24),
            ),
            SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
            Text(
              title,
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
            const Spacer(),
            // Radio button for selection
            Container(
              width: ResponsiveUtils.getIconSize(context, base: 20),
              height: ResponsiveUtils.getIconSize(context, base: 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF0D4D3D) : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Container(
                margin: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 4)),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF0D4D3D),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D2847),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D2847),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getBorderRadius(context, 12)
                ),
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: ResponsiveUtils.getIconSize(context, base: 14),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                width: ResponsiveUtils.getIconSize(context, base: 45),
                height: ResponsiveUtils.getIconSize(context, base: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getBorderRadius(context, 8)
                  ),
                ),
                child: Icon(
                  Icons.info_outline,
                  color: Colors.black,
                  size: ResponsiveUtils.getIconSize(context, base: 15),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Top section with balance
          Container(
            width: double.infinity,
            height: ResponsiveUtils.hp(context, 28), // 28% of screen height
            color: const Color(0xFF0D2847),
            child: Column(
              children: [
                Text(
                  'Wallet Balance',
                  style: textTheme(context).titleMedium?.copyWith(
                      color: Colors.white,
                      fontSize: ResponsiveUtils.adaptive(
                        context,
                        small: 15,
                        medium: 16,
                        large: 17,
                        tablet: 18,
                      ),
                      fontWeight: FontWeight.w900
                  ),
                ),
                SizedBox(height: ResponsiveUtils.hp(context, 1.5)),
                Text(
                  'PKR 0',
                  style: textTheme(context).displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: ResponsiveUtils.adaptive(
                      context,
                      small: 32,
                      medium: 36,
                      large: 40,
                      tablet: 44,
                    ),
                  ),
                ),
                SizedBox(height: ResponsiveUtils.hp(context, 1.5)),
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View wallet statement',
                        style: textTheme(context).bodyMedium?.copyWith(
                            color: Colors.white,
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 16,
                              medium: 18,
                              large: 20,
                              tablet: 22,
                            ),
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width: ResponsiveUtils.getSpacing(context, 8)),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: ResponsiveUtils.getIconSize(context, base: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ResponsiveUtils.hp(context, 2)),
                SizedBox(
                  height: ResponsiveUtils.getButtonHeight(context, base: 40),
                  width: ResponsiveUtils.wp(context, 80), // 80% of screen width
                  child: CustomElevatedButton(
                    text: 'Add funds',
                    onPressed: () {
                      _showAddFundsBottomSheet(context);
                    },
                    buttonColor: Colors.white,
                    textStyle: textTheme(context).titleMedium?.copyWith(
                      color: const Color(0xFF1A3A52),
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveUtils.adaptive(
                        context,
                        small: 13,
                        medium: 14,
                        large: 15,
                        tablet: 16,
                      ),
                    ),
                    borderRadius: ResponsiveUtils.getBorderRadius(context, 12),
                    height: ResponsiveUtils.getButtonHeight(context, base: 50),
                  ),
                ),
              ],
            ),
          ),

          // Cards section
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cards',
                      style: textTheme(context).titleLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: ResponsiveUtils.adaptive(
                          context,
                          small: 18,
                          medium: 20,
                          large: 22,
                          tablet: 24,
                        ),
                      ),
                    ),
                    SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 20)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            ResponsiveUtils.getBorderRadius(context, 16)
                        ),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
                              Padding(
                                padding: EdgeInsets.only(top: ResponsiveUtils.getSpacing(context, 1)),
                                child: Text(
                                  'No cards added',
                                  style: textTheme(context).titleMedium?.copyWith(
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
                              ),
                              SizedBox(height: ResponsiveUtils.getSpacing(context, 3)),
                              Padding(
                                padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 8)),
                                child: Text(
                                  'Add card to enjoy a seamless\npayment experience',
                                  textAlign: TextAlign.center,
                                  style: textTheme(context).bodyMedium?.copyWith(
                                    color: Colors.black54,
                                    fontSize: ResponsiveUtils.adaptive(
                                      context,
                                      small: 12,
                                      medium: 13,
                                      large: 14,
                                      tablet: 15,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AddCardPage(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          ResponsiveUtils.getBorderRadius(context, 12)
                                      ),
                                      side: const BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: ResponsiveUtils.getSpacing(context, 12)
                                    ),
                                  ),
                                  child: Text(
                                    'Add a card',
                                    style: textTheme(context).titleMedium?.copyWith(
                                      color: Colors.black,
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
                                ),
                              ),
                            ],
                          ),
                          // Credit card icon in top-left corner
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              width: ResponsiveUtils.getIconSize(context, base: 50),
                              height: ResponsiveUtils.getIconSize(context, base: 50),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.getBorderRadius(context, 12)
                                ),
                              ),
                              child: Icon(
                                Icons.credit_card,
                                size: ResponsiveUtils.getIconSize(context, base: 30),
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ResponsiveUtils.getSpacing(context, 32)),
                    Row(
                      children: [
                        Container(
                          width: ResponsiveUtils.getIconSize(context, base: 24),
                          height: ResponsiveUtils.getIconSize(context, base: 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                ResponsiveUtils.getBorderRadius(context, 6)
                            ),
                          ),
                          child: Icon(
                            Icons.check,
                            color: const Color(0xFF0D2847),
                            size: ResponsiveUtils.getIconSize(context, base: 16),
                          ),
                        ),
                        SizedBox(width: ResponsiveUtils.getSpacing(context, 2)),
                        Text(
                          'Your payment info is stored securely',
                          style: textTheme(context).bodyMedium?.copyWith(
                            color: Colors.black87,
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 12,
                              medium: 13,
                              large: 14,
                              tablet: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}