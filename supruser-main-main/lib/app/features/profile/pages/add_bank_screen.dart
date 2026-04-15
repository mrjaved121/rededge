import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/profile/controller/bank_controller.dart';
import 'package:suprapp/app/features/profile/widgets/custom_arrow_back.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';
import 'package:suprapp/app/shared/widgets/custom_textformfield.dart';

class AddBankAccountScreen extends StatefulWidget {
  const AddBankAccountScreen({super.key});

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  final TextEditingController _accountNumberController =
      TextEditingController();
  String? _selectedBank;

  final List<String> _banks = [
    'Bank Central Asia',
    'Bank Mandiri',
    'Bank Negara Indonesia',
    'Bank Rakyat Indonesia',
    'CIMB Niaga',
    'Bank Danamon',
    'Bank Permata',
  ];

  @override
  void dispose() {
    _accountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bankProvider = Provider.of<BankProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const CustomArrowBack(),
        title: Text('Add New Bank Account',
            style: textTheme(context)
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bank Name',
                style: textTheme(context)
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField<String>(
                value: bankProvider.selectedBank,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: InputBorder.none,
                  hintText: 'Choose bank',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey.shade400,
                ),
                onChanged: (value) {
                  bankProvider.setSelectedBank(value);
                },
                items: _banks.map((bank) {
                  return DropdownMenuItem<String>(
                    value: bank,
                    child: Text(bank),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Account number field
            Text('Account Number',
                style: textTheme(context)
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            CustomTextFormField(
              controller: _accountNumberController,
              fillColor: colorScheme(context).onPrimary,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              hint: "Enter Account number",
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            const Spacer(),

            CustomElevatedButton(
                text: "CONFIRM",
                onPressed: () {
                  if (_selectedBank != null &&
                      _accountNumberController.text.isNotEmpty) {
                    // Perform validation and submission
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Bank account added successfully'),
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields')),
                    );
                  }
                }),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
