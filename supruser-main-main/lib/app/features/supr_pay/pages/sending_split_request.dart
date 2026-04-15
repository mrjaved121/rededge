import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/responsive_utils.dart';
import 'expense_success.dart';

class SendingSplitRequestPage extends StatefulWidget {
  final double amount;
  final String description;
  final List<Map<String, dynamic>> splits;
  final String customMessage;

  const SendingSplitRequestPage({
    Key? key,
    required this.amount,
    required this.description,
    required this.splits,
    required this.customMessage,
  }) : super(key: key);

  @override
  State<SendingSplitRequestPage> createState() => _SendingSplitRequestPageState();
}

class _SendingSplitRequestPageState extends State<SendingSplitRequestPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ExpenseSuccessPage(
              amount: widget.amount,
              description: widget.description,
              splits: widget.splits,
              customMessage: widget.customMessage,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: ResponsiveUtils.getIconSize(context, base: 40),
              height: ResponsiveUtils.getIconSize(context, base: 40),
              child: CircularProgressIndicator(
                color: const Color(0xFF34C759),
                strokeWidth: ResponsiveUtils.adaptive(
                  context,
                  small: 3.0,
                  medium: 3.5,
                  large: 4.0,
                  tablet: 4.5,
                ),
              ),
            ),
            SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),
            Text(
              'Sending split request...',
              style: TextStyle(
                fontSize: ResponsiveUtils.adaptive(
                  context,
                  small: 16,
                  medium: 18,
                  large: 20,
                  tablet: 22,
                ),
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}