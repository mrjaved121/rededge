import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/dine_out/provider/faqs_provider.dart';

class FaqsPage extends StatefulWidget {
  const FaqsPage({super.key});

  @override
  State<FaqsPage> createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsPage> {
  final List<Map<String, dynamic>> faqData = [
    {
      'title': 'How do I subscribe?',
      'description':
          'To subscribe, go to the subscription page and choose your preferred plan.',
    },
    {
      'title': 'How to reset password?',
      'description':
          'Go to settings > account > reset password. Follow the instructions sent to your email.',
    },
    {
      'title': 'Can I cancel anytime?',
      'description':
          'Yes, you can cancel your subscription anytime from the app settings.',
    },
    {
      'title': 'Is there a free trial?',
      'description':
          'We offer a 7-day free trial for new users. Cancel before the trial ends to avoid charges.',
    },
    {
      'title': 'How do I contact support?',
      'description':
          'You can reach us via support@yourapp.com or through the help section in the app.',
    },
    {
      'title': 'What is the refund policy?',
      'description':
          'We do not offer refunds for unused time. Please read our full policy before subscribing.',
    },
    {
      'title': 'Can I change plans later?',
      'description':
          'Yes, you can switch plans anytime. Your new plan will activate after the current one ends.',
    },
    {
      'title': 'Is my data secure?',
      'description':
          'We use advanced encryption to ensure all your data is securely stored and transmitted.',
    },
    {
      'title': 'How to update my email?',
      'description':
          'Go to settings > profile > email and enter your new email address.',
    },
    {
      'title': 'Can I use this app offline?',
      'description':
          'Some features are available offline, but a connection is required for full functionality.',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: colorScheme(context).onSurface,
              size: 25,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'FAQs',
          style: textTheme(context).titleMedium?.copyWith(
                color: colorScheme(context).onSurface,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Consumer<FAQProvider>(builder: (context, provider, _) {
        return ListView.separated(
          itemCount: faqData.length,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            color: AppColors.appGrey,
          ),
          itemBuilder: (context, index) {
            final item = faqData[index];
            final isExpanded = provider.expandedIndex == index;

            return ExpansionTile(
              title: const Text(''),
              leading: Text(
                item['title'],
                style: textTheme(context).titleSmall?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              trailing: Icon(
                isExpanded ? Icons.remove : Icons.add,
                color: colorScheme(context).onSurface.withOpacity(0.7),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    item['description'],
                    style: textTheme(context).bodyLarge?.copyWith(
                          color: AppColors.darkGrey,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
              onExpansionChanged: (expanded) {
                context.read<FAQProvider>().toggleIndex(index);
              },
            );
          },
        );
      }),
    );
  }
}
