import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../provider/home_cleaing_provider.dart';
import '../widgets/addoncardwidget.dart';
import '../widgets/bootombar.dart';
import '../widgets/customappbar.dart';
import '../widgets/location_header.dart';
import '../widgets/progressbar.dart';
import 'dataandtime.dart';

class AddOnsPage extends StatelessWidget {
  final String? categoryId;

  const AddOnsPage({
    super.key,
    this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Consumer<BookingProvider>(
          builder: (context, provider, _) {
            final categoryName = provider.currentCategory?.name ?? "Home Cleaning";
            return CustomAppBar(
              showBackButton: true,
              title: categoryName,
            );
          },
        ),
      ),
      body: Consumer<BookingProvider>(
        builder: (context, provider, _) {
          final addOns = provider.currentCategory?.addOns ?? _getDefaultAddOns();
          if (addOns.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline, size: 64, color: AppColors.appGrey),
                  SizedBox(height: 16),
                  Text(
                    "No add-ons available",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.darkGrey,
                    ),
                  ),
                ],
              ),
            );
          }

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
                        "Popular add-ons",
                        style: TextStyle(
                          fontSize: ResponsiveUtils.sp(context, 24),
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 10)),
                      ProgressBarWidget(currentStep: 1),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
                      Text(
                        "Next step: Date & time",
                        style: TextStyle(
                          fontSize: ResponsiveUtils.sp(context, 14),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 25)),
                      Text(
                        "People also added",
                        style: TextStyle(
                          fontSize: ResponsiveUtils.sp(context, 16),
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Consumer<BookingProvider>(
                          builder: (context, provider, _) {

                            return Row(
                              children: addOns.map((addOn) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: ResponsiveUtils.getSpacing(context, 16),
                                  ),
                                  child: AddOnCardWidget(
                                    key: ValueKey(addOn.title),
                                    addOn: addOn,
                                    provider: provider,
                                    onLearnMore: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text(addOn.title),
                                          content: Text(addOn.description),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: Text("Close"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
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
                    MaterialPageRoute(builder: (_) => const DateTimePage()),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  // ✅ Default add-ons (fallback for Home Cleaning or other services)
  List<AddOnService> _getDefaultAddOns() {
    return [
      AddOnService(
        title: "Balcony Cleaning",
        description: "Get your balcony\nfreshly cleaned.",
        price: 19,
        originalPrice: 25,
        image: "balcony",
      ),
      AddOnService(
        title: "Ironing and Folding",
        description: "We will press and fold\nyour clothes.",
        price: 25,
        originalPrice: 30,
        image: "ironing",
      ),
      AddOnService(
        title: "Fridge Cleaning",
        description: "We will clean the\nrefrigerator inside out.",
        price: 19,
        originalPrice: 25,
        image: "fridge",
      ),
      AddOnService(
        title: "Wardrobe Cleaning",
        description: "Thorough cleaning and\narrangement for your...",
        price: 25,
        originalPrice: 30,
        image: "wardrobe",
      ),
    ];
  }
}