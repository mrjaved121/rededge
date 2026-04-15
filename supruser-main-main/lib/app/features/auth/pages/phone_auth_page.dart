import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/auth/provider/auth_provider.dart';
import 'package:suprapp/app/features/auth/provider/phone_input_provider.dart';
import 'package:suprapp/app/routes/go_router.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final TextEditingController phoneNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final phoneProvider = Provider.of<PhoneInputProvider>(context);
    phoneNumber.text = phoneProvider.phone;
    phoneNumber.selection = TextSelection.fromPosition(
      TextPosition(offset: phoneNumber.text.length),
    );
    return Scaffold(
      appBar: AppBar(
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                context.pushNamed(AppRoute.contactUsPage);
              },
              child: Container(
                height: 50,
                width: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.appGrey),
                    borderRadius: BorderRadius.circular(7)),
                child: const Icon(
                  Icons.headphones,
                  color: AppColors.darkGrey,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 130,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 5),
            ),
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        child: ClipRRect(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (phoneProvider.phone.trim().isEmpty)
              CustomElevatedButton(
                height: 50,
                width: 300,
                text: 'Continue',
                buttonColor: colorScheme(context).outline,
                textStyle: textTheme(context).titleSmall?.copyWith(
                      color: colorScheme(context).surface,
                      fontWeight: FontWeight.w800,
                    ),
                onPressed: () {
                  if (phoneProvider.phone.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Please enter phone number"),
                        backgroundColor: colorScheme(context).error,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }

                  context.pushNamed(AppRoute.verifyPhoneAuthPage);
                },
              )
            else
              CustomElevatedButton(
                height: 50,
                width: 300,
                text: 'Continue',
                buttonColor: colorScheme(context).primary,
                textStyle: textTheme(context).titleSmall?.copyWith(
                      color: colorScheme(context).surface,
                      fontWeight: FontWeight.w800,
                    ),
                onPressed: () {
                  if (phoneProvider.phone.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Please enter phone number"),
                        backgroundColor: colorScheme(context).error,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }
                  Provider.of<AuthProviders>(context, listen: false)
                      .sendWhatsAppOtp(context);
                },
              ),
            const SizedBox(height: 50)
          ],
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your Phone Number',
              style: textTheme(context).headlineMedium?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 5),
            Text(
              'We need to send you a code to verify your phone number',
              style: textTheme(context).titleSmall?.copyWith(
                  color: AppColors.darkTextGrey, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  phoneProvider.countryFlag,
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(width: 6),
                InkWell(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: true,
                      onSelect: (Country country) {
                        phoneProvider.updateCountry(
                          country.countryCode,
                          '+${country.phoneCode}',
                          country.flagEmoji,
                        );
                      },
                      countryListTheme: CountryListThemeData(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.only(top: 30.0),
                        borderRadius: BorderRadius.zero
                      )
                    );
                  },
                  child: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.darkGrey,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  phoneProvider.countryCode,
                  style: textTheme(context).titleMedium?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: TextFormField(
                    controller: phoneNumber,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16.0),
                      hintText: '346 77357881',
                      hintStyle: textTheme(context).titleMedium?.copyWith(
                          color: AppColors.darkGrey.withOpacity(0.5),
                          fontWeight: FontWeight.w600),
                      suffixIcon: phoneProvider.phone.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: AppColors.appGrey,
                              ),
                              onPressed: () => phoneProvider.clearPhone(),
                            )
                          : null,
                    ),
                    onChanged: phoneProvider.updatePhone,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
