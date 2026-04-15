import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/features/shops/models/shop_cart_model.dart';
import 'package:suprapp/app/features/shops/pages/shops_screen.dart';
import 'package:suprapp/app/shared/widgets/custom_back_button.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

import '../../../core/utils/custom_snackbar.dart';

// Sample data model
class CartItem {
  final String id;
  final String title;
  final double price;
  final String imagePath;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
  });
}

class CartPage extends StatefulWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cartItems = [
    CartItem(
      id: '1',
      title: '4 bunch of banana (300g)',
      price: 3.45,
      imagePath: AppImages.banana,
    ),
    CartItem(
      id: '1',
      title: '4 bunch of banana (300g)',
      price: 3.45,
      imagePath: AppImages.banana,
    ),
    CartItem(
      id: '1',
      title: '4 bunch of banana (300g)',
      price: 3.45,
      imagePath: AppImages.banana,
    ),
    CartItem(
      id: '1',
      title: '4 bunch of banana (300g)',
      price: 3.45,
      imagePath: AppImages.banana,
    ),
    CartItem(
      id: '1',
      title: '4 bunch of banana (300g)',
      price: 3.45,
      imagePath: AppImages.banana,
    ),
    CartItem(
      id: '1',
      title: '4 bunch of banana (300g)',
      price: 3.45,
      imagePath: AppImages.banana,
    ),
    CartItem(
      id: '1',
      title: '4 bunch of banana (300g)',
      price: 3.45,
      imagePath: AppImages.banana,
    ),
  ];

  Future<List<ShopCartModel>> fetchCartItems() async {
    context.loaderOverlay.show();
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('Shop Carts').get();
      context.loaderOverlay.hide();
      return snapshot.docs.map((doc) {
        return ShopCartModel.fromMap(doc.data());
      }).toList();
    } catch (e) {
      print('Error fetching cart items: $e');
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: CustomBackButton(
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Cart"),
        centerTitle: true,
        actions: [
          // IconButton(
          //   onPressed: () {
          //     // Navigate to orders page
          //   },
          //   icon: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       SvgPicture.asset(AppIcon.ordersIcon),
          //       const SizedBox(width: 3),
          //       Text("Orders",
          //           style: textTheme(context).titleMedium),
          //     ],
          //   ),
          // ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<ShopCartModel>>(
              future: fetchCartItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                final cartItem = snapshot.data ?? [];

                if (cartItem.isEmpty) {
                  return Center(child: Text("Cart is empty"));
                }

                return ListView.builder(
                  itemCount: cartItem.length,
                  itemBuilder: (context, index) {
                    final item = cartItem[index];
                    return CartItemWidget(
                      cart: item,
                      onQuantityChanged: (newQuantity) {
                        // updateItemQuantity(item.count, newQuantity);
                      },
                    );
                  },
                );
              })),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomElevatedButton(
          text: "Go to Checkout",
          onPressed: () {
            showSnackbar(message: 'Order Sucessfully');
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ShopsScreen(),
            ));
          },
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final ShopCartModel cart;
  final ValueChanged<int> onQuantityChanged;

  const CartItemWidget({
    Key? key,
    required this.cart,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                height: 110,
                width: 115,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).colorScheme.outline,
                ),
                child: Center(
                  child: Image.network(
                    cart.imageUrl,
                    height: 60,
                    width: 75,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cart.name,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "\$${cart.price.toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 5,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: Theme.of(context).colorScheme.onPrimary,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => onQuantityChanged(cart.count - 1),
                    icon: Icon(
                        cart.count == 1 ? Icons.delete_outline : Icons.remove,
                        size: 18),
                  ),
                  Text(
                    "${cart.count}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => onQuantityChanged(cart.count + 1),
                    icon: const Icon(Icons.add, size: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
