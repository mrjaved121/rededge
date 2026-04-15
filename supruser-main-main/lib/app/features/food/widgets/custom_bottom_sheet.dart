import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

class GroupOrderBottomSheet extends StatelessWidget {
  const GroupOrderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Group Orders made easy',
            style: textTheme(context)
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Share your unique link through any social platform such as WhatsApp or Facebook',
            style:
                textTheme(context).bodyMedium?.copyWith(color: Colors.black54),
          ),
          const SizedBox(height: 10),
          const GroupOrderStep(
            title: 'Share the link with your friends',
            description: 'Invite friends and start ordering.',
          ),
          const GroupOrderStep(
            title: 'Friends add their items to the basket',
            description: 'Everyone can see what others are adding.',
          ),
          const GroupOrderStep(
            title: 'Pay a single delivery fee',
            description: 'Pay one delivery fee and enjoy your meal.',
          ),
          CustomElevatedButton(
              text: "Share your Group order", onPressed: () {}),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () => context.pop(),
              child: Text(
                'Cancel',
                style: textTheme(context).bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GroupOrderStep extends StatelessWidget {
  final String title;
  final String description;

  const GroupOrderStep({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
          radius: 5, backgroundColor: colorScheme(context).primary),
      title: Text(title,
          style: textTheme(context)
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold)),
      subtitle: Text(description,
          style: textTheme(context)
              .bodyMedium
              ?.copyWith(color: Colors.black.withOpacity(0.4))),
    );
  }
}
