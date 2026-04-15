import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/widgets/dateselectionwidget.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/widgets/instructionfieldwidget.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/widgets/timeselectionwidget.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../provider/home_cleaing_provider.dart';
import '../widgets/bootombar.dart';
import '../widgets/cancellationpolicysheet.dart';
import '../widgets/customappbar.dart';
import '../widgets/frequency_selector_widget.dart';
import '../widgets/location_header.dart' show LocationHeaderWidget;
import '../widgets/progressbar.dart';
import 'checkoutpages.dart' show CheckoutPage;

class DateTimePage extends StatelessWidget {
  const DateTimePage({super.key});

  // ✅ Switch case: Frequency show karna hai ya nahi
  bool _shouldShowFrequency(String? categoryId) {
    if (categoryId == null) return true; // Default: show frequency

    switch (categoryId) {
    // ✅ Categories with frequency
      case 'ac_cleaning':
      case 'deep_cleaning':
      case 'furniture_cleaning':
      case 'pest_control':
        return true;

    // ✅ Categories WITHOUT frequency
      case 'iv_therapy':
      case 'lab_tests':
      case 'packers_movers':
        return false;

    // ✅ Default: show frequency
      default:
        return true;
    }
  }

  // ✅ Alternative widget for categories without frequency
  Widget _getAlternativeWidget(BuildContext context, String? categoryId) {
    if (categoryId == null) return SizedBox.shrink();

    switch (categoryId) {
      // case 'iv_therapy':
      //   return _buildIVTherapyOptions(context);

      // case 'lab_tests':
      //   return _buildLabTestOptions(context);

      // case 'packers_movers':
      //   return _buildPackersMoversOptions(context);

      default:
        return SizedBox.shrink();
    }
  }



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
          final categoryId = provider.currentCategory?.id;
          final showFrequency = _shouldShowFrequency(categoryId);

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(
                      ResponsiveUtils.getSpacing(context, 20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LocationHeaderWidget(provider: provider),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 10)),
                      Text(
                        "Date & time",
                        style: TextStyle(
                          fontSize: ResponsiveUtils.sp(context, 20),
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 10)),
                      ProgressBarWidget(currentStep: 2),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
                      Text(
                        "Next step: Checkout",
                        style: TextStyle(
                            fontSize: ResponsiveUtils.sp(context, 12),
                            color: Colors.black
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),

                      // ✅ Conditional: Frequency ya Alternative Widget
                      if (showFrequency) ...[
                        FrequencySelectorWidget(
                          provider: provider,
                          onFrequencyChanged: (frequency) {},
                        ),
                        SizedBox(height: ResponsiveUtils.getSpacing(context, 17)),
                      ] else ...[
                        _getAlternativeWidget(context, categoryId),
                        SizedBox(height: ResponsiveUtils.getSpacing(context, 17)),
                      ],

                      DateSelectionWidget(provider: provider),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 10)),
                      TimeSelectionWidget(provider: provider),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 20)),
                      CancellationPolicyWidget(),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 20)),
                      InstructionsFieldWidget(),
                    ],
                  ),
                ),
              ),
              BottomBarWidget(
                provider: provider,
                buttonText: "Next",
                onNext: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CheckoutPage()),
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