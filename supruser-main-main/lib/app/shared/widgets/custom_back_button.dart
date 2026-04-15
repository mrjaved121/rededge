import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomBackButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
        backgroundColor: WidgetStatePropertyAll(colorScheme(context).onPrimary),
      ),
      onPressed: onPressed,
      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 18,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
