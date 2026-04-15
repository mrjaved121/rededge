import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suprapp/app/features/supr_pay/pages/sending_split_request.dart';
import '../../../core/utils/responsive_utils.dart';


class SplitAmountPage extends StatefulWidget {
  final double amount;
  final String description;
  final List<Map<String, dynamic>> selectedContacts;

  const SplitAmountPage({
    Key? key,
    required this.amount,
    required this.description,
    required this.selectedContacts,
  }) : super(key: key);

  @override
  State<SplitAmountPage> createState() => _SplitAmountPageState();
}

class _SplitAmountPageState extends State<SplitAmountPage> {
  late List<Map<String, dynamic>> _splits;
  final TextEditingController _messageController = TextEditingController();
  String _customMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeSplits();
  }

  void _initializeSplits() {
    final perPerson = widget.amount / widget.selectedContacts.length;
    _splits = widget.selectedContacts.map((contact) {
      return {
        'name': contact['name'],
        'initials': contact['initials'],
        'phone': contact['phone'],
        'amount': perPerson,
        'isPaid': contact['name'] == 'You',
      };
    }).toList();
  }

  void _showEditDialog() {
    final List<TextEditingController> controllers = _splits.map((split) {
      return TextEditingController(text: split['amount'].toStringAsFixed(0));
    }).toList();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          void updateRemainingAmount() {
            double totalEntered = 0;
            int peopleWithAmount = 0;

            for (int i = 0; i < controllers.length; i++) {
              final value = double.tryParse(controllers[i].text) ?? 0;
              if (value > 0) {
                totalEntered += value;
                peopleWithAmount++;
              }
            }

            double remainingAmount = widget.amount - totalEntered;
            int remainingPeople = _splits.length - peopleWithAmount;

            if (remainingPeople > 0 && remainingAmount > 0) {
              final autoAmount = remainingAmount / remainingPeople;
              for (int i = 0; i < _splits.length; i++) {
                final currentAmount = double.tryParse(controllers[i].text) ?? 0;
                if (currentAmount == 0) {
                  _splits[i]['amount'] = autoAmount;
                  controllers[i].text = autoAmount.toStringAsFixed(0);
                }
              }
            }
          }

          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getBorderRadius(context, 12)
                )
            ),
            contentPadding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 20)),
            title: Text(
                'Edit Amounts',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveUtils.adaptive(
                      context,
                      small: 16,
                      medium: 17,
                      large: 18,
                      tablet: 19,
                    )
                )
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _splits.asMap().entries.map((entry) {
                  final i = entry.key;
                  final split = entry.value;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ResponsiveUtils.getSpacing(context, 8)
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: ResponsiveUtils.getIconSize(context, base: 18),
                          backgroundColor: const Color(0xFFE8F5E9),
                          child: Text(
                              split['initials'],
                              style: TextStyle(
                                  color: const Color(0xFF34C759),
                                  fontWeight: FontWeight.bold,
                                  fontSize: ResponsiveUtils.adaptive(
                                    context,
                                    small: 11,
                                    medium: 12,
                                    large: 13,
                                    tablet: 14,
                                  )
                              )
                          ),
                        ),
                        SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
                        Expanded(
                          child: Text(
                            split['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: ResponsiveUtils.adaptive(
                                  context,
                                  small: 13,
                                  medium: 14,
                                  large: 15,
                                  tablet: 16,
                                )
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: ResponsiveUtils.wp(context, 25),
                          child: TextField(
                            controller: controllers[i],
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontSize: ResponsiveUtils.adaptive(
                                  context,
                                  small: 13,
                                  medium: 14,
                                  large: 15,
                                  tablet: 16,
                                )
                            ),
                            decoration: const InputDecoration(
                              prefixText: 'PKR ',
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                            onChanged: (value) {
                              setDialogState(() {
                                updateRemainingAmount();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: ResponsiveUtils.adaptive(
                          context,
                          small: 14,
                          medium: 15,
                          large: 16,
                          tablet: 17,
                        )
                    )
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < _splits.length; i++) {
                      final newAmount = double.tryParse(controllers[i].text) ?? 0;
                      _splits[i]['amount'] = newAmount;
                    }
                  });
                  Navigator.pop(context);
                },
                child: Text(
                    'Done',
                    style: TextStyle(
                        color: const Color(0xFF34C759),
                        fontSize: ResponsiveUtils.adaptive(
                          context,
                          small: 15,
                          medium: 16,
                          large: 17,
                          tablet: 18,
                        ),
                        fontWeight: FontWeight.w600
                    )
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showMessageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController dialogController = TextEditingController(text: _customMessage);

        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  ResponsiveUtils.getBorderRadius(context, 12)
              )
          ),
          contentPadding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Message',
                  style: TextStyle(
                      fontSize: ResponsiveUtils.adaptive(
                        context,
                        small: 15,
                        medium: 16,
                        large: 17,
                        tablet: 18,
                      ),
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
                TextField(
                  controller: dialogController,
                  autofocus: true,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Enter message to friend',
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: ResponsiveUtils.adaptive(
                          context,
                          small: 13,
                          medium: 14,
                          large: 15,
                          tablet: 16,
                        )
                    ),
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(
                        ResponsiveUtils.getSpacing(context, 12)
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: ResponsiveUtils.adaptive(
                        context,
                        small: 14,
                        medium: 15,
                        large: 16,
                        tablet: 17,
                      )
                  )
              ),
            ),
            TextButton(
              onPressed: () {
                if (dialogController.text.isNotEmpty) {
                  setState(() {
                    _customMessage = dialogController.text;
                  });
                }
                Navigator.pop(context);
              },
              child: Text(
                  'Save',
                  style: TextStyle(
                      color: const Color(0xFF34C759),
                      fontWeight: FontWeight.w600,
                      fontSize: ResponsiveUtils.adaptive(
                        context,
                        small: 14,
                        medium: 15,
                        large: 16,
                        tablet: 17,
                      )
                  )
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Split new expense',
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
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: ResponsiveUtils.getSpacing(context, 16)),
              child: Column(
                children: [
                  // Total Bill Card
                  Container(
                    margin: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
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
                            size: ResponsiveUtils.getIconSize(context, base: 24),
                          ),
                        ),
                        SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Total bill',
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
                                  widget.description,
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
                          'PKR ${widget.amount.toStringAsFixed(0)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ResponsiveUtils.adaptive(
                                context,
                                small: 15,
                                medium: 16,
                                large: 17,
                                tablet: 18,
                              )
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Split Expense With Card (Numbers List Only)
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.getSpacing(context, 16)
                    ),
                    padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          ResponsiveUtils.getBorderRadius(context, 12)
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'SPLIT EXPENSE WITH',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: ResponsiveUtils.adaptive(
                                  context,
                                  small: 11,
                                  medium: 12,
                                  large: 13,
                                  tablet: 14,
                                ),
                                fontWeight: FontWeight.w600
                            )
                        ),
                        SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),

                        // Contacts List Only
                        ..._splits.asMap().entries.map((entry) {
                          final split = entry.value;
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: ResponsiveUtils.getSpacing(context, 16)
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: ResponsiveUtils.getIconSize(context, base: 20),
                                  backgroundColor: const Color(0xFFE8F5E9),
                                  child: Text(
                                      split['initials'],
                                      style: TextStyle(
                                          color: const Color(0xFF34C759),
                                          fontWeight: FontWeight.bold,
                                          fontSize: ResponsiveUtils.adaptive(
                                            context,
                                            small: 11,
                                            medium: 12,
                                            large: 13,
                                            tablet: 14,
                                          )
                                      )
                                  ),
                                ),
                                SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
                                Expanded(
                                  child: Text(
                                    split['name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: ResponsiveUtils.adaptive(
                                          context,
                                          small: 13,
                                          medium: 14,
                                          large: 15,
                                          tablet: 16,
                                        )
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                    'PKR ${split['amount'].toStringAsFixed(0)}',
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
                                SizedBox(width: ResponsiveUtils.getSpacing(context, 8)),
                                Icon(
                                    split['isPaid'] ? Icons.check_circle : Icons.lock_open,
                                    color: split['isPaid'] ? Colors.green : Colors.grey,
                                    size: ResponsiveUtils.getIconSize(context, base: 20)
                                ),
                              ],
                            ),
                          );
                        }).toList(),

                        // Edit Amounts Button
                        Center(
                          child: TextButton(
                            onPressed: _showEditDialog,
                            child: Text(
                                'Edit amounts',
                                style: TextStyle(
                                    color: const Color(0xFF34C759),
                                    fontSize: ResponsiveUtils.adaptive(
                                      context,
                                      small: 15,
                                      medium: 16,
                                      large: 17,
                                      tablet: 18,
                                    ),
                                    fontWeight: FontWeight.w600
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Separate Message Card with proper spacing and centered text
                  if (_customMessage.isNotEmpty)
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          ResponsiveUtils.getSpacing(context, 16),
                          ResponsiveUtils.getSpacing(context, 20),
                          ResponsiveUtils.getSpacing(context, 16),
                          ResponsiveUtils.getSpacing(context, 8)
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: ResponsiveUtils.getSpacing(context, 20),
                          horizontal: ResponsiveUtils.getSpacing(context, 16)
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            ResponsiveUtils.getBorderRadius(context, 12)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _customMessage,
                          style: TextStyle(
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 15,
                              medium: 16,
                              large: 17,
                              tablet: 18,
                            ),
                            color: const Color(0xFF212529),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Bottom Section with Message Field and Split Button
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
            color: Colors.white,
            child: Row(
              children: [
                // Message Field Button
                GestureDetector(
                  onTap: _showMessageDialog,
                  child: Container(
                    width: ResponsiveUtils.getIconSize(context, base: 50),
                    height: ResponsiveUtils.getIconSize(context, base: 50),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(
                          ResponsiveUtils.getBorderRadius(context, 8)
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'A|',
                        style: TextStyle(
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 16,
                              medium: 18,
                              large: 20,
                              tablet: 22,
                            ),
                            color: Colors.grey,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),

                // Split Expense Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SendingSplitRequestPage(
                            amount: widget.amount,
                            description: widget.description,
                            splits: _splits,
                            customMessage: _customMessage,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF34C759),
                      padding: EdgeInsets.symmetric(
                          vertical: ResponsiveUtils.getSpacing(context, 16)
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              ResponsiveUtils.getBorderRadius(context, 8)
                          )
                      ),
                    ),
                    child: Text(
                        'Split expense',
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}