import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/food/widgets/food_card.dart';
import 'package:suprapp/app/features/food/widgets/item_selection_sheet.dart';
import 'package:suprapp/app/features/food/widgets/lists.dart';

class ProductScreen extends StatefulWidget {
  final String category;
  const ProductScreen({super.key, required this.category});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  void showItemSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ItemSelectionSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = categoryProducts[widget.category] ?? [];
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '${widget.category} Products',
            style: textTheme(context).titleMedium?.copyWith(
                color: colorScheme(context).onSurface,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: products.isEmpty
            ? const Center(child: Text("No products found"))
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio:
                              0.5, // Adjust based on your FoodCard height
                        ),
                        itemBuilder: (context, index) {
                          final p = products[index];
                          return InkWell(
                            onTap: () {
                              showItemSelectionBottomSheet(context);
                            },
                            child: FoodCard(
                              image: p['image'],
                              title: p['title'],
                              oldPrice: p['oldPrice'],
                              newPrice: p['newPrice'],
                              offerText: p['offerText'],
                              portion: p['portion'],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ));
  }

  Widget buildDrinkOption(
      String title, String subtitle, String price, bool selected,
      {bool enabled = true}) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: ListTile(
        leading: Icon(Icons.radio_button_checked,
            color: selected ? Colors.green : Colors.grey),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text("+ $price", style: TextStyle(color: Colors.green)),
        enabled: enabled,
        onTap: enabled ? () {} : null,
      ),
    );
  }
}
