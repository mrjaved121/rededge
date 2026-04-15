import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productImage;
  final String productName;
  //final String productDescription;
  final String price;
  final String? originalPrice;
  final String? discount; // 💡 نیا ڈسکاؤنٹ پیرامیٹر

  const ProductDetailScreen({
    super.key,
    required this.productImage,
    required this.productName,
 //required this.productDescription,
    required this.price,
    this.originalPrice,
    this.discount, // یہاں اسے کنسٹرکٹر میں شامل کیا گیا
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool showQuantityField = false;
  int quantity = 1;

  // Helper method to build the discount chip
  Widget _buildDiscountChip(String? discount) {
    if (discount == null || discount.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFE91E63), // Card se liya gaya color
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        discount,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            // Image Background Color
            backgroundColor: Colors.grey[100],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.productImage,
                child: Image.asset(widget.productImage, fit: BoxFit.contain),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20), // Top padding adjust kia
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title
                  Text(
                    widget.productName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Price, Original Price, and Discount Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Discounted Price
                      Text(
                        widget.price,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE91E63), // Card ka color
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Original Price (Line-through)
                      if (widget.originalPrice != null)
                        Text(
                          widget.originalPrice!,
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[500],
                            fontSize: 16,
                          ),
                        ),
                      const SizedBox(width: 8),
                      // Discount Percentage Chip
                      _buildDiscountChip(widget.discount), // 💡 discount ko use kia
                    ],
                  ),

                  const SizedBox(height: 24),

                  // 💡 START: Tab Bar Implementation (Tabs, Alignment, and Content)
                  DefaultTabController(
                    length: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tab Alignment
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const TabBar(
                            isScrollable: true,
                            labelColor: AppColors.appGreen,
                            unselectedLabelColor: Colors.black54,
                            indicatorColor: AppColors.appGreen,
                            indicatorWeight: 4,
                            labelPadding: EdgeInsets.only(right: 20),
                            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            tabs: [
                              Tab(text: 'Core Specification'),
                              Tab(text: 'Warranty'),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // The Tab Content
                        SizedBox(
                          height: 150,
                          child: TabBarView(
                            children: [
                              // 1. Content for 'Core Specifications' tab
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Size: 15.6"'),
                                  SizedBox(height: 8),
                                  Text('Weight: 1.8 kg'),
                                  SizedBox(height: 8),
                                  Text('Storage: 512GB SSD'),
                                  SizedBox(height: 8),
                                  Text('RAM: 16GB DDR4'),
                                ],
                              ),

                              // 2. Content for 'Warranty' tab
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Duration: 2 Years'),
                                  SizedBox(height: 8),
                                  Text('Type: Limited Hardware Warranty'),
                                  SizedBox(height: 8),
                                  Text('Service: On-site Support'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 💡 END: Tab Bar Implementation

                  const SizedBox(height: 32),

                  // Checkout Button or Quantity (Kept as is)
                  if (!showQuantityField) ...[
                    Row(
                      children: [
                        Text(
                          widget.price,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: AppColors.appGreen,
                          ),
                        ),
                        const SizedBox(width: 100),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showQuantityField = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.hardGreen,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Add to basket',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.lightGreen,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity--;
                                } else {
                                  showQuantityField = false;
                                  quantity = 1;
                                }
                              });
                            },
                          ),
                          Text(
                            '$quantity',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}