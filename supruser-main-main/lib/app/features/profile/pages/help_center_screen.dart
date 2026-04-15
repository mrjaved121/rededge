import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/profile/widgets/custom_arrow_back.dart';
import 'package:suprapp/app/shared/widgets/custom_textformfield.dart';

class WinRewardScreen extends StatelessWidget {
  const WinRewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    TextEditingController recommendationController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: const CustomArrowBack(),
        title: Text('Win Reward',
            style: textTheme(context)
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [AppColors.appOrange, Colors.deepOrange],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Text('G',
                            style: textTheme(context).titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context).onPrimary)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('247.000', style: textTheme(context).headlineSmall),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text('History',
                          style: textTheme(context)
                              .bodySmall
                              ?.copyWith(decoration: TextDecoration.underline)),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Text('Redeem Reward',
                    style: textTheme(context)
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: controller,
                  hint: "Enter code or select voucher",
                ),
                const SizedBox(height: 25),
                Text('Recommendations',
                    style: textTheme(context)
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                CustomTextFormField(
                  controller: recommendationController,
                  maxline: 6,
                ),
                const SizedBox(height: 15),

                // Voucher Card
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.appGrey),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            color: const Color(0xFFF7C94A),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('VOUCHER NAME',
                                    style: textTheme(context)
                                        .titleLarge
                                        ?.copyWith(
                                            color: colorScheme(context)
                                                .onPrimary)),
                                const SizedBox(height: 4),
                                Text('Limited time offer',
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color: colorScheme(context)
                                                .onPrimary)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('70%',
                                    style: textTheme(context)
                                        .headlineSmall
                                        ?.copyWith(
                                            color:
                                                colorScheme(context).primary)),
                                const SizedBox(height: 10),
                                Container(
                                    height: 2,
                                    width: 40,
                                    color: colorScheme(context).primary),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
