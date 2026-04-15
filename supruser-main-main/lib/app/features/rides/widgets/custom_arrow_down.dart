import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';

class CustomArrowDown extends StatelessWidget {
  final VoidCallback onTap;
  const CustomArrowDown({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.appGrey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
          onTap: onTap,
          child: const Icon(Icons.arrow_downward_outlined, size: 15)),
    );
  }
}
