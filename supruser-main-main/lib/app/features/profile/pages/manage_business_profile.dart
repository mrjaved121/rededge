import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/profile/pages/email_address_rides_report.dart';
import 'package:suprapp/app/features/profile/pages/get_ride_report_page.dart';
import 'package:suprapp/app/features/profile/pages/update_payement_method.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

class ManageBusinessProfilePage extends StatefulWidget {
  const ManageBusinessProfilePage({super.key});

  @override
  State<ManageBusinessProfilePage> createState() =>
      _ManageBusinessProfilePageState();
}

class _ManageBusinessProfilePageState extends State<ManageBusinessProfilePage> {
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
          'BUSINESS PROFILE',
          style: textTheme(context).titleMedium?.copyWith(
                color: colorScheme(context).onSurface,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment method',
              style: textTheme(context).titleSmall?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdatePaymentScreen(),
                    ));
              },
              child: Row(
                children: [
                  Icon(Icons.attach_money_outlined, color: Colors.grey),
                  SizedBox(width: 6),
                  Text(
                    'Cash',
                    style: textTheme(context).titleSmall?.copyWith(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.3),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: AppColors.appGrey,
            ),
            const SizedBox(height: 24),
            Text(
              'Ride reports',
              style: textTheme(context).titleSmall?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RideReportScreen(),
                    ));
              },
              child: Text(
                'Monthly',
                style: textTheme(context).titleSmall?.copyWith(
                      color: colorScheme(context).onSurface.withOpacity(0.3),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Email',
              style: textTheme(context).titleSmall?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmailAddressRidesReportPage(),
                    ));
              },
              child: Text(
                'zargulkhan920@gmail.com',
                style: textTheme(context).titleSmall?.copyWith(
                      color: colorScheme(context).onSurface.withOpacity(0.3),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 40),
            const Divider(
              thickness: 1,
              color: AppColors.appGrey,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0)), //this right here
                        child: Container(
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'Delete business profile',
                                    style: textTheme(context)
                                        .titleSmall
                                        ?.copyWith(
                                          color: colorScheme(context).onSurface,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    'Are you sure you want to delete your ',
                                    style: textTheme(context)
                                        .bodyLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: colorScheme(context)
                                                .onSurface
                                                .withOpacity(0.4)),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'business profile',
                                    style: textTheme(context)
                                        .bodyLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: colorScheme(context)
                                                .onSurface
                                                .withOpacity(0.4)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            const Color.fromARGB(
                                                255, 222, 36, 23)),
                                        fixedSize: MaterialStateProperty.all(
                                            Size(130,
                                                50)), // width: 150, height: 50
                                      ),
                                      child: Text(
                                        'No',
                                        style: textTheme(context)
                                            .bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: colorScheme(context)
                                                    .surface),
                                      ),
                                      onPressed: () {},
                                    ),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  colorScheme(context).primary),
                                          fixedSize: MaterialStateProperty.all(
                                              Size(130,
                                                  50)), // width: 150, height: 50
                                        ),
                                        child: Text(
                                          'Yes',
                                          style: textTheme(context)
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: colorScheme(context)
                                                      .surface),
                                        ),
                                        onPressed: () =>
                                            Navigator.pop(context)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
              child: Text(
                'Delete business profile',
                style: textTheme(context).titleSmall?.copyWith(
                      color: colorScheme(context).onSurface.withOpacity(0.3),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
