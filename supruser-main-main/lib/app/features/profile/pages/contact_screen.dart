import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/profile/widgets/custom_arrow_back.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';
import 'package:suprapp/app/shared/widgets/custom_textformfield.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomArrowBack(),
        title: Text('Contact Us',
            style: textTheme(context)
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text(
                'Contact us for Ride share',
                style: textTheme(context).headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                'Address',
                style: textTheme(context).titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'House# 72, Road# 21, Banani, Dhaka-1213 (near Banani Bidyaniketon School & College, beside University of South Asia)',
                style: textTheme(context)
                    .titleSmall
                    ?.copyWith(color: AppColors.blackGrey.withOpacity(0.4)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Call : 13301 (24/7)',
                style: textTheme(context)
                    .titleSmall
                    ?.copyWith(color: AppColors.blackGrey.withOpacity(0.4)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'Email : support@pathao.com',
                style: textTheme(context)
                    .titleSmall
                    ?.copyWith(color: AppColors.blackGrey.withOpacity(0.4)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              Text(
                'Send Message',
                style: textTheme(context).titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Form Fields
              CustomTextFormField(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                hint: "Name",
                hintColor: Colors.grey,
                controller: nameController,
                fillColor: colorScheme(context).onPrimary,
                focusBorderColor: AppColors.appGrey,
              ),
              const SizedBox(height: 16),

              CustomTextFormField(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                hint: "Email",
                hintColor: Colors.grey,
                controller: emailController,
                fillColor: colorScheme(context).onPrimary,
                focusBorderColor: AppColors.appGrey,
              ),
              const SizedBox(height: 16),
              IntlPhoneField(
                controller: phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.appGrey),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: AppColors.appGrey)),
                ),
                initialCountryCode: 'US',
                onChanged: (phone) {},
              ),
              const SizedBox(height: 16),

              CustomTextFormField(
                hint: "Write your text",
                maxline: 5,
                fillColor: colorScheme(context).onPrimary,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                controller: messageController,
              ),
              const SizedBox(height: 24),
              CustomElevatedButton(text: "Send Message", onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
