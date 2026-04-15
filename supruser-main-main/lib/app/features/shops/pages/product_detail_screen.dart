import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/shops/models/shop_cart_model.dart';
import 'package:suprapp/app/features/shops/models/shop_products_model.dart';
import 'package:suprapp/app/features/shops/pages/cart_page.dart';
import 'package:suprapp/app/shared/widgets/custom_back_button.dart';

import 'package:uuid/uuid.dart';

class ProductDetailScreen extends StatefulWidget {
  final ShopProductsModel shopProductsModel;
  const ProductDetailScreen({super.key, required this.shopProductsModel});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  bool _isExpanded = false;
  final String description =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quis scelerisque sit eu, gravida quis. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae. Sed vehicula dui ut diam pretium, at commodo ex malesuada.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(4.0)),
                      //         border: Border.all(
                      //           color: Color(0xffB8B8B8),
                      //         )),
                      //     padding: EdgeInsets.all(5.0),
                      //     child: Icon(
                      //       Icons.arrow_back_ios_new,
                      //       size: 18,
                      //     ),
                      //   ),
                      // ),
                      CustomBackButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => CartPage(),
                          ));
                        },
                        icon: Icon(Icons.shopping_cart_outlined),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 275,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: 3,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Image.network(
                          widget.shopProductsModel.productImage,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        );
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 300,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme(context).onPrimary,
                        boxShadow: [
                          BoxShadow(
                              // color: colorScheme(context)
                              //     .onSurface
                              //     .withValues(alpha: 0.1),
                              // blurRadius: 5,
                              // spreadRadius: 2,
                              ),
                        ],
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(40)),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          // // put stepper
                          // SmoothPageIndicator(
                          //   controller: _pageController,
                          //   count: 3,
                          //   effect: ExpandingDotsEffect(
                          //     dotHeight: 8,
                          //     dotWidth: 8,
                          //     activeDotColor: AppColors.appOrange,
                          //     dotColor: AppColors.lightGrey,
                          //   ),
                          // ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.shopProductsModel.productName,
                                    style: textTheme(context)
                                        .headlineLarge
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Rose Garden",
                                    style: textTheme(context)
                                        .bodyLarge
                                        ?.copyWith(color: AppColors.lightGrey),
                                  )
                                ],
                              ),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: decrementQuantity,
                                    icon: SvgPicture.asset(AppIcon.minusIcon),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                      border: Border.all(
                                          color: colorScheme(context).outline),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 14.0),
                                    child: Text(
                                      quantity.toString(),
                                      style: textTheme(context)
                                          .titleLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: incrementQuantity,
                                    icon: SvgPicture.asset(AppIcon.plusIcon),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Size",
                                    style: textTheme(context).bodyLarge,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.shopProductsModel.size,
                                    style: textTheme(context).titleLarge,
                                  )
                                ],
                              ),
                              Container(
                                height: 28,
                                width: 2,
                                decoration:
                                    BoxDecoration(color: AppColors.lightGrey),
                              ),
                              Text(
                                widget.shopProductsModel.amount,
                                style: textTheme(context).titleLarge,
                              ),
                              Container(
                                height: 28,
                                width: 2,
                                decoration:
                                    BoxDecoration(color: AppColors.lightGrey),
                              ),
                              // Column(
                              //   mainAxisSize: MainAxisSize.min,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text(
                              //       "Arrive",
                              //       style: textTheme(context).bodyLarge,
                              //     ),
                              //     SizedBox(
                              //       height: 5,
                              //     ),
                              //     Text(
                              //       "10-12 Min",
                              //       style: textTheme(context).titleLarge,
                              //     )
                              //   ],
                              // ),
                            ],
                          ),
                          // SizedBox(
                          //   height: 20.0,
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              child: RichText(
                                text: TextSpan(
                                  style: textTheme(context).bodyLarge,
                                  children: [
                                    TextSpan(
                                      text: _isExpanded
                                          ? widget.shopProductsModel
                                              .productDescription
                                          : widget
                                                      .shopProductsModel
                                                      .productDescription
                                                      .length >
                                                  100
                                              ? widget.shopProductsModel
                                                      .productDescription
                                                      .substring(0, 100) +
                                                  '...'
                                              : widget.shopProductsModel
                                                  .productDescription,
                                    ),
                                    if (widget.shopProductsModel
                                            .productDescription.length >
                                        100)
                                      TextSpan(
                                        text: _isExpanded
                                            ? " show less"
                                            : " read more",
                                        style: textTheme(context)
                                            .bodyLarge
                                            ?.copyWith(
                                                color: AppColors.appOrange),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            setState(() {
                                              _isExpanded = !_isExpanded;
                                            });
                                          },
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(
                          //     "Ingredients",
                          //     style: textTheme(context).titleLarge,
                          //   ),
                          // ),
                          SizedBox(
                            height: 10.0,
                          ),
                          // GridView.builder(
                          //   shrinkWrap: true,
                          //   physics: NeverScrollableScrollPhysics(),
                          //   gridDelegate:
                          //       SliverGridDelegateWithFixedCrossAxisCount(
                          //     crossAxisCount: 4,
                          //     crossAxisSpacing: 10,
                          //     mainAxisSpacing: 10,
                          //     childAspectRatio: 0.8,
                          //   ),
                          //   itemCount: ingredients.length,
                          //   itemBuilder: (context, index) {
                          //     final item = ingredients[index];
                          //     return _buildIngredientIcon(
                          //       item["icon"] as String,
                          //       item["label"] as String,
                          //       context,
                          //       item["isAllergy"] as bool,
                          //     );
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme(context).onPrimary,
                      boxShadow: [
                        BoxShadow(
                            // color: colorScheme(context)
                            //     .onSurface
                            //     .withValues(alpha: 0.1),
                            // blurRadius: 5,
                            // spreadRadius: 2,
                            ),
                      ],
                    ),
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ' ${widget.shopProductsModel.price.toString()}\$',
                          style: textTheme(context).displayMedium,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final product = widget.shopProductsModel;
                            var csid = Uuid();
                            final String cartId = csid.v4();

                            final cartItem = ShopCartModel(
                              id: cartId,
                              name: product.productName,
                              imageUrl: product.productImage,

                              price:
                                  double.tryParse(product.price.toString()) ??
                                      0.0,
                              count: quantity,
                              foodItemId: product
                                  .productId, // use actual field name from model
                            );

                            try {
                              context.loaderOverlay.show();

                              await FirebaseFirestore.instance
                                  .collection('Shop Carts')
                                  .doc(cartId)
                                  .set(cartItem.toMap());
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => CartPage(),
                              ));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Added to cart!")),
                              );
                              context.loaderOverlay.hide();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("Failed to add to cart: $e")),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme(context).primary,
                            foregroundColor: colorScheme(context).onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 2,
                            minimumSize: Size(218, 47),
                          ),
                          child: Text(
                            'Add to cart',
                            style: textTheme(context).titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: colorScheme(context).onPrimary),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}

Widget _buildIngredientIcon(
    String iconPath, String label, BuildContext context, bool isAllergy) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.appLightOrange,
        ),
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(iconPath),
      ),
      const SizedBox(height: 5.0),
      Text(
        label,
        style:
            textTheme(context).bodySmall?.copyWith(color: AppColors.lightGrey),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 1.0),
      if (isAllergy)
        Text(
          '(Allergy)',
          style: textTheme(context)
              .bodySmall
              ?.copyWith(color: AppColors.lightGrey),
          textAlign: TextAlign.center,
        ),
    ],
  );
}
