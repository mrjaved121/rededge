import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/profile/controller/language_controller.dart';
import 'package:suprapp/app/features/profile/widgets/custom_arrow_back.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final languageController = context.watch<LanguageController>();
    return Scaffold(
      appBar: AppBar(
        leading: const CustomArrowBack(),
        title: Text('Chose Language',
            style: textTheme(context)
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                setState(() {
                  languageController.selectLanguage("English");
                });
              },
              child: _buildLanguageOption(
                'English',
                languageController.selectedLanguage == 'English',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language, bool isSelected) {
    return Card(
      child: ListTile(
        title: Text(language, style: textTheme(context).titleMedium),
        trailing: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isSelected ? Colors.red : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: isSelected
              ? const Icon(Icons.check, size: 14, color: Colors.white)
              : null,
        ),
      ),
    );
  }
}
