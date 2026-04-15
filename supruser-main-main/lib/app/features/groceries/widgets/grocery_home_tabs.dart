import 'package:flutter/material.dart';

class TabItem {
  final String label;
  final IconData icon;

  const TabItem({required this.label, required this.icon});
}

// ignore: unused_element
class _TabItemWidget extends StatelessWidget {
  final TabItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isFirst;

  const _TabItemWidget({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isFirst
              ? Colors.white
              : isSelected
                  ? Colors.green.shade100
                  : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon,
                color: isSelected ? Colors.green : Colors.black, size: 20),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                color: isSelected ? Colors.green : Colors.black,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 3,
              width: 24,
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

