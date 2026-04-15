import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/dine_out/controller/filter_controller.dart';

class FilterButton extends StatelessWidget {
  final String label;

  const FilterButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final isSelected = context.watch<FilterProvider>().isSelected(label);

    return GestureDetector(
      onTap: () {
        context.read<FilterProvider>().toggleFilter(label);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme(context).primary : Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label == 'Nearby') ...[
              Icon(Icons.swap_vert_outlined,
                  color: isSelected ? Colors.white : Colors.black, size: 16),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: textTheme(context).bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
