import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';

class CustomLeading extends StatelessWidget {
  final VoidCallback onTap;
  const CustomLeading({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.appGrey.withOpacity(0.6)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onTap,
      ),
    );
  }
}
