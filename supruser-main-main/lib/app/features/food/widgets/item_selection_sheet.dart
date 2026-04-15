import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/auth/pages/biometric_setup_page.dart';
import 'package:suprapp/app/features/food/provider/drink_selection_provider.dart';
import 'package:suprapp/app/features/food/widgets/custom_check_box.dart';
import 'package:suprapp/app/routes/go_router.dart';

class ItemSelectionSheet extends StatefulWidget {
  @override
  _ItemSelectionSheetState createState() => _ItemSelectionSheetState();
}

class _ItemSelectionSheetState extends State<ItemSelectionSheet> {
  int quantity = 1;

  List<Map<String, dynamic>> beverages = [
    {
      'name': 'Thums Up Can',
      'subtitle': '300 ml | Chilled',
      'price': 38,
      'img':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSc3T0H33J95_Tsxyi45Kox3LWM--sIOhTRCQ&s',
    },
    {
      'name': 'Coca Cola Can',
      'subtitle': '300 ml | Chilled',
      'price': 38,
      'img':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRR0MH6ckatw1HVkJBLCiti3FQliK4yutHNQ&s',
    },
    {
      'name': 'Sprite Can',
      'subtitle': '300 ml | Chilled',
      'price': 38,
      'img':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz2BVUtFDrkBP6x6JD6M1NHcYX3-t9i39YIg&s',
    },
    {
      'name': 'Vedica Water Bottle',
      'subtitle': '1L | Chilled',
      'price': 57,
      'img':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7teed9-bhBg0XNURjfZtzKwm6lexT1XImSw&s',
    },
    {
      'name': 'Diet Coke Can',
      'subtitle': '300 ml | Chilled',
      'price': 38,
      'img':
          'https://www.ubuy.com.pk/productimg/?image=aHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0kvNTF3WXY5dWEycUwuX1NTNDAwXy5qcGc.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final selectionProvider = Provider.of<DrinkSelectionProvider>(context);

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: colorScheme(context).surface,
                    border: Border.all(
                        color: colorScheme(context).primary, width: 1.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: 3,
                      backgroundColor: colorScheme(context).primary,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Pani Puri",
                  style: textTheme(context).titleMedium?.copyWith(
                      color: colorScheme(context).onSurface.withOpacity(0.4),
                      fontWeight: FontWeight.w700),
                ),
                Spacer(),
                CircleAvatar(
                  radius: 15,
                  backgroundColor:
                      colorScheme(context).onSurface.withOpacity(0.1),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: 15,
                        color: colorScheme(context).onSurface.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Beverages",
              style: textTheme(context).titleMedium?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              "Your preferred drink?",
              style: textTheme(context).bodyMedium?.copyWith(
                  color: colorScheme(context).onSurface.withOpacity(0.4),
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: beverages.length,
                itemBuilder: (context, index) {
                  final item = beverages[index];
                  final isSelected = selectionProvider.isSelected(index);

                  return ListTile(
                    onTap: () => selectionProvider.toggleSelection(index),
                    leading: Image.network(item['img'], height: 40),
                    title: Text(item['name']),
                    subtitle: Text(item['subtitle']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("+ ₹${item['price']}"),
                        SizedBox(width: 12),
                        CustomCheckbox(isChecked: isSelected),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove,
                            color: colorScheme(context).primary),
                        onPressed: () {
                          if (quantity > 1) setState(() => quantity--);
                        },
                      ),
                      Text(
                        '$quantity',
                        style: textTheme(context).bodyLarge?.copyWith(
                            color: colorScheme(context).primary,
                            fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                        icon: Icon(Icons.add,
                            color: colorScheme(context).primary),
                        onPressed: () {
                          setState(() => quantity++);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.pushNamed(AppRoute.orderConfirmationPage);
                      print(selectionProvider.selectedItems);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme(context).primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      "Add items",
                      style: textTheme(context).bodyLarge?.copyWith(
                          color: colorScheme(context).surface,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
