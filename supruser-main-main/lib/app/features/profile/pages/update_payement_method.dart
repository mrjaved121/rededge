import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/routes/go_router.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

class UpdatePaymentScreen extends StatefulWidget {
  @override
  State<UpdatePaymentScreen> createState() => _UpdatePaymentScreenState();
}

class _UpdatePaymentScreenState extends State<UpdatePaymentScreen> {
  String? selectedPayment = 'Cash'; // Only one option selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              context.pop();
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.appGrey),
                  borderRadius: BorderRadius.circular(7)),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.darkGrey,
                size: 20,
              ),
            ),
          ),
        ),
        title: Text(
          'UPDATE PAYMENT METHOD',
          style: textTheme(context).titleMedium?.copyWith(
                color: colorScheme(context).onSurface,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a different payment method for your\nbusiness rides, or stick to your default.',
              style: textTheme(context).bodyLarge?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.2),
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedPayment = 'Cash';
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.attach_money, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'Cash',
                        style: textTheme(context).titleSmall?.copyWith(
                              color: colorScheme(context).onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  if (selectedPayment == 'Cash')
                    Icon(Icons.check, color: colorScheme(context).primary),
                ],
              ),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                context.pushNamed(AppRoute.addBankPage);
              },
              child: Row(
                children: [
                  Icon(Icons.add, color: colorScheme(context).primary),
                  SizedBox(width: 8),
                  Text(
                    'ADD CREDIT CARD',
                    style: textTheme(context).bodyMedium?.copyWith(
                          color: colorScheme(context).primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            Spacer(),
            CustomElevatedButton(
              text: 'Save',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
