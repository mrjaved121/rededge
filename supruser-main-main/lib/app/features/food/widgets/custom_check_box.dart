import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;

  const CustomCheckbox({required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isChecked ? Colors.green : Colors.transparent,
        border: Border.all(
          color: isChecked ? Colors.green : Colors.grey.shade400,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child:
          isChecked ? Icon(Icons.check, size: 16, color: Colors.white) : null,
    );
  }
}
