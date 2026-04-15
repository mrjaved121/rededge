import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/pages/addonespages.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/provider/home_cleaing_provider.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/widgets/bootombar.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/widgets/customappbar.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/widgets/exclusive_offer.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/widgets/hourssection.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/widgets/location_header.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/widgets/materials_section.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/widgets/professional_section.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/widgets/progressbar.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';

class HomeCleaningPage extends StatefulWidget {
  const HomeCleaningPage({super.key});

  @override
  State<HomeCleaningPage> createState() => _HomeCleaningPageState();
}

class _HomeCleaningPageState extends State<HomeCleaningPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<BookingProvider>();
      provider.resetBookingDetails();
      provider.resetDateTime();
      provider.resetAddOns();
      provider.setIsHomeCleaningService(true);
    });
  }

  void _handleBackNavigation(BuildContext context) {
    final provider = context.read<BookingProvider>();
    provider.resetAll();
    provider.setIsHomeCleaningService(false);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final provider = context.read<BookingProvider>();
        provider.resetAll();
        provider.setIsHomeCleaningService(false);

        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          showBackButton: true,
          title: "Home Cleaning",
          onBackPressed: () {

            _handleBackNavigation(context);
          },
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
                        LocationHeaderWidget(provider: provider),
                        SizedBox(height: ResponsiveUtils.getSpacing(context, 10)),
                        Text(
                          "Service details",
                          style: TextStyle(
                            fontSize: ResponsiveUtils.sp(context, 24),
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: ResponsiveUtils.getSpacing(context, 4)),
                        const ProgressBarWidget(currentStep: 0),
                        SizedBox(height: ResponsiveUtils.getSpacing(context, 4)),
                        Text(
                          "Next step: Popular add-ons",
                          style: TextStyle(
                            fontSize: ResponsiveUtils.sp(context, 12),
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
                        ExclusiveOfferWidget(provider: provider),
                        SizedBox(height: ResponsiveUtils.getSpacing(context, 25)),
                        HoursSelectionWidget(provider: provider),
                        SizedBox(height: ResponsiveUtils.getSpacing(context, 30)),
                        ProfessionalsSelectionWidget(provider: provider),
                        SizedBox(height: ResponsiveUtils.getSpacing(context, 30)),
                        MaterialsSelectionWidget(provider: provider),
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
                      MaterialPageRoute(builder: (_) => const AddOnsPage()),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
