import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/profile/widgets/custom_arrow_back.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomArrowBack(),
        title: Text('Notification',
            style: textTheme(context)
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: mylist.length,
          itemBuilder: (context, index) => _buildNotificationOption(
            context,
            mylist[index],
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(' Notifications tapped')),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationOption(
    BuildContext context,
    String title, {
    required Function() onTap,
  }) {
    return Card(
      elevation: 1,
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: textTheme(context).titleMedium,
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
