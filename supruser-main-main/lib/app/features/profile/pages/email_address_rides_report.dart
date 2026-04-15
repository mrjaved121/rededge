import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

class EmailAddressRidesReportPage extends StatefulWidget {
  const EmailAddressRidesReportPage({super.key});

  @override
  State<EmailAddressRidesReportPage> createState() =>
      _EmailAddressRidesReportPageState();
}

class _EmailAddressRidesReportPageState
    extends State<EmailAddressRidesReportPage> {
  TextEditingController emailController = TextEditingController();
  bool showClear = true;

  @override
  void initState() {
    super.initState();
    emailController.text = "zargulkhan920@gmail.com";
    emailController.addListener(() {
      setState(() {
        showClear = emailController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter an email address to receive automated\nride reports, or to export selected rides\nanytime.',
              style: textTheme(context).bodyLarge?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.3),
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: 30),

            // Label
            Text(
              'Enter email address',
              style: textTheme(context).bodySmall?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.3),
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: 8),

            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: '',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: UnderlineInputBorder(),
                  ),
                ),
                if (showClear)
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.grey),
                    onPressed: () {
                      emailController.clear();
                    },
                  ),
              ],
            ),

            SizedBox(height: 8),
            Text(
              'Enter an email address to continue',
              style: textTheme(context).bodyMedium?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.3),
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
}
