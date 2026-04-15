import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseDetailPage extends StatefulWidget {
  final Map<String, dynamic> expense;
  final int index;
  final VoidCallback? onUpdate;

  const ExpenseDetailPage({
    Key? key,
    required this.expense,
    required this.index,
    this.onUpdate,
  }) : super(key: key);

  @override
  State<ExpenseDetailPage> createState() => _ExpenseDetailPageState();
}

class _ExpenseDetailPageState extends State<ExpenseDetailPage> {

  void _showReminderSent(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reminder sent', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87,
        duration: Duration(seconds: 2),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  String _formatTime(DateTime date) {
    final hour = date.hour > 12 ? date.hour - 12 : date.hour;
    final amPm = date.hour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $amPm, ${date.day} ${_getMonthName(date.month)} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PKR ${(widget.expense['amount'] ?? 0).toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                            widget.expense['description'] ?? 'No Description',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatTime(widget.expense['date'] ?? DateTime.now()),
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.compare_arrows, color: Color(0xFF34C759)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('EXPENSE SPLIT DETAILS', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),

                  if (widget.expense['splits'] != null && widget.expense['splits'] is List)
                    ...(widget.expense['splits'] as List<Map<String, dynamic>>).map((split) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: const Color(0xFFE8F5E9),
                              child: Text(
                                  split['initials'] ?? '?',
                                  style: const TextStyle(color: Color(0xFF34C759), fontWeight: FontWeight.bold)
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(split['name'] ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                                  Text('PKR ${(split['amount'] ?? 0).toStringAsFixed(0)}', style: const TextStyle(color: Colors.grey, fontSize: 14)),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  (split['isPaid'] ?? false) ? 'Paid' : 'Outstanding',
                                  style: TextStyle(
                                    color: (split['isPaid'] ?? false) ? const Color(0xFF34C759) : Colors.orange,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (split['isPaid'] ?? false) const SizedBox(width: 8),
                                if (split['isPaid'] ?? false) const Icon(Icons.check, color: Color(0xFF34C759), size: 20),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                  if (widget.expense['customMessage'] != null && widget.expense['customMessage'].toString().isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    const Text('MESSAGE', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text(widget.expense['customMessage'].toString(), style: const TextStyle(fontSize: 14)),
                  ],

                  const SizedBox(height: 24),
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: () => _showReminderSent(context),
                      icon: const Icon(Icons.notifications_outlined, color: Color(0xFF34C759)),
                      label: const Text('Send reminder', style: TextStyle(color: Color(0xFF34C759), fontSize: 16, fontWeight: FontWeight.w600)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        side: const BorderSide(color: Color(0xFFE8F5E9), width: 2),
                        backgroundColor: const Color(0xFFE8F5E9),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}