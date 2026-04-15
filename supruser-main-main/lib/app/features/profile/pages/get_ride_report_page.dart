import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

class RideReportScreen extends StatefulWidget {
  @override
  _RideReportScreenState createState() => _RideReportScreenState();
}

class _RideReportScreenState extends State<RideReportScreen> {
  String? selectedOption;

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
          'GET RIDE REPORTS',
          style: textTheme(context).titleMedium?.copyWith(
                color: colorScheme(context).onSurface,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              'Receive a summary of all your business rides\nin one document to make expensing a breeze',
              style: textTheme(context).bodyLarge?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.2),
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: 30),
            buildOption('Monthly'),
            buildOption('Weekly'),
            buildOption('Never'),
            SizedBox(
              height: 40,
            ),
            Text(
              'You can still generate ride reports manually by\nexporting selected rides from your ride history',
              style: textTheme(context).bodyLarge?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.2),
                    fontWeight: FontWeight.w600,
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

  Widget buildOption(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = title;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textTheme(context).titleSmall?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            if (selectedOption == title)
              Icon(Icons.check,
                  color: Color(0xFF2EBE4F)) // Show tick only if selected
          ],
        ),
      ),
    );
  }
}
