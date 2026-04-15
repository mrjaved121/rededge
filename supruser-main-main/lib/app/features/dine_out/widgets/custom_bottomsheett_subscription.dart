import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

class SubscriptionBottomSheet extends StatelessWidget {
  final VoidCallback onSubscribe;

  const SubscriptionBottomSheet({
    super.key,
    required this.onSubscribe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Text(
            "AED 15 / month",
            style: textTheme(context).labelLarge,
          ),
          const SizedBox(height: 6),
          Text("Supr Plus",
              style: textTheme(context)
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          // Text(
          //   "You will be charged AED 15 now. Your subscription will automatically renew in 30 days using your selected payment method.",
          //   style: textTheme(context).labelLarge,
          // ),
          RichText(
              text: TextSpan(
                  text:
                      "You will be charged AED 15 now. Your subscription will automatically renew in 30 days using your selected payment method.",
                  style: textTheme(context).labelLarge,
                  children: [
                TextSpan(
                  text: "Terms and conditions apply.",
                  style: textTheme(context)
                      .labelLarge
                      ?.copyWith(color: colorScheme(context).primary),
                )
              ])),
          const SizedBox(height: 6),

          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add, color: Colors.green),
              ),
              const SizedBox(width: 10),
              Text("Add new card",
                  style: textTheme(context)
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),

          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.info, size: 15),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Your saved payment methods can't be used for this transaction. Tap for details.",
                    style: textTheme(context)
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                      border: Border.all(
                          color: const Color.fromARGB(255, 207, 206, 206))),
                  child: const Icon(Icons.arrow_forward, size: 15),
                )
              ],
            ),
          ),

          const SizedBox(height: 10),

          CustomElevatedButton(
            text: "Subscribe now",
            onPressed: onSubscribe,
          ),

          const SizedBox(height: 12),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "You can cancel anytime",
              style: textTheme(context)
                  .labelLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
