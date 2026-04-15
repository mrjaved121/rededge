import 'package:flutter/material.dart';

class CustomTabPageSelector extends StatelessWidget {
  final TabController controller;
  final Color selectedColor;
  final Color unselectedColor;
  final double width;
  final double height;
  final double borderRadius;

  const CustomTabPageSelector({
    super.key,
    required this.controller,
    this.selectedColor = Colors.white,
    this.unselectedColor = Colors.grey,
    this.width = 12.0,
    this.height = 8.0,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animation!,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(controller.length, (index) {
            final isSelected = index == controller.index;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: isSelected ? selectedColor : Colors.white,
                border: Border.all(
                  color: isSelected ? selectedColor : unselectedColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            );
          }),
        );
      },
    );
  }
}
