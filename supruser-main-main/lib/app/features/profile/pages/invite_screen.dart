import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/profile/widgets/custom_arrow_back.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomArrowBack(),
        title: Text('Invite Friends',
            style: textTheme(context)
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AppImages.invite,
                fit: BoxFit.contain,
                cacheHeight: 200,
              ),
              const SizedBox(height: 20),
              Text('Invite friend and get 25,000 coin',
                  textAlign: TextAlign.center,
                  style: textTheme(context)
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae dictum turpis',
                textAlign: TextAlign.center,
                style: textTheme(context).bodyLarge,
              ),
              const SizedBox(height: 24),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: imageList.length,
                itemBuilder: (context, index) => _buildInfoItem(
                  context,
                  image: imageList[index],
                  text:
                      'Lorem ipsum consectetur adipiscing elit. Sed vitae dictum turpis',
                ),
              ),
              const SizedBox(height: 30),
              CustomElevatedButton(
                  text: "Got it",
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Invite link copied to clipboard!'),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required String image,
    required String text,
  }) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(image, fit: BoxFit.cover),
        ),
      ),
      title: Expanded(
        child: Text(
          text,
          style: textTheme(context).bodyLarge,
        ),
      ),
    );
  }
}
