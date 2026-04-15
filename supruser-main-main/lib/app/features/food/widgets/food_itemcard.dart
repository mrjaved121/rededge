import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/food/provider/food_item_provider.dart';
import 'package:suprapp/app/features/food/widgets/special_req-field.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

class FoodItemCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final double oldPrice;
  final int discount;

  const FoodItemCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.oldPrice,
    required this.discount,
  });

  @override
  State<FoodItemCard> createState() => _FoodItemCardState();
}

class _FoodItemCardState extends State<FoodItemCard> {
  int? selectedIndex;
  final List<Map<String, dynamic>> combos = [
    {"label": "French Fries & Diet Pepsi", "price": 16},
    {"label": "French Fries & Pepsi", "price": 16},
    {"label": "French Fries & Mountain Dew", "price": 16},
    {"label": "French Fries & Mirinda Orange", "price": 16},
    {"label": "French Fries & 7 Up Zero", "price": 16},
    {"label": "French Fries & 7 Up", "price": 16},
  ];

  int quantity = 0;

  void increaseQty() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQty() {
    setState(() {
      if (quantity > 0) quantity--;
    });
  }

  void showShawarmaBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.9,
            minChildSize: 0.6,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Consumer<FoodItemProvider>(
                builder: (context, provider, _) {
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Top Image
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20)),
                                child: Image.asset(
                                  widget.imageUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.title,
                                      style: textTheme(context)
                                          .titleLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      widget.description,
                                      style: textTheme(context)
                                          .bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      widget.price.toString(),
                                      style: textTheme(context)
                                          .bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: colorScheme(context)
                                                  .onSurface),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF8F9FA),
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Select your own choices:",
                                        style: textTheme(context)
                                            .titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Make it a combo:",
                                        style: textTheme(context)
                                            .titleSmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Select up to 1 option",
                                        style: textTheme(context)
                                            .bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black54),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: combos.length,
                                      separatorBuilder: (_, __) =>
                                          Divider(color: Colors.grey.shade300),
                                      itemBuilder: (context, index) {
                                        final combo = combos[index];
                                        return GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    combo['label'],
                                                    style: textTheme(context)
                                                        .bodyLarge
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black54,
                                                        ),
                                                  ),
                                                ),

                                                Text(
                                                  "+ AED ${combo['price']}",
                                                  style: textTheme(context)
                                                      .titleSmall
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                ),

                                                const SizedBox(width: 8),

                                                // Radio Button
                                                Radio<int>(
                                                  value: index,
                                                  groupValue:
                                                      provider.selectedIndex,
                                                  onChanged: (val) => provider
                                                      .selectCombo(val!),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.edit_note_outlined,
                                                color: Colors.black),
                                            const SizedBox(width: 6),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Special requests",
                                                  style: textTheme(context)
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                ),
                                                Text(
                                                  "Got any requests for the restaurant?",
                                                  style: textTheme(context)
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black54,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    SpecialRequestField(),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Bottom sticky bar
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey, width: 0.5)),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            // Quantity button
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: AppColors.darkGrey,
                                      size: 15,
                                    ),
                                    onPressed: provider.decreaseQty,
                                  ),
                                  Text(provider.quantity.toString(),
                                      style: textTheme(context)
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                colorScheme(context).onSurface,
                                          )),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      size: 15,
                                      color: AppColors.darkGrey,
                                    ),
                                    onPressed: provider.increaseQty,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Add Button
                            Expanded(
                              child: CustomElevatedButton(
                                text: 'Add • AED 59',
                                onPressed: () {
                                  if (provider.quantity == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Please select a quantity before adding.'),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
                                  } else {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Item added to cart successfully.'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                    style: textTheme(context)
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  widget.description,
                  style: textTheme(context).bodySmall,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text("AED ${widget.price.toStringAsFixed(2)}",
                        style: textTheme(context)
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Text("AED ${widget.oldPrice.toStringAsFixed(0)}",
                        style: textTheme(context).labelMedium?.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.carmineRed,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text("Save ${widget.discount}%",
                          style: textTheme(context).labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    )
                  ],
                )
              ],
            ),
          ),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  widget.imageUrl,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              GestureDetector(
                onTap: () {
                  showShawarmaBottomSheet(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 65, left: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      border: Border.all(color: Colors.black.withOpacity(0.2))),
                  child: Text(
                    "Add",
                    style: textTheme(context)
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
