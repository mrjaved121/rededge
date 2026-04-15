import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/auth/provider/auth_provider.dart';
import 'package:suprapp/app/features/auth/provider/name_input_provider.dart';
import 'package:suprapp/app/routes/go_router.dart';
import 'package:suprapp/app/shared/widgets/custom_textformfield.dart';

class EnterNamePage extends StatefulWidget {
  const EnterNamePage({super.key});

  @override
  State<EnterNamePage> createState() => _EnterNamePageState();
}

class _EnterNamePageState extends State<EnterNamePage> {
  final TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final nameProvider = context.watch<NameInputProvider>();
    final authProvider = Provider.of<AuthProviders>(context);
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
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: nameProvider.isValid
                    ? () async {
                        final firebaseUser = FirebaseAuth.instance.currentUser;
                        await authProvider.saveUserToFirestore(
                            name: name.text,
                            context,
                            email: firebaseUser?.email);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: nameProvider.isValid
                      ? colorScheme(context).primary
                      : AppColors.appGrey,
                ),
                child: Text(
                  'Continue',
                  style: textTheme(context).bodyLarge?.copyWith(
                      color: nameProvider.isValid
                          ? colorScheme(context).surface
                          : AppColors.darkGrey,
                      fontWeight: FontWeight.w600),
                ),
              ),
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
              'Welcome to Supr!  What\'s  your name?',
              style: textTheme(context).headlineMedium?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 5),
            Text(
              'We will use your name to personalize the experience for you',
              style: textTheme(context).titleSmall?.copyWith(
                  color: AppColors.darkTextGrey, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: name,
              hint: 'Enter your name',
              horizontalPadding: 15,
              onChanged: (value) {
                context.read<NameInputProvider>().updateName(value);
              },
              hintSize: 16,
              hintColor: AppColors.darkGrey,
            ),
          ],
        ),
      ),
    );
  }
}
