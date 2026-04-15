import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/widgets/customappbar.dart';
import 'laundaryordermodel.dart';

class LaundaryCheckoutPage extends StatefulWidget {
  final double totalAmount;
  final Map<String, dynamic> orderDetails;

  const LaundaryCheckoutPage({
    Key? key,
    required this.totalAmount,
    required this.orderDetails,
  }) : super(key: key);

  @override
  State<LaundaryCheckoutPage> createState() => _LaundaryCheckoutPageState();
}

class _LaundaryCheckoutPageState extends State<LaundaryCheckoutPage> {
  int selectedTip = 0;
  TextEditingController promoController = TextEditingController();
  bool promoApplied = false;
  double promoDiscount = 0;
  bool showOrderItems = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:CustomAppBar(title: "Laundry", showBackButton: true),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Progress indicator
                Container(
                  height: 4,
                  margin: EdgeInsets.symmetric(horizontal: width * 0.045),
                  child: LinearProgressIndicator(
                    value: 1.0,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF00E676)),
                  ),
                ),
                SizedBox(height: height * 0.027),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.045),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        'Last Step',
                        style: TextStyle(
                          fontSize: width * 0.063,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: height * 0.027),

                      // Order Summary
                      _buildOrderSummary(context, width),
                      SizedBox(height: height * 0.036),

                      // Tip Your Captain
                      _buildTipSection(context, width),
                      SizedBox(height: height * 0.036),

                      // Promocode
                      _buildPromocodeSection(context, width),
                      SizedBox(height: height * 0.036),

                      // Payment Summary
                      _buildPaymentSummary(context, width, height),
                      SizedBox(height: height * 0.18),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Place Order button at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(width * 0.045),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: ElevatedButton(
                onPressed: _placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E676),
                  minimumSize: Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: width * 0.036,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, double width) {
    return Container(
      padding: EdgeInsets.all(width * 0.036),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: width * 0.041,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit, size: width * 0.045),
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: width * 0.018),
          _buildSummaryRow(
            context,
            width,
            Icons.location_on,
            widget.orderDetails['address'] ?? 'Hotel, The Villa, 45, -, vb',
          ),
          SizedBox(height: width * 0.018),
          _buildSummaryRow(
            context,
            width,
            Icons.access_time,
            'Collection ${widget.orderDetails['collectionDate']}, ${widget.orderDetails['collectionTime']}',
          ),
          SizedBox(height: width * 0.018),
          _buildSummaryRow(
            context,
            width,
            Icons.calendar_today,
            'Laundry Delivery ${widget.orderDetails['deliveryDate']}, ${widget.orderDetails['deliveryTime']}',
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, double width, IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: width * 0.041, color: Colors.grey.shade600),
        SizedBox(width: width * 0.018),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: width * 0.029,
              color: Colors.grey.shade700,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTipSection(BuildContext context, double width) {
    final tips = [3, 5, 10];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tip Your Captain',
          style: TextStyle(
            fontSize: width * 0.041,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        SizedBox(height: width * 0.027),
        Row(
          children: tips.map((tip) {
            bool isSelected = selectedTip == tip;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTip = isSelected ? 0 : tip;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: width * 0.018),
                  padding: EdgeInsets.symmetric(vertical: width * 0.027),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFE8F5E9) : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF00E676) : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Text(
                    'AED $tip',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? const Color(0xFF00E676) : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPromocodeSection(BuildContext context, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Promocode',
          style: TextStyle(
            fontSize: width * 0.041,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        SizedBox(height: width * 0.027),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.036),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: promoController,
                  decoration: InputDecoration(
                    hintText: 'Enter Code',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: width * 0.032,
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: width * 0.032,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(width: width * 0.027),
            GestureDetector(
              onTap: _applyPromocode,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.045,
                  vertical: width * 0.032,
                ),
                decoration: BoxDecoration(
                  color: promoApplied ? Colors.green : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  promoApplied ? 'Applied' : 'Apply',
                  style: TextStyle(
                    fontSize: width * 0.032,
                    fontWeight: FontWeight.w700,
                    color: promoApplied ? Colors.white : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (promoApplied)
          Padding(
            padding: EdgeInsets.only(top: width * 0.018),
            child: Text(
              '✓ Promo code applied successfully!',
              style: TextStyle(
                fontSize: width * 0.027,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  // ✅ SINGLE PAYMENT SUMMARY METHOD (NO DUPLICATES)
  Widget _buildPaymentSummary(BuildContext context, double width, double height) {
    final subtotal = _calculateSubtotal();
    final deliveryFee = 9.50;
    final tip = selectedTip.toDouble();
    final discount = promoDiscount;
    final vat = (subtotal + deliveryFee + tip - discount) * 0.05;
    final total = subtotal + deliveryFee + tip - discount + vat;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Summary',
          style: TextStyle(
            fontSize: width * 0.041,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        SizedBox(height: width * 0.027),
        Container(
          padding: EdgeInsets.all(width * 0.036),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    showOrderItems = !showOrderItems;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: TextStyle(
                        fontSize: width * 0.032,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'AED ${subtotal.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: width * 0.032,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: width * 0.018),
                        Icon(
                          showOrderItems ? Icons.expand_less : Icons.expand_more,
                          size: width * 0.045,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (showOrderItems) ...[
                SizedBox(height: width * 0.018),
                Divider(color: Colors.grey.shade300),
                SizedBox(height: width * 0.018),
                ..._buildOrderItemsList(context, width),
              ],
              SizedBox(height: width * 0.027),
              _buildPaymentRow(context, width, 'Delivery fee', deliveryFee),
              if (tip > 0) ...[
                SizedBox(height: width * 0.027),
                _buildPaymentRow(context, width, 'Tip', tip),
              ],
              if (discount > 0) ...[
                SizedBox(height: width * 0.027),
                _buildPaymentRow(context, width, 'Promo Discount', -discount, isDiscount: true),
              ],
              SizedBox(height: width * 0.027),
              Divider(color: Colors.grey.shade300),
              SizedBox(height: width * 0.027),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Estimated Total (incl. VAT)',
                    style: TextStyle(
                      fontSize: width * 0.036,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'AED ${total.toStringAsFixed(2)}*',
                    style: TextStyle(
                      fontSize: width * 0.041,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF1B5E20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: width * 0.027),
        Container(
          padding: EdgeInsets.all(width * 0.036),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '*',
                style: TextStyle(
                  fontSize: width * 0.032,
                  color: const Color(0xFFE65100),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: width * 0.018),
              Expanded(
                child: Text(
                  'This is just an estimate. The final amount will be determined when your items are counted at Washmen\'s facility',
                  style: TextStyle(
                    fontSize: width * 0.027,
                    color: const Color(0xFFE65100),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: width * 0.027),
        Text(
          'We will authorize and immediately refund AED 1.',
          style: TextStyle(
            fontSize: width * 0.027,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentRow(BuildContext context, double width, String label, double amount, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: width * 0.032,
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          '${isDiscount ? '-' : ''}AED ${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: width * 0.032,
            fontWeight: FontWeight.w600,
            color: isDiscount ? Colors.green : Colors.black,
          ),
        ),
      ],
    );
  }

  // ✅ ORDER ITEMS LIST WITH ERROR HANDLING
  List<Widget> _buildOrderItemsList(BuildContext context, double width) {
    List<Widget> itemWidgets = [];

    try {
      final orderData = LaundryOrderData.fromMap(widget.orderDetails);
      final displayItems = orderData.getAllItemsForDisplay();

      if (displayItems.isEmpty) {
        return [
          Padding(
            padding: EdgeInsets.symmetric(vertical: width * 0.036),
            child: Text(
              'No items in order',
              style: TextStyle(
                fontSize: width * 0.029,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ];
      }

      for (var item in displayItems) {
        itemWidgets.add(
          Padding(
            padding: EdgeInsets.only(bottom: width * 0.018),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item.name} x${item.quantity}',
                        style: TextStyle(
                          fontSize: width * 0.029,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (item.category.isNotEmpty)
                        Text(
                          item.category,
                          style: TextStyle(
                            fontSize: width * 0.024,
                            color: Colors.grey.shade500,
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  'AED ${item.total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: width * 0.029,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    } catch (e) {
      print('Error parsing order items: $e');
      itemWidgets.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: width * 0.036),
          child: Text(
            'Error loading order items',
            style: TextStyle(
              fontSize: width * 0.029,
              color: Colors.red.shade600,
            ),
          ),
        ),
      );
    }

    return itemWidgets;
  }

  // ✅ CALCULATE SUBTOTAL HELPER
  double _calculateSubtotal() {
    try {
      final orderData = LaundryOrderData.fromMap(widget.orderDetails);
      return LaundryPriceCalculator.calculateTotal(orderData);
    } catch (e) {
      print('Error calculating subtotal: $e');
      return widget.totalAmount;
    }
  }

  void _applyPromocode() {
    final code = promoController.text.trim().toUpperCase();

    if (code == 'CAREEM30') {
      setState(() {
        promoApplied = true;
        promoDiscount = 30.0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Promo code applied! AED 30 discount'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } else if (code.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid promo code'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _placeOrder() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.054),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF00E676)),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.036),
              Text(
                'Placing your order...',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.036,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: MediaQuery.of(context).size.width * 0.18,
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.036),
              Text(
                'Order Placed Successfully!',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.018),
              Text(
                'Your order has been confirmed. We\'ll send you updates.',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.029,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                'Done',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.036,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF00E676),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    promoController.dispose();
    super.dispose();
  }
}