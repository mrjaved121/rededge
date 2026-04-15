import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/profile/model/setting_model.dart';
import 'package:suprapp/app/features/profile/widgets/custom_arrow_back.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomArrowBack(),
        title: Text('Account Settings',
            style: textTheme(context)
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Account',
                style: textTheme(context)
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListView.builder(
              itemCount: settingsOptions.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final option = settingsOptions[index];
                return _buildSettingOption(
                  context: context,
                  title: option['title'],
                  onTap: () => option['onTap'](context),
                  isLast: index == settingsOptions.length - 1,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSettingOption({
    required BuildContext context,
    required String title,
    required Function() onTap,
    bool isLast = false,
  }) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(title, style: textTheme(context).titleMedium),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
      ),
    );
  }
}
