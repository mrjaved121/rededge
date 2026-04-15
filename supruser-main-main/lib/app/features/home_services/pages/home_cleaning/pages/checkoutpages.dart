import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/widgets/booking_success_dialog.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/widgets/payment_suumay_widget.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/widgets/voucherwidget.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../provider/home_cleaing_provider.dart' show BookingProvider;
import '../widgets/bootombar.dart';
import '../widgets/customappbar.dart';
import '../widgets/location_header.dart';
import '../widgets/paymentmethodwidget.dart';
import '../widgets/progressbar.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Consumer<BookingProvider>(
          builder: (context, provider, _) {
            final categoryName = provider.currentCategory?.name ?? "Date And Time";
            return CustomAppBar(
              showBackButton: true,
              title: categoryName,
            );
          },
        ),
      ),
      body: Consumer<BookingProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LocationHeaderWidget(
                        provider: provider,
                        showDropdownIcon: false,
                      ),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
                      Text(
                        "Checkout",
                        style: TextStyle(
                          fontSize: ResponsiveUtils.sp(context, 24),
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 10)),
                      ProgressBarWidget(currentStep: 3),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 30)),
                      PaymentMethodWidget(provider: provider),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 30)),
                      VoucherWidget(provider: provider),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 30)),
                      PaymentSummaryWidget(provider: provider),
                    ],
                  ),
                ),
              ),
              BottomBarWidget(
                provider: provider,
                buttonText: "Continue",
                onNext: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BookingSuccessDialog()),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
