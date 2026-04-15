import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

class SavedAddressPage extends StatefulWidget {
  const SavedAddressPage({super.key});

  @override
  State<SavedAddressPage> createState() => _SavedAddressPageState();
}

class _SavedAddressPageState extends State<SavedAddressPage> {
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
        title: Text(
          'Saved address',
          style: textTheme(context).titleMedium?.copyWith(
                color: colorScheme(context).onSurface,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Promo Banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme(context).primary, // Dark green
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Chip(
                              label: Text("New",
                                  style: textTheme(context)
                                      .bodyMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: colorScheme(context).surface)),
                              backgroundColor: Color(0xFF00C569),
                              padding: EdgeInsets.zero,
                            ),
                            SizedBox(width: 8),
                            Text("Add address photos",
                                style: textTheme(context).bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme(context).surface)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                            "Help our Captains find your location. Tap any address to add photos.",
                            style: textTheme(context).bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: colorScheme(context).surface)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Image.asset(
                    'assets/images/camera.png',
                    height: 50,
                    width: 50,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Saved Address
          ListTile(
            leading:
                Icon(Icons.home_outlined, color: colorScheme(context).primary),
            title: Text("Mona",
                style: textTheme(context).bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme(context).onSurface)),
            subtitle: Text("67, 4, Business Bay, Dubai",
                style: textTheme(context).bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme(context).onSurface)),
            trailing: const Icon(Icons.more_vert),
            onTap: () {
              // Handle tap to view/edit address
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomElevatedButton(
          text: 'add new address',
          onPressed: () {},
        ),
      ),
    );
  }
}
