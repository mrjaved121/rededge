import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/features/supr_pay/pages/transaction_detail_page.dart';
import '../../../core/utils/responsive_utils.dart';
import '../provider/supr_pay_provider.dart';
import 'package:suprapp/app/features/supr_pay/pages/select_recipient.dart';
import 'package:suprapp/app/features/supr_pay/pages/split_page.dart';
import 'package:suprapp/app/features/supr_pay/pages/link_page.dart';
import '../../home/widgets/top_sheet.dart';
import 'add_fund_page.dart';
import 'alltransaction_page.dart';
import 'amount_page.dart';
import 'manage_wallet.dart';
import 'outsatanding_payment.dart';


class SuprWalletPage extends StatelessWidget {
  const SuprWalletPage({super.key});

  void _showAddFundsBottomSheet(BuildContext context) {
    String selectedOption = 'Card';

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
                  Container(
                    padding: ResponsiveUtils.responsivePadding(context, horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
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

                  Container(
                    padding: ResponsiveUtils.responsivePadding(context, horizontal: 16, vertical: 8),
                    child: SizedBox(
                      width: double.infinity,
                      height: ResponsiveUtils.getButtonHeight(context, base: 50),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          if (selectedOption == 'Card') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddFundsPage(),
                              ),
                            );
                          } else {
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
                  Container(
                    padding: ResponsiveUtils.responsivePadding(context, horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
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

                  Padding(
                    padding: ResponsiveUtils.responsivePadding(context, horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        SizedBox(
                          width: double.infinity,
                          height: ResponsiveUtils.getButtonHeight(context, base: 50),
                          child: ElevatedButton(
                            onPressed: isButtonActive
                                ? () {
                              String voucherCode = voucherController.text.trim();
                              if (voucherCode.isNotEmpty) {
                                final provider = Provider.of<SuprPayProvider>(context, listen: false);
                                provider.addFunds(1000.0);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Voucher applied: $voucherCode - Rs. 1000 added!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isButtonActive
                                  ? const Color(0xFF0D4D3D)
                                  : Colors.grey.shade400,
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
    return Consumer<SuprPayProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: const Color(0xFFF5F5F5),
            elevation: 0,
            toolbarHeight: ResponsiveUtils.getButtonHeight(context, base: 56),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: ResponsiveUtils.getIconSize(context, base: 30),
                  width: ResponsiveUtils.getIconSize(context, base: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                    borderRadius: BorderRadius.circular(
                        ResponsiveUtils.getBorderRadius(context, 8)
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: ResponsiveUtils.getIconSize(context, base: 20),
                  ),
                ),
              ),
            ),
            title: Text(
              'Pay',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: ResponsiveUtils.adaptive(
                  context,
                  small: 17,
                  medium: 18,
                  large: 19,
                  tablet: 20,
                ),
              ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: 'TopSheet',
                      transitionDuration: const Duration(milliseconds: 300),
                      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
                      transitionBuilder: (_, animation, __, ___) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, -1),
                            end: Offset.zero,
                          ).animate(animation),
                          child: const Align(
                            alignment: Alignment.topCenter,
                            child: TopSheetWidget(),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: ResponsiveUtils.getIconSize(context, base: 40),
                    width: ResponsiveUtils.getIconSize(context, base: 40),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D4D3D),
                      borderRadius: BorderRadius.circular(
                          ResponsiveUtils.getBorderRadius(context, 8)
                      ),
                    ),
                    child: Icon(
                      Icons.menu,
                      color: Colors.green,
                      size: ResponsiveUtils.getIconSize(context, base: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Top Section with Light Grey Background
                Container(
                  height: ResponsiveUtils.hp(context, 27),
                  width: double.infinity,
                  padding: ResponsiveUtils.responsivePadding(context, horizontal: 20, vertical: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'AED',
                            style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.w700,
                              fontSize: ResponsiveUtils.adaptive(
                                context,
                                small: 28,
                                medium: 30,
                                large: 32,
                                tablet: 34,
                              ),
                              letterSpacing: -0.5,
                            ),
                          ),
                          SizedBox(width: ResponsiveUtils.getSpacing(context, 6)),
                          Text(
                            '0',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: ResponsiveUtils.adaptive(
                                context,
                                small: 28,
                                medium: 30,
                                large: 32,
                                tablet: 34,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ManageWalletPage(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Manage wallet',
                              style: TextStyle(
                                color: const Color(0xFF0D4D3D),
                                fontWeight: FontWeight.w900,
                                fontSize: ResponsiveUtils.adaptive(
                                  context,
                                  small: 14,
                                  medium: 15,
                                  large: 16,
                                  tablet: 17,
                                ),
                              ),
                            ),
                            SizedBox(width: ResponsiveUtils.getSpacing(context, 4)),
                            Icon(
                              Icons.arrow_forward,
                              size: ResponsiveUtils.getIconSize(context, base: 22),
                              color: const Color(0xFF0D4D3D),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.hp(context, 6)), // 6% of screen height
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: ResponsiveUtils.getButtonHeight(context, base: 40),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.getBorderRadius(context, 8)
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SelectRecipientScreen(),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(
                                      ResponsiveUtils.getBorderRadius(context, 8)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.arrow_upward,
                                        size: ResponsiveUtils.getIconSize(context, base: 18),
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: ResponsiveUtils.getSpacing(context, 8)),
                                      Text(
                                        'Send credit',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                          fontSize: ResponsiveUtils.adaptive(
                                            context,
                                            small: 10,
                                            medium: 11,
                                            large: 12,
                                            tablet: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
                          Expanded(
                            child: Container(
                              height: ResponsiveUtils.getButtonHeight(context, base: 40),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.getBorderRadius(context, 8)
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EnterAmountPage(),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(
                                      ResponsiveUtils.getBorderRadius(context, 8)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.arrow_downward,
                                        size: ResponsiveUtils.getIconSize(context, base: 18),
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: ResponsiveUtils.getSpacing(context, 8)),
                                      Text(
                                        'Request credit',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                          fontSize: ResponsiveUtils.adaptive(
                                            context,
                                            small: 10,
                                            medium: 11,
                                            large: 12,
                                            tablet: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Quick Actions Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.wp(context, 5), // 5% of screen width
                    vertical: ResponsiveUtils.getSpacing(context, 16),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildQuickAction(
                        context,
                        icon: Icons.qr_code_scanner,
                        label: 'Scan & Pay',
                        iconColor: const Color(0xFF4ECDC4),
                      ),
                      SizedBox(width: ResponsiveUtils.getSpacing(context, 16)),
                      _buildQuickAction(
                        context,
                        icon: Icons.layers,
                        label: 'Get Paid',
                        iconColor: const Color(0xFF95E1D3),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyPayLinksScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: ResponsiveUtils.getSpacing(context, 16)),
                      _buildQuickAction(
                        context,
                        icon: Icons.receipt_long,
                        label: 'Easy Split',
                        iconColor: const Color(0xFFA8E6CF),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SplitHistoryPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Outstanding Payment Banner
                Container(
                  margin: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(context, 5)),
                  padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 10)),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF4E6),
                    border: Border.all(color: const Color(0xFFFFB74D)),
                    borderRadius: BorderRadius.circular(
                        ResponsiveUtils.getBorderRadius(context, 8)
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: ResponsiveUtils.getIconSize(context, base: 25),
                        height: ResponsiveUtils.getIconSize(context, base: 25),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF9800),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.info_outline,
                          color: Colors.white,
                          size: ResponsiveUtils.getIconSize(context, base: 15),
                        ),
                      ),
                      SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pay AED 919.50',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: ResponsiveUtils.adaptive(
                                  context,
                                  small: 10,
                                  medium: 11,
                                  large: 12,
                                  tablet: 13,
                                ),
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.getSpacing(context, 2)),
                            Text(
                              'outstanding from your previous transactions',
                              style: TextStyle(
                                color: Colors.grey.shade900,
                                fontSize: ResponsiveUtils.adaptive(
                                  context,
                                  small: 11,
                                  medium: 12,
                                  large: 13,
                                  tablet: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: ResponsiveUtils.getSpacing(context, 8)),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OutstandingPaymentPage(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveUtils.getSpacing(context, 16),
                            vertical: ResponsiveUtils.getSpacing(context, 8),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                ResponsiveUtils.getBorderRadius(context, 8)
                            ),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            'Settle',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
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
                      ),
                    ],
                  ),
                ),

                SizedBox(height: ResponsiveUtils.hp(context, 5)),

                // Transaction Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(context, 5)),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transactions',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: ResponsiveUtils.adaptive(
                                context,
                                small: 17,
                                medium: 18,
                                large: 19,
                                tablet: 20,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TransactionsPage(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'All',
                                  style: TextStyle(
                                    color: const Color(0xFF0D4D3D),
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
                                SizedBox(width: ResponsiveUtils.getSpacing(context, 4)),
                                Icon(
                                  Icons.arrow_forward,
                                  size: ResponsiveUtils.getIconSize(context, base: 19),
                                  color: const Color(0xFF0D4D3D),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ResponsiveUtils.hp(context, 6)),

                      // Transport Item
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  TransactionDetailPage(
                                  transactionId: 'transaction 123'
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.getSpacing(context, 12)),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: ResponsiveUtils.getIconSize(context, base: 40),
                                height: ResponsiveUtils.getIconSize(context, base: 40),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Icon(
                                        Icons.directions_car,
                                        color: Colors.grey.shade600,
                                        size: ResponsiveUtils.getIconSize(context, base: 20),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: ResponsiveUtils.getIconSize(context, base: 16),
                                        height: ResponsiveUtils.getIconSize(context, base: 16),
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.arrow_upward,
                                          color: Colors.white,
                                          size: ResponsiveUtils.getIconSize(context, base: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Transport',
                                      style: TextStyle(
                                        color: Colors.black,
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
                                    Text(
                                      'Paid',
                                      style: TextStyle(
                                        color: Colors.black,
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
                              ),
                              Text(
                                '- AED 0',
                                style: TextStyle(
                                  color: Colors.grey.shade800,
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
                      ),
                    ],
                  ),
                ),

                SizedBox(height: ResponsiveUtils.hp(context, 2.5)),

                // Wallet Card Section
                Container(
                  width: double.infinity,
                  padding: ResponsiveUtils.responsivePadding(context, horizontal: 20, vertical: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your wallet',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: ResponsiveUtils.adaptive(
                                context,
                                small: 17,
                                medium: 18,
                                large: 19,
                                tablet: 20,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ManageWalletPage(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Manage',
                                  style: TextStyle(
                                    color: const Color(0xFF0D4D3D),
                                    fontWeight: FontWeight.bold,
                                    fontSize: ResponsiveUtils.adaptive(
                                      context,
                                      small: 14,
                                      medium: 15,
                                      large: 16,
                                      tablet: 17,
                                    ),
                                  ),
                                ),
                                SizedBox(width: ResponsiveUtils.getSpacing(context, 4)),
                                Icon(
                                  Icons.arrow_forward,
                                  size: ResponsiveUtils.getIconSize(context, base: 17),
                                  color: const Color(0xFF0D4D3D),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
                      Container(
                        width: double.infinity,
                        height: ResponsiveUtils.hp(context, 18), // 18% of screen height
                        padding: EdgeInsets.all(ResponsiveUtils.wp(context, 5)),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A2540),
                          borderRadius: BorderRadius.circular(
                              ResponsiveUtils.getBorderRadius(context, 12)
                          ),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/card_pattern.png'),
                            fit: BoxFit.cover,
                            opacity: 0.1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AED 0',
                                  style: TextStyle(
                                    color: Colors.white,
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
                                SizedBox(height: ResponsiveUtils.getSpacing(context, 2)),
                                Text(
                                  '${provider.cards.length} card${provider.cards.length != 1 ? 's' : ''}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ResponsiveUtils.adaptive(
                                      context,
                                      small: 11,
                                      medium: 12,
                                      large: 13,
                                      tablet: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: ResponsiveUtils.getButtonHeight(context, base: 42),
                              child: ElevatedButton(
                                onPressed: () {
                                  _showAddFundsBottomSheet(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF0A2540),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        ResponsiveUtils.getBorderRadius(context, 10)
                                    ),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Add funds',
                                  style: TextStyle(
                                    color: const Color(0xFF0A2540),
                                    fontWeight: FontWeight.w900,
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Terms and Conditions
                Container(
                  width: double.infinity,
                  padding: ResponsiveUtils.responsivePadding(context, horizontal: 20, vertical: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: ResponsiveUtils.getSpacing(context, 8)),
                        Text(
                          'Pay',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 9,
                              medium: 10,
                              large: 11,
                              tablet: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: ResponsiveUtils.getSpacing(context, 4)),
                        Text(
                          'Terms and conditions',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 9,
                              medium: 10,
                              large: 11,
                              tablet: 12,
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
      },
    );
  }

  Widget _buildQuickAction(
      BuildContext context, {
        required IconData icon,
        required String label,
        required Color iconColor,
        VoidCallback? onTap,
      }) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: ResponsiveUtils.getIconSize(context, base: 56),
            height: ResponsiveUtils.getIconSize(context, base: 56),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                  ResponsiveUtils.getBorderRadius(context, 12)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: ResponsiveUtils.getIconSize(context, base: 24),
              color: iconColor,
            ),
          ),
          SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: ResponsiveUtils.adaptive(
                context,
                small: 11,
                medium: 12,
                large: 13,
                tablet: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}