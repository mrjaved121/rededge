import 'package:flutter/material.dart';
import 'package:suprapp/app/features/groceries/widgets/grocery_home_tabs.dart';
import 'package:suprapp/app/features/groceries/widgets/tab_item_widget.dart';

class CustomTabBar extends StatelessWidget {
  final List<TabItem> tabItems;
  final int selectedIndex;
  final ValueChanged<int> onTabTap;

  const CustomTabBar({super.key, 
    required this.tabItems,
    required this.selectedIndex,
    required this.onTabTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: tabItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: TabItemWidget(
              item: tabItems[index],
              isSelected: selectedIndex == index,
              onTap: () => onTabTap(index),
              isFirst: index == 0,
            ),
          );
        },
      ),
    );
  }
}
