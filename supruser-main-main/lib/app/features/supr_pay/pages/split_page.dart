import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/supr_pay_provider.dart';  // ✅ PROVIDER IMPORT ADD
import 'package:suprapp/app/features/supr_pay/pages/split_new_expense.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../state/app.dart';
import 'expense_detail_page.dart';

class SplitHistoryPage extends StatefulWidget {
  const SplitHistoryPage({Key? key}) : super(key: key);

  @override
  State<SplitHistoryPage> createState() => _SplitHistoryPageState();
}

class _SplitHistoryPageState extends State<SplitHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SuprPayProvider>(  // ✅ CONSUMER ADD KAREN
      builder: (context, provider, child) {
        // ✅ PROVIDER SE EXPENSE HISTORY LE SAKTE HAIN
        // Agar aapke provider mein expenseHistory nahi hai to pehle usko add karen
        final expenseHistory = provider.transactions.where(
                (transaction) => transaction['description']?.toString().contains('Split expense') ?? false
        ).toList();

        print('Split History Page - Total expenses: ${expenseHistory.length}');

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: ResponsiveUtils.getIconSize(context, base: 24),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Split history',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: ResponsiveUtils.adaptive(
                    context,
                    small: 18,
                    medium: 20,
                    large: 22,
                    tablet: 24,
                  ),
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: expenseHistory.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                          Icons.history,
                          size: ResponsiveUtils.getIconSize(context, base: 64),
                          color: Colors.grey
                      ),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
                      Text(
                          'No expense history yet',
                          style: TextStyle(
                              fontSize: ResponsiveUtils.adaptive(
                                context,
                                small: 15,
                                medium: 16,
                                large: 17,
                                tablet: 18,
                              ),
                              color: Colors.grey
                          )
                      ),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
                      Text(
                          'Tap below to split a new expense',
                          style: TextStyle(
                              fontSize: ResponsiveUtils.adaptive(
                                context,
                                small: 13,
                                medium: 14,
                                large: 15,
                                tablet: 16,
                              ),
                              color: Colors.grey
                          )
                      ),
                    ],
                  ),
                )
                    : ListView.builder(
                  padding: ResponsiveUtils.responsivePadding(
                      context,
                      horizontal: 16,
                      vertical: 16
                  ),
                  itemCount: expenseHistory.length,
                  itemBuilder: (context, index) {
                    final expense = expenseHistory[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExpenseDetailPage(expense: expense, index: index),
                          ),
                        ).then((_) => setState(() {}));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: ResponsiveUtils.getSpacing(context, 12)),
                        padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              ResponsiveUtils.getBorderRadius(context, 12)
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 12)),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.getBorderRadius(context, 8)
                                ),
                              ),
                              child: Icon(
                                Icons.compare_arrows,
                                color: const Color(0xFF34C759),
                                size: ResponsiveUtils.getIconSize(context, base: 20),
                              ),
                            ),
                            SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      expense['description'] ?? 'Split Expense',  // ✅ NULL SAFETY
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: ResponsiveUtils.adaptive(
                                            context,
                                            small: 15,
                                            medium: 16,
                                            large: 17,
                                            tablet: 18,
                                          )
                                      )
                                  ),
                                  SizedBox(height: ResponsiveUtils.getSpacing(context, 4)),
                                  Text(
                                      'PKR ${expense['amount']?.toStringAsFixed(0) ?? '0'}',  // ✅ NULL SAFETY
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: ResponsiveUtils.adaptive(
                                            context,
                                            small: 13,
                                            medium: 14,
                                            large: 15,
                                            tablet: 16,
                                          )
                                      )
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              expense['status'] ?? 'Pending',  // ✅ NULL SAFETY
                              style: TextStyle(
                                color: (expense['status'] == 'Paid') ? const Color(0xFF34C759) : Colors.orange,
                                fontWeight: FontWeight.w600,
                                fontSize: ResponsiveUtils.adaptive(
                                  context,
                                  small: 13,
                                  medium: 14,
                                  large: 15,
                                  tablet: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: ResponsiveUtils.responsivePadding(
                    context,
                    horizontal: 16,
                    vertical: 16
                ),
                height: ResponsiveUtils.getButtonHeight(context, base: 85),
                color: Colors.white,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SplitNewExpensePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF34C759),
                      padding: EdgeInsets.symmetric(
                          vertical: ResponsiveUtils.getSpacing(context, 16)
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              ResponsiveUtils.getBorderRadius(context, 35)
                          )
                      ),
                    ),
                    child: Text(
                        'Split new expense',
                        style: TextStyle(
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 15,
                              medium: 16,
                              large: 17,
                              tablet: 18,
                            ),
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}