import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              context.pop();
            },
            child: const Icon(Icons.arrow_back, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              color: colorScheme(context).onSurface,
            ),
            const SizedBox(width: 8),
            Text(
              "5 items",
              style: textTheme(context).bodyLarge!.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                backgroundColor: colorScheme(context).primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    "View Cart",
                    style: textTheme(context).bodyMedium!.copyWith(
                          color: colorScheme(context).surface,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: colorScheme(context).surface,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product['image'],
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Center(
                            child: CircleAvatar(
                              radius: 3,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEE7FF),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Color(0xFF5B2EFF), size: 14),
                              const SizedBox(width: 2),
                              Text(
                                'Best Seller',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF5B2EFF),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product['title'],
                      style: textTheme(context).titleLarge!.copyWith(
                            color: colorScheme(context).onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product['portion'],
                      style: textTheme(context).bodyMedium!.copyWith(
                            color:
                                colorScheme(context).onSurface.withOpacity(0.3),
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          product['oldPrice'].toString(),
                          style: textTheme(context).bodyMedium!.copyWith(
                                color: colorScheme(context)
                                    .onSurface
                                    .withOpacity(0.3),
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          product['newPrice'].toString(),
                          style: textTheme(context).bodyMedium!.copyWith(
                                color: colorScheme(context).onSurface,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 204, 34, 22),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "14% off",
                            style: textTheme(context).labelMedium!.copyWith(
                                  color: colorScheme(context).surface,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme(context).primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "ADD",
                            style: textTheme(context).bodyLarge!.copyWith(
                                  color: colorScheme(context).surface,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 32,
                      color: AppColors.appGrey,
                    ),
                    Text("Description",
                        style: textTheme(context).titleLarge!.copyWith(
                              color: colorScheme(context).onSurface,
                              fontWeight: FontWeight.w700,
                            )),
                    const SizedBox(height: 10),
                    Text(
                      "Juicy grilled chicken and penne pasta tossed in a rich, creamy Alfredo sauce with sautéed veggies like bell peppers and broccoli. Finished with herbs and parmesan for that perfect comfort bite.",
                      style: textTheme(context).bodyLarge!.copyWith(
                            color:
                                colorScheme(context).onSurface.withOpacity(0.3),
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
