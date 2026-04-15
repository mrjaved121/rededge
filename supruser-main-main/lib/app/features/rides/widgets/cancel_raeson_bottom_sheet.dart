import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/rides/provider/cancel_provider.dart';

class CancelReasonBottomSheet extends StatelessWidget {
  const CancelReasonBottomSheet({super.key});

  final List<String> reasons = const [
    "I want to change my booking details",
    "I don't need a ride anymore",
    "I found another ride",
    "I booked by mistake",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CancelReasonProvider(),
      child: Consumer<CancelReasonProvider>(
        builder: (context, provider, _) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Text("Tell us why you want to cancel",
                    style: textTheme(context)
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                ...reasons.map((reason) {
                  return RadioListTile<String>(
                    value: reason,
                    groupValue: provider.selectedReason,
                    onChanged: (value) {
                      provider.selectReason(value!);
                    },
                    title: Text(
                      reason,
                      style: textTheme(context)
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    contentPadding: EdgeInsets.zero,
                  );
                }).toList(),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: provider.isSubmitEnabled
                        ? () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Reason: ${provider.selectedReason}')),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: provider.isSubmitEnabled
                          ? Colors.black
                          : Colors.grey[300],
                      foregroundColor: provider.isSubmitEnabled
                          ? Colors.white
                          : Colors.black54,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Submit",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
