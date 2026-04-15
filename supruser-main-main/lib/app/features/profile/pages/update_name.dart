import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/core/constants/static_data.dart';
import 'package:suprapp/app/features/auth/provider/auth_provider.dart';
import 'package:suprapp/app/features/profile/widgets/custom_arrow_back.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';
import 'package:suprapp/app/shared/widgets/custom_textformfield.dart';

class UpdateName extends StatelessWidget {
  const UpdateName({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    final authProvider = Provider.of<AuthProviders>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const CustomArrowBack(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Update Your Name",
              style: textTheme(context)
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Your name make it easy for captions to confirm who they're picking up",
              style: textTheme(context).bodySmall,
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              hint: "Enter your full name",
              controller: controller,
              hintColor: AppColors.appGrey,
              focusBorderColor: AppColors.appGrey,
              fillColor: colorScheme(context).onPrimary,
              contentPadding: const EdgeInsets.all(16),
            ),
            const Spacer(),
            CustomElevatedButton(
                text: "Update",
                onPressed: () async {
                  final gender = StaticData.model?.gender ?? '';
                  final gmail = StaticData.model?.email ?? '';
                  final dateBirth = StaticData.model?.dateOfBirth ?? '';

                  final phone = StaticData.model!.phone ?? '';
                  await authProvider.updateDobAndGender(
                      name: controller.text,
                      context: context,
                      dob:
                          dateBirth, // Use current DOB or '' if not yet selected
                      gender: gender,
                      phoneNo: phone,
                      email: gmail);
                  context.pop();
                })
          ],
        ),
      ),
    );
  }
}
