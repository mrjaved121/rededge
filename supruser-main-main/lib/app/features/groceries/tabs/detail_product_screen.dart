import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/groceries/controllers/herbal_provider.dart';
import 'package:suprapp/app/features/profile/widgets/custom_arrow_back.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context).selectedProduct;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(leading: const CustomArrowBack()),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(
                      product!.image,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: textTheme(context)
                                .displayMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.price,
                            style: textTheme(context)
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    product.condition,
                                    style: textTheme(context).bodyLarge,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.thermostat_outlined,
                                          size: 18),
                                      const SizedBox(width: 4),
                                      Text(
                                        product.cool,
                                        style: textTheme(context).bodyLarge,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (product.isHerbal!) ...[
                      const TabBar(
                        labelColor: Colors.teal,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.teal,
                        tabs: [
                          Tab(text: "Nutritional Info"),
                          Tab(text: "Ingredients"),
                        ],
                      ),
                      SizedBox(
                        height: 235,
                        child: TabBarView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Serving Size: 100 mL",
                                        style: textTheme(context)
                                            .bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 12),
                                    NutritionalRow(
                                        label: "Calories",
                                        value: product.calories!),
                                    NutritionalRow(
                                        label: "Protein",
                                        value: product.protein!),
                                    NutritionalRow(
                                        label: "Fat", value: product.fate!),
                                    NutritionalRow(
                                        label: "Sugar", value: product.sugar!),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customRow("Genger(${product.ginger})",
                                          "•", context),
                                      customRow(
                                          "Lemongrass(${product.lenongrass})",
                                          "•",
                                          context),
                                      customRow(
                                          "Lemon Peels (${product.lemonPeels})",
                                          "•",
                                          context),
                                      customRow("Licorice ", "•", context),
                                      customRow("Lemon Myrtle", "•", context),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      )
                    ]
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "AED ${product.price}",
                    style: textTheme(context)
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme(context).primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Add to basket",
                      style: textTheme(context)
                          .bodyMedium
                          ?.copyWith(color: AppColors.brightGreen),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customRow(String text, String dot, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Text(
            dot,
            style: textTheme(context).bodySmall,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: textTheme(context).bodySmall,
          )
        ],
      ),
    );
  }
}

class NutritionalRow extends StatelessWidget {
  final String label;
  final String value;

  const NutritionalRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
              child: Text(
            label,
            style: textTheme(context).bodySmall,
          )),
          Text(value, style: textTheme(context).bodySmall),
        ],
      ),
    );
  }
}
