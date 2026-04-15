import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/profile/widgets/custom_arrow_back.dart';

class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({super.key});

  @override
  State<SelectCountryScreen> createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  String selectedCountry = 'United States Of America';
  final List<Map<String, dynamic>> countries = [
    {'name': 'United States Of America', 'flag': AppImages.english},
    {'name': 'United Kingdom of Saudia', 'flag': AppImages.arabic},
    {'name': 'French', 'flag': AppImages.french},
    {'name': 'Turkey', 'flag': AppImages.turkish},
    {'name': 'Dutch', 'flag': AppImages.dutch},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomArrowBack(),
        title: Text('Select Country',
            style: textTheme(context)
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            ...countries.map((country) {
              final isSelected = country['name'] == selectedCountry;
              return Column(
                children: [
                  _buildCountryOption(
                    country['name'],
                    country['flag'],
                    isSelected,
                    onTap: () {
                      setState(() {
                        selectedCountry = country['name'];
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCountryOption(
    String countryName,
    String flagAsset,
    bool isSelected, {
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            flagAsset,
            width: 28,
            height: 20,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(countryName, style: textTheme(context).titleSmall),
        trailing: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.appGreen : AppColors.appGrey,
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
