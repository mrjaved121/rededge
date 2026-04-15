import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/routes/go_router.dart';

class TermsConditionPage extends StatelessWidget {
  const TermsConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        centerTitle: true,
        title: Text(
          'Terms and conditions',
          style: textTheme(context).titleMedium?.copyWith(
                color: colorScheme(context).onSurface,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '1. Subscription Plans We offer various subscription plans with different features and durations. Details of each plan, including pricing, benefits, and validity, are displayed clearly at the time of purchase.',
              style: textTheme(context).bodyLarge?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '2. Payment & Billing All payments are charged to your selected payment method through the app store (Google Play or Apple App Store). Your subscription will automatically renew unless you cancel it at least 24 hours before the end of the current billing period. Renewal charges will be applied within 24 hours prior to the end of the subscription period.',
              style: textTheme(context).bodyLarge?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '3. Cancellation You can cancel your subscription at any time via your account settings in the app store. Upon cancellation, you will still have access to the premium features until the current billing period ends. No refunds will be issued for the remaining period.',
              style: textTheme(context).bodyLarge?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '4. For any questions or support regarding subscriptions, please contact us at: Email: support@yourapp.com',
              style: textTheme(context).bodyLarge?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
