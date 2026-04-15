import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/features/groceries/controllers/herbal_provider.dart';
import 'package:suprapp/app/features/groceries/controllers/product_quantity_provider.dart';
import 'package:suprapp/app/features/groceries/models/product_model.dart';
import 'package:suprapp/app/routes/go_router.dart';
import 'product_card.dart';

class ProductSection extends StatelessWidget {
  final String title;
  final List<ProductModleherbal> products;
  final bool isHerbal;
  final VoidCallback? onSectionTap;
  final Widget? listView;
  final Widget? isShow;

  const ProductSection({
    super.key,
    required this.title,
    required this.products,
    this.isHerbal = false,
    this.onSectionTap,
    this.listView,
    this.isShow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        isShow ??
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: onSectionTap,
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          // child: ListView.builder(
          //   scrollDirection: Axis.horizontal,
          //   itemCount: products.length,
          //   itemBuilder: (context, index) {
          //     final item = products[index];
          //     final id = item.id; // ✅ Use unique product id here
          //     final quantity =
          //         context.watch<QuantityProvider>().getQuantity(id);
          //     final totalPrice =
          //         context.watch<QuantityProvider>().getTotalPrice(id);

          //     return ProductCard(
          //       id: item.id,
          //       addWidget: Positioned(
          //         bottom: 6,
          //         right: 6,
          //         child: AnimatedSwitcher(
          //           duration: const Duration(milliseconds: 300),
          //           switchInCurve: Curves.linear,
          //           switchOutCurve: Curves.linear,
          //           transitionBuilder: (child, animation) {
          //             return SlideTransition(
          //               position: Tween<Offset>(
          //                 begin: const Offset(1.0, 0.0),
          //                 end: Offset.zero,
          //               ).animate(animation),
          //               child: FadeTransition(opacity: animation, child: child),
          //             );
          //           },
          //           child: quantity > 0
          //               ? Container(
          //                   key: const ValueKey('quantity_controls'),
          //                   padding: const EdgeInsets.symmetric(
          //                       horizontal: 8, vertical: 6),
          //                   decoration: BoxDecoration(
          //                     color: Colors.white,
          //                     borderRadius: BorderRadius.circular(8),
          //                     border: Border.all(color: Colors.black12),
          //                     boxShadow: [
          //                       BoxShadow(
          //                         color: Colors.black12.withOpacity(0.05),
          //                         blurRadius: 4,
          //                         offset: const Offset(0, 2),
          //                       ),
          //                     ],
          //                   ),
          //                   child: Column(
          //                     mainAxisSize: MainAxisSize.min,
          //                     children: [
          //                       Row(
          //                         mainAxisSize: MainAxisSize.min,
          //                         children: [
          //                           InkWell(
          //                             borderRadius: BorderRadius.circular(20),
          //                             onTap: () {
          //                               if (quantity == 1) {
          //                                 context
          //                                     .read<QuantityProvider>()
          //                                     .remove(id);
          //                               } else {
          //                                 context
          //                                     .read<QuantityProvider>()
          //                                     .decrease(
          //                                       id,
          //                                       double.parse(item.price),
          //                                     );
          //                               }
          //                             },
          //                             child: Icon(
          //                               quantity == 1
          //                                   ? Icons.delete
          //                                   : Icons.remove,
          //                               size: 20,
          //                               color: quantity == 1
          //                                   ? Colors.red
          //                                   : Colors.black,
          //                             ),
          //                           ),
          //                           const SizedBox(width: 12),
          //                           Text(
          //                             quantity.toString(),
          //                             style: const TextStyle(
          //                               fontWeight: FontWeight.bold,
          //                               fontSize: 16,
          //                             ),
          //                           ),
          //                           const SizedBox(width: 12),
          //                           InkWell(
          //                             borderRadius: BorderRadius.circular(20),
          //                             onTap: () {
          //                               context
          //                                   .read<QuantityProvider>()
          //                                   .increase(
          //                                     id,
          //                                     double.parse(item.price),
          //                                     item,
          //                                   );
          //                             },
          //                             child: const Icon(Icons.add, size: 20),
          //                           ),
          //                         ],
          //                       ),
          //                       const SizedBox(height: 4),
          //                       // Agar price dikhani ho to ye uncomment karein
          //                       // Text(
          //                       //   '₹${totalPrice.toStringAsFixed(2)}',
          //                       //   style: const TextStyle(
          //                       //     fontSize: 14,
          //                       //     color: Colors.green,
          //                       //     fontWeight: FontWeight.w600,
          //                       //   ),
          //                       // ),
          //                     ],
          //                   ),
          //                 )
          //               : InkWell(
          //                   key: const ValueKey('add_button'),
          //                   borderRadius: BorderRadius.circular(8),
          //                   onTap: () {
          //                     context.read<QuantityProvider>().decrease(
          //                           id,
          //                           double.parse(item.price),
          //                         );
          //                   },
          //                   child: Container(
          //                     height: 32,
          //                     width: 32,
          //                     decoration: BoxDecoration(
          //                       color: Colors.white,
          //                       borderRadius: BorderRadius.circular(8),
          //                       border: Border.all(color: Colors.black12),
          //                     ),
          //                     child: const Icon(Icons.add, size: 20),
          //                   ),
          //                 ),
          //         ),
          //       ),
          //       title: item.title,
          //       price: item.price,
          //       discount: item.discount,
          //       oldPrice: item.old,
          //       showOldPrice: isHerbal,
          //       imageUrl: item.image,
          //       onTap: () {
          //         Provider.of<ProductProvider>(context, listen: false)
          //             .setSelectedProduct(item);
          //         context.pushNamed(AppRoute.detailproduct);
          //       },
          //     );
          //   },
          // ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final item = products[index];
              final id = item.id;
              final quantity =
                  context.watch<QuantityProvider>().getQuantity(id);
              final totalPrice =
                  context.watch<QuantityProvider>().getTotalPrice(id);

              return ProductCard(
                id: item.id,
                addWidget: Positioned(
                  bottom: 6,
                  right: 6,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.linear,
                    switchOutCurve: Curves.linear,
                    transitionBuilder: (child, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: quantity > 0
                        ? Container(
                            key: const ValueKey('quantity_controls'),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        if (quantity == 1) {
                                          context
                                              .read<QuantityProvider>()
                                              .remove(id);
                                        } else {
                                          context
                                              .read<QuantityProvider>()
                                              .decrease(
                                                  id, double.parse(item.price));
                                        }
                                      },
                                      child: Icon(
                                        quantity == 1
                                            ? Icons.delete
                                            : Icons.remove,
                                        size: 20,
                                        color: quantity == 1
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      quantity.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        context
                                            .read<QuantityProvider>()
                                            .increase(
                                              id,
                                              double.parse(item.price),
                                              item,
                                            );
                                      },
                                      child: const Icon(Icons.add, size: 20),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                // Optional: Show total price
                                // Text(
                                //   '₹${totalPrice.toStringAsFixed(2)}',
                                //   style: const TextStyle(
                                //     fontSize: 14,
                                //     color: Colors.green,
                                //     fontWeight: FontWeight.w600,
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        : InkWell(
                            key: const ValueKey('add_button'),
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              context.read<QuantityProvider>().increase(
                                    id,
                                    double.parse(item.price),
                                    item,
                                  );
                            },
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: const Icon(Icons.add, size: 20),
                            ),
                          ),
                  ),
                ),
                title: item.title,
                price: 'AED' + item.price,
                discount: item.discount,
                oldPrice: item.old,
                showOldPrice: isHerbal,
                imageUrl: item.image,
                onTap: () {
                  Provider.of<ProductProvider>(context, listen: false)
                      .setSelectedProduct(item);
                  context.pushNamed(AppRoute.detailproduct);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
