import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';

class SpecialRequestField extends StatefulWidget {
  @override
  _SpecialRequestFieldState createState() => _SpecialRequestFieldState();
}

class _SpecialRequestFieldState extends State<SpecialRequestField> {
  final TextEditingController _controller = TextEditingController();
  final int maxLength = 150;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          maxLength: maxLength,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "For example: less spicy, no sugar, etc",
            hintStyle: textTheme(context).titleMedium?.copyWith(
                color: AppColors.darkGrey.withOpacity(0.5),
                fontWeight: FontWeight.w600),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            counterText: "", // Hide default Flutter counter
          ),
          onChanged: (value) => setState(() {}),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "${_controller.text.length}/$maxLength",
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
