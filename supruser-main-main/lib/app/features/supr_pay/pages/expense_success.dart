import '../../../state/app.dart';
import 'package:flutter/material.dart';
import 'package:suprapp/app/features/supr_pay/pages/split_new_expense.dart';
import 'package:suprapp/app/features/supr_pay/pages/split_page.dart';

import '../data/expense_dart.dart';

class ExpenseSuccessPage extends StatelessWidget {
  final double amount;
  final String description;
  final List<Map<String, dynamic>> splits;
  final String customMessage;

  const ExpenseSuccessPage({
    Key? key,
    required this.amount,
    required this.description,
    required this.splits,
    required this.customMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Expense details',
          style: TextStyle(color: Color(0xFF34C759), fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Share', style: TextStyle(color: Color(0xFF34C759), fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 2,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(Icons.circle, color: Color(0xFF34C759), size: 12),
                          Icon(Icons.close, color: Color(0xFF34C759), size: 20),
                          Icon(Icons.circle, color: Color(0xFF34C759), size: 12),
                          Icon(Icons.close, color: Color(0xFF34C759), size: 20),
                          Icon(Icons.circle, color: Color(0xFF34C759), size: 12),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Color(0xFF34C759),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check, color: Colors.white, size: 40),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Awesome! Your expense split\nrequest for $description (PKR ${amount.toStringAsFixed(0)})\nwas sent successfully.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 32),
                      ...splits.map((split) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: const Color(0xFFE8F5E9),
                                child: Text(split['initials'], style: const TextStyle(color: Color(0xFF34C759), fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(split['name'], style: const TextStyle(fontWeight: FontWeight.w600)),
                                    Text('PKR ${split['amount'].toStringAsFixed(2)}', style: const TextStyle(color: Colors.grey, fontSize: 14)),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    split['isPaid'] ? 'Paid' : 'Outstanding',
                                    style: TextStyle(
                                      color: split['isPaid'] ? const Color(0xFF34C759) : Colors.orange,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (split['isPaid']) const SizedBox(width: 8),
                                  if (split['isPaid']) const Icon(Icons.check, color: Color(0xFF34C759), size: 20),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      if (splits.any((s) => !s['isPaid'])) ...[
                        const SizedBox(height: 16),
                        Row(
                          children: const [
                            Icon(Icons.info_outline, color: Colors.grey, size: 20),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'We sent a link to download Careem',
                                style: TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const SplitNewExpensePage()),
                            (route) => false,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Color(0xFF34C759)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Split another', style: TextStyle(color: Color(0xFF34C759), fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Add to history
                      print('Adding expense to history: $description');
                      expenseHistory.add({
                        'description': description,
                        'amount': amount,
                        'date': DateTime.now(),
                        'status': 'Pending',
                        'splits': splits,
                        'customMessage': customMessage,
                      });
                      print('Total expenses in history: ${expenseHistory.length}');

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const SplitHistoryPage()),
                            (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF34C759),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Back to home', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}