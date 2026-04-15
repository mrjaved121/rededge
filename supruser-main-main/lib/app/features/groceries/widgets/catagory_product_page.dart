import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/features/groceries/controllers/herbal_provider.dart';
import 'package:suprapp/app/features/groceries/models/item_model.dart';
import 'package:suprapp/app/features/groceries/widgets/detail_screen.dart';
import 'package:suprapp/app/features/groceries/widgets/product_card.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryTitle;
  final List<ProductItem> products;

  const CategoryProductsScreen({
    super.key,
    required this.categoryTitle,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(categoryTitle)),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final item = products[index];
              return ProductCard(
                id: item.id,
                title: item.name,
                price: item.price,
                discount: '20',
                oldPrice: '100',
                showOldPrice: true,
                imageUrl: item.imageUrl,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ItemDetailPage(
                        productItem: item,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ));
  }
}
